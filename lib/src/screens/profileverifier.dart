
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  @override 
  ProfileView createState() => ProfileView();
}

class ProfileView extends State<Profile>{
  Map data;
 final db = FirebaseFirestore.instance;

  @override 
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<DocumentSnapshot>(
        future: db.collection('VacpassHistory').doc().get(),
        builder:(context, snapshot){
          if( !snapshot.hasData) {
            Timer(Duration(seconds: 3),()=> print('reload'));
          }
          if(snapshot.hasData) {
            data = snapshot.data.data();
            print('has data');
          }

          return Container(
            child: Scaffold(
              appBar: 
                AppBar(
                  title: Text('Profile', style: TextStyle(color: Colors.pinkAccent,fontSize: 28),), 
                  automaticallyImplyLeading: false, 
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
              body: LayoutBuilder(
                builder: (context, constrainst){
                  return Container(
                    alignment: Alignment.topCenter,
                    height: constrainst.biggest.height,
                    decoration: BoxDecoration(color: Colors.white),
                    child:Text('profile'),
                  );
                },
              )
            ),
          );
        }
      ),
    );
  }
}