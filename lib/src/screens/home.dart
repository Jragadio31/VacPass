

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../route.dart';

class Home extends StatefulWidget{
  @override
  HomeScreen createState() => HomeScreen();
}
class HomeScreen extends State<Home> {

  
 final auth = FirebaseAuth.instance;
 final db = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    
     return Center(
       child: StreamBuilder<DocumentSnapshot>(
         stream: db.collection('users').doc(auth.currentUser.uid).snapshots(),
         builder: (context, snapshot){
          if(snapshot==null) print('reload');
          Map data = snapshot.data.data();

          Timestamp _dateofVaccination = data['Date_of_Vaccination'];
          DateTime _datevaccined = _dateofVaccination.toDate();
          String _date = _datevaccined.month.toString() +'/'+ _datevaccined.day.toString() + '/' + _datevaccined.year.toString();

          Timestamp _dateofPCR = data['RT_PCR_Date'];
          DateTime _rtpcr = _dateofPCR.toDate();
          String _rt = _rtpcr.month.toString() +'/'+ _rtpcr.day.toString() + '/' + _rtpcr.year.toString();

          return Container(
            child: Scaffold(
              appBar: AppBar(
                title: Text(''),
                backgroundColor: Colors.pinkAccent,
                automaticallyImplyLeading:false
              ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width ,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.pinkAccent,
                      Colors.pink,
                      Colors.purple[300],
                      Colors.purpleAccent,
                    ]
                  )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(40),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child:  Image.asset('Images/vacpass-logo2.png', width:170, height: 170),
                    ),
                    SizedBox(height: 30),
                    
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
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
                              height: 40,
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
                              'Manufacturer Brand: ' + data['M_Brand'],
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
                              'Brand Name: '+ data['Brand_name'],
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
                              'Brand Number: ' + data['Brand_number'].toString(),
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
                              'Date of Vaccination: ' + _date,
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
                              'Place of Vacination:' + data['Placed_vacined'],
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
                              'Physician Name:' + data['Physician_name'],
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
                              'License Number:' + data['License_no'],
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
                              'Date of Last RT-PCR: ' + _rt,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                             ),
                            ), 
                            SizedBox(height: 10),    
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Text('Log out'),
                              onPressed:(){
                                  auth.signOut();
                                  Navigator.of(context).pop(AppRoutes.authLogin);
                              },  
                              ),
                               
                        ],)
                      ],
                      
                      )
                   ),   
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                              return Dialog(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  height: MediaQuery.of(context).size.height / 3,
                                  child:  Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            QrImage(
                                              data: auth.currentUser.uid+"."+data['M_Brand']+"."+data['Brand_name']+"."+data['Brand_number'].toString()+"."+data['Physician_name']+"."+data['License_no'],
                                              size: 200,
                                              backgroundColor: Colors.white,
                                            ),
                                        ],),
                                    ),
                                ),
                            );
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.pink,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    ],
                  ),
                  ],
                )
                )
              )
              
            ],
          )
        )
      )
            )
    );
         },
       ),
     );
  }
}