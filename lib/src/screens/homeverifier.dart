
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../route.dart';

class Verifier extends StatefulWidget{
  @override
  VerifierHomeScreen createState() => VerifierHomeScreen();
}

class VerifierHomeScreen extends State<Verifier> {

 final auth = FirebaseAuth.instance;
 final db = FirebaseFirestore.instance;
 Position pos;

Future<void> scan() async{

  try{
      String barcode = await scanner.scan();
      

      pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      GeoPoint point = GeoPoint(pos.latitude,pos.longitude);

      setState(() {
        var code = barcode.split('.');

        try{
          db
          .collection('VacpassHistory')
          .add({
            'Passenger_uid': barcode,
            'Verifier_uid': auth.currentUser.uid,
            'Date': DateTime.now(),
            'Location': point,
          });
          showDialog(context: context, builder: (context){
            return Dialog(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 3,
                  child:  Center(
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(code[0]),
                          Text(code[1]),
                          Text(code[2]),
                          Text(code[3]),
                          Text(code[4]),
                          Text(code[5]),
                        ],),
                    ),
                ),
            );
          });
        } on Exception {
          print('failed');
        }
      });
  } on PlatformException catch(e){
    print(e.message+'message');
  }
}

  @override
  Widget build(BuildContext context) {
     return Center(
       child: StreamBuilder<DocumentSnapshot> (
         stream: db.collection('users').doc(auth.currentUser.uid).snapshots(),
         builder: (context, snapshot){
          print('reload');
          Map data = snapshot.data.data();
          return Container(
            child: Scaffold(
              appBar: AppBar(title: Text('Verifier Home'), automaticallyImplyLeading: false,),
              body:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                              SizedBox(height: 10),
                               Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2),
                                    )
                                  ]
                              ),
                              height: 25,
                              width: 300,
                              child: Text(
                              'Name: ' + data['F_name'] + ' ' + data['L_name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                             ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2),
                                    )
                                  ]
                              ),
                              height: 25,
                              width: 300,
                              child: Text(
                              'role: ' + data['role'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                             ),
                            ),
                            SizedBox(height: 50),
                            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          onPressed: () => scan(),
                          child: Icon(
                            Icons.camera,
                            color: Colors.pink,
                          ),
                          backgroundColor: Colors.white,
                    ),
                    FloatingActionButton(
                        onPressed: (){
                        
                            auth.signOut();
                            Navigator.of(context).pop(AppRoutes.authVerifier);
                        },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.pink,
                          ),
                          backgroundColor: Colors.white,
                    ),
                    ],
                  ),
                      
                    ],
                  ),
                   
              ]
            ),
            )
          );
         },
       ),
     );
  }
}
