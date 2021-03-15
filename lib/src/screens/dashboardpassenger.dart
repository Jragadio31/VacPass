
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Dashboard extends StatefulWidget{
  @override 
  DashboardScreen createState() => DashboardScreen();
}

class DashboardScreen extends State<Dashboard> {

 final auth = FirebaseAuth.instance;
 final db = FirebaseFirestore.instance;
 Map data;

  @override
  Widget build(BuildContext context) {
     return Container(
       child: FutureBuilder<DocumentSnapshot> (
         future: db.collection('users').doc(auth.currentUser.uid).get(),
         builder: (context, snapshot){  
          if(!snapshot.hasData){
            Timer(Duration(seconds: 2),()=> print('reload'));
          }
          
          if(snapshot.hasData) {
            data = snapshot.data.data();
            print('has data');
          }

          return Container(
            child: !snapshot.hasData? animate() : Scaffold(
              appBar: 
                AppBar(
                  title: Text('Dashboard', style: TextStyle(color: Colors.pinkAccent,fontSize: 28),), 
                  automaticallyImplyLeading: false, 
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
              body: LayoutBuilder(
                builder: (context, constrainst){
                  return Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height:150),
                            CircleAvatar(
                              backgroundImage: AssetImage('Images/dasha.png'),
                              radius: 70,
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            SizedBox(
                              height: 100,
                              child: 
                                Row(
                                    children: [
                                      Text('Name: '),
                                      Text(data['F_name']+' '+data['L_name']),
                                    ],    
                                ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ); 
                },  
              )
            ),
          );
         },
       ), 
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
