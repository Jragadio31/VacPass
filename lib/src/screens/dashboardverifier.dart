

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Verifier extends StatefulWidget{
  @override
  VerifierHomeScreen createState() => VerifierHomeScreen();
}

class VerifierHomeScreen extends State<Verifier> {

 final auth = FirebaseAuth.instance;
 final db = FirebaseFirestore.instance;

String uid;
 Position pos;

Future<void> scan() async{
  try{
      String barcode = await scanner.scan();
      // pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // GeoPoint point = GeoPoint(pos.latitude,pos.longitude);

      setState(() {
        var code = barcode.split('.');
        uid = code[0];

        // try{
        //   db
        //   .collection('VacpassHistory')
        //   .add({
        //     'Passenger_uid': barcode,
        //     'Verifier_uid': auth.currentUser.uid,
        //     'Date': DateTime.now(),
        //     'Location': point,
        //   });
          showDialog(context: context, builder: (context){
            return Dialog(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 3,
                  child:  Center(
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Manufacturer :',style: TextStyle(color: Colors.grey,fontSize: 18),),
                              Text(code[1],style: TextStyle(color: Colors.grey,fontSize: 20),),
                            ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Brand Name :',style: TextStyle(color: Colors.grey,fontSize: 18),),
                              Text(code[2],style: TextStyle(color: Colors.grey,fontSize: 20),),
                            ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Brand no. :',style: TextStyle(color: Colors.grey,fontSize: 18),),
                              Text(code[3],style: TextStyle(color: Colors.grey,fontSize: 20),),
                            ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Physician Name :',style: TextStyle(color: Colors.grey,fontSize: 18),),
                              Text(code[4],style: TextStyle(color: Colors.grey,fontSize: 20),),
                            ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('License no. :',style: TextStyle(color: Colors.grey,fontSize: 18),),
                              Text(code[5],style: TextStyle(color: Colors.grey,fontSize: 20),),
                            ]
                          ),
                          code[6] == 'true' ? confirmedPass() : validationButton(),
                        ],
                      ),
                    ),
                ),
            );
          });
        // } on Exception {
        //   print('failed');
        // }
        // code = null;
      });
  } on PlatformException catch(e){
    print(e.message+'message');
  }
}

  Widget confirmedPass(){
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Confirm ',style: TextStyle(color: Colors.green[700],fontSize: 18),),
          Icon(Icons.check_circle, color: Colors.green[700],),
        ]
      );
  }

  Widget validationButton(){
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            color: Colors.redAccent,
            onPressed: (){
              FirebaseFirestore.instance.collection('users').doc(uid).update({'Status': false});
            },
            child: Text('Reject'),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            color: Colors.greenAccent,
            onPressed: (){
              FirebaseFirestore.instance.collection('users').doc(uid).update({'Status': true});
            },
            child: Text('Confirm'),
          )
        ]
      );
  }

  @override
  Widget build(BuildContext context) {
     return Container(
       child: FutureBuilder<DocumentSnapshot> (
         future: db.collection('users').doc(auth.currentUser.uid).get(),
         builder: (context, snapshot){  
          Map data = snapshot.data.data();
          return Container(
            child: Scaffold(
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
                    height: constrainst.biggest.height,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height:140),
                            CircleAvatar(
                              backgroundImage: AssetImage('Images/dasha.png'),
                              radius: 70,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height:10),
                            Text('Dash D. Putin', style: TextStyle(fontSize: 22),),
                            FlatButton(onPressed: (){},
                             child: Text('View Profile',style: TextStyle(color: Colors.grey,),)
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height:50),
                              Material(
                                color: Colors.transparent,
                                child:  Image.asset('Images/scan.png', width:250, height: 250),
                              ),
                              SizedBox(height:20),
                              SizedBox(
                                width:240,
                                height:40,
                                child: 
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    color: Colors.pinkAccent,
                                    onPressed: scan,
                                    child: Text('SCAN QR CODE',style: TextStyle(color: Colors.white),),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ]
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

                  //             SizedBox(height: 10),
                  //              Container(
                  //             alignment: Alignment.center,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.black26,
                  //                     blurRadius: 6,
                  //                     offset: Offset(0,2),
                  //                   )
                  //                 ]
                  //             ),
                  //             height: 25,
                  //             width: 300,
                  //             child: Text(
                  //             'Name: ' + data['F_name'] + ' ' + data['L_name'],
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.bold
                  //             ),
                  //            ),
                  //           ),
                  //           SizedBox(height: 10),
                  //           Container(
                  //             alignment: Alignment.center,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.black26,
                  //                     blurRadius: 6,
                  //                     offset: Offset(0,2),
                  //                   )
                  //                 ]
                  //             ),
                  //             height: 25,
                  //             width: 300,
                  //             child: Text(
                  //             'role: ' + data['role'],
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.bold
                  //             ),
                  //            ),
                  //           ),
                  //           SizedBox(height: 50),
                  //           Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     FloatingActionButton(
                  //         onPressed: () => scan(),
                  //         child: Icon(
                  //           Icons.camera,
                  //           color: Colors.pink,
                  //         ),
                  //         backgroundColor: Colors.white,
                  //   ),
                  //   FloatingActionButton(
                  //       onPressed: (){
                        
                  //           auth.signOut();
                  //           Navigator.of(context).pop(AppRoutes.authVerifier);
                  //       },
                  //         child: Icon(
                  //           Icons.cancel,
                  //           color: Colors.pink,
                  //         ),
                  //         backgroundColor: Colors.white,
                  //   ),
                  //   ],
                  // ),
                      