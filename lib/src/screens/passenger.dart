import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './sample.dart';
// import './home.dart';

class Passenger extends StatefulWidget {
  @override
  _PassScreen createState() => _PassScreen();
}

class _PassScreen extends State<Passenger> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Sample(),
    Text('Messgaes Screen'),
    Text('Profile Screen'),
  ];

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title:Text(''),
          automaticallyImplyLeading: false,),
      body: Scaffold(body: Container(child:_widgetOptions.elementAt(_selectedIndex),)),
      bottomNavigationBar: 
        BottomNavigationBar(
          selectedItemColor: Colors.pinkAccent,
          
          items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                  backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Scan History',
              backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.pinkAccent,
            ),
          ],
           currentIndex:  _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
    );
  }
}