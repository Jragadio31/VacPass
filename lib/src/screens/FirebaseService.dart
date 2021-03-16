import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../route.dart';

class DatabaseService {

  final auth = FirebaseAuth.instance;
  BuildContext context;

  void signIn(BuildContext context, _email, _password){
    this.context = context;

    try{
      auth.signInWithEmailAndPassword(email: _email, password: _password)
      .then((_) => {
          FirebaseFirestore
          .instance
          .collection('users')
          .doc(auth.currentUser.uid)
          .get()
          .then((snapshot) => {
              if(snapshot.exists){
                if(snapshot.data()['role'] == 'verifier')
                  Navigator.of(context).pushNamed(AppRoutes.authVerifier)
                else
                  Navigator.of(context).pushNamed(AppRoutes.authPassenger),
              }else print('snapshot does not exist'),
            }),
      });
    }on Exception catch(e){
      print(e);
    } 
  } 

  void signOut(){
    auth.signOut();
    Navigator.of(context).pop();
  }

  void resetPassword( BuildContext context, _email){
    auth.sendPasswordResetEmail(email: _email);
    Navigator.of(context).pop();
  }
}