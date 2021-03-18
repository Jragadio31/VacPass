

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../route.dart';




class Settings extends StatefulWidget{
  @override 
  SettingsView createState() => SettingsView();
}

class SettingsView extends State<Settings>{
 Map data;
 final db = FirebaseFirestore.instance;
 final auth = FirebaseAuth.instance;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text('Settings', style: TextStyle(color: Colors.pinkAccent,fontSize: 28),), 
          automaticallyImplyLeading: false, 
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: 
          SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                    children: [
                    SizedBox(
                      
                      height: 200,
                      width: MediaQuery.of(context).size.width, 
                      child:  Image.asset('Images/ads.png'),
                      
                    ),
                    SizedBox(
                        height: 40,
                      ),
                     Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.pinkAccent,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Account",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
                        ),
                      ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      
                      buildAccountOptionRow(context, "Change password"),
                      SizedBox(
                        height: 30,
                      ),
                       Row(
                      children: [
                        Icon(
                          Icons.help,
                          color: Colors.pinkAccent,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Help",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
                        ),
                      ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildAccountOptionRow(context, "frequently asked question"),
                      buildAccountOptionRow(context, "Privacy and Security"),
                      buildAccountOptionRow(context, "About us"),
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: OutlineButton(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                          
                                auth.signOut();
                                Navigator.of(context).pop(AppRoutes.authLogin);
                 
                          },
                          child: Text("SIGN OUT",
                              
                              style: TextStyle(
                                  
                                  fontSize: 16,
                                   letterSpacing: 2.2, 
                                   color: Colors.black
                              )
                          ),
                        ),
                      )
                    ],
              ),
              ),
            ),
          );
  } 
  
   GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}