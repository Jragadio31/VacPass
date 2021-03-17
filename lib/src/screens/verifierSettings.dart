
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget{
  @override 
  SettingsView createState() => SettingsView();
}

class SettingsView extends State<Settings>{
  Map data;
 final db = FirebaseFirestore.instance;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: 
      PreferredSize(child: SafeArea(
        child: Container(
          
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
               Text('Settings', style: TextStyle(color: Colors.pinkAccent, fontSize: 28,),),
               Icon(Icons.settings, size: 30, color: Colors.pinkAccent,)
               
            ],),
          ),
        ),
        ), preferredSize: Size.fromHeight(100),
        ),
    );
      
  } 
}