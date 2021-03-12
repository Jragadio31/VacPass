import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 class Root extends StatelessWidget{
   @override 
   Widget build(BuildContext context){
     User user = Provider.of<User>(context);
   }
 }
 
class User {
  String uid;
  User({this.uid});
}