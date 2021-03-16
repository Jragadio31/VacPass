
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';

class History extends StatefulWidget{
  @override 
  HistoryView createState() => HistoryView();
}

class HistoryView extends State<History>{
  Map data;
 final db = FirebaseFirestore.instance;
 final auth = FirebaseAuth.instance;
 CollectionReference users = FirebaseFirestore.instance.collection('VacpassHistory');
  
  List<Address> addr = [];
  Address _addr;

  String convertDate(Timestamp time){
    Timestamp _dateofVaccination = time;
    DateTime _datevaccined = _dateofVaccination.toDate();
    return _datevaccined.month.toString() +'/'+ _datevaccined.day.toString() + '/' + _datevaccined.year.toString();
  }

  Address convertGeoPointToCoordinate(GeoPoint point) {
    Address address ;
    Coordinates coordinates = new Coordinates(point.latitude, point.longitude);
    coordinatesToAddress(coordinates).then((value) => { address = value });
    return address;
  }

  Future<Address> coordinatesToAddress(Coordinates coordinates) async{
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          
          return Text('Something went wrong');
          
        }
        if (snapshot.connectionState == ConnectionState.waiting) {

          return Text("");
        }
        
        return  Container(
          child: !snapshot.hasData? animate() :
            Scaffold(
              appBar: 
                AppBar(
                  title: Text('History', style: TextStyle(color: Colors.pinkAccent,fontSize: 28),), 
                  automaticallyImplyLeading: false, 
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
              body: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {             
                 if(document.data()['Verifier_uid'].toString() == auth.currentUser.uid){
                     return new ListTile(
                      title: new Text(convertDate(document.data()['Date'])),
                      subtitle: new Text(convertGeoPointToCoordinate(document.data()['Location'])?.addressLine ?? 'Address'),
                    );
                } 
                  
                }).toList(),
              ),
            ),
        );
      },
    );
  }

  
}

Widget animate(){
  @override 
  Widget build(BuildContext context){
    Timer(Duration(seconds: 2),()=> Navigator.of(context).pop());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SpinKitCircle(
        color: Colors.pinkAccent,
        size: 50,
      ),
    );
  }
}
