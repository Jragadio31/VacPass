
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacpass_app/src/screens/CustomTextField.dart';
import './FirebaseService.dart';
import '../route.dart';


class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}


class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final _formKey = GlobalKey<FormState>();
  

 final TextInputType keyEmail = TextInputType.emailAddress;
 final TextEditingController _email = TextEditingController();

 final TextInputType keyPass = TextInputType.text;
 TextEditingController _password = TextEditingController();



Widget buildResetPasswordBtn(){
  return Container(
    padding: EdgeInsets.symmetric( vertical: 25),
    width: double.infinity,
    child: 
      RaisedButton(
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        color: Colors.white,
        child: Text(
          'Reset Password',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: (){
          if (_formKey.currentState.validate()) {
            DatabaseService().resetPassword(context,_email.text);
          }
        },
    )
  );
}

Widget buildCancelBtn(){
  return Container(
    width: double.infinity,
    child: 
      RaisedButton(
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: (){
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
    )
  );
}



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child:  Image.asset('Images/vacpass-logo2.png', width:120, height: 120),
                    ),
                    Text('VaxiPass',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          SizedBox(height: 50),
                          CustomTextField(this._email, this.keyEmail, 'Email Address', 'email', false),
                          buildResetPasswordBtn(),
                          buildCancelBtn(),
                      ],
                      )
                   )
                  ],
                )
                )
              )
            ],
          )
        )
      )
    );
  }
}