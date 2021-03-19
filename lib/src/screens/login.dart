
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Services/CustomTextField.dart';
import 'Services/firebaseservice.dart';
import '../route.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

 final TextInputType keyEmail = TextInputType.emailAddress;
 final TextEditingController _email = TextEditingController();

 final TextInputType keyPass = TextInputType.text;
 final TextEditingController _password = TextEditingController();
 DateTime backbuttonpressedTime;

  final _formKey = GlobalKey<FormState>();

Widget buildForgetPassword(){
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => Navigator.of(context).pushNamed(AppRoutes.authForgetPassword),
      padding: EdgeInsets.only(right: 0),
      child: Text(
        'Forget Password?',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        )
      )
      )
  );
}

Widget buildLoginBtn(){
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
          'Login',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: (){
          if (_formKey.currentState.validate()) {
            DatabaseService().signIn(context,_email.text.trim(),_password.text.trim(),_email,_password);
          }
        },
    )
  );
}

Widget buildSignUpBtn(){
  return GestureDetector(
    onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.authRegister);
    },
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account yet? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            )
        ]
      ),
    )
  );
}

  @override
  Widget build(BuildContext context){
    return WillPopScope(  
      onWillPop: onWillPop,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                showAlert(),
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
                      Text('VaxPass',
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
                            CustomTextField(_email,keyEmail,'Email address', 'email', false),
                            SizedBox(height: 20),
                            CustomTextField(_password,keyPass,'Password', 'password', true),
                            buildForgetPassword(),
                            buildLoginBtn(),
                            buildSignUpBtn(),  
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
      ),
    );
  }
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
      currentTime.difference(backbuttonpressedTime) > Duration(seconds: 2);
    if(backButton){
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
        msg: 'Double tap to exit the app',
        backgroundColor: Colors.grey,
        textColor: Colors.white
      );
      return false;
    }
    return true;
  }
  Widget showAlert(){
    if('error'  != null){
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(),
      );
    }
    return SizedBox(height: 0,);
  }
}
   