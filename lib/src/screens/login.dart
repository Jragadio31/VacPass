
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

  final _formKey = GlobalKey<FormState>();

  @override 
  // ignore: override_on_non_overriding_member
  void iniState(){
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }
Widget buildForgetPassword(){
  return Container(
    alignment: Alignment.centerRight,
    // ignore: deprecated_member_use
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
      // ignore: deprecated_member_use
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
      onWillPop: DatabaseService().onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: 
          AppBar(title: Text(''),backgroundColor: Colors.pinkAccent, elevation: 0,
            automaticallyImplyLeading: false,
          ),
        body: GestureDetector(
            child: Stack(
              children: <Widget>[
                showAlert(),
                Container(
<<<<<<< HEAD
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(25),
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: 
                            Material(
                              color: Colors.transparent,
                              child:  Image.asset('Images/vacpass-logo2.png', width:120, height: 120),
                            ),
                        ),
                        Text('Vaxipass',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Expanded(
                          flex: 4,
                          child: Form(
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
                          ),
                        )
                      ],
                     ),
=======
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [


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
<<<<<<< HEAD
   
  //  AnnotatedRegion<SystemUiOverlayStyle>(
  //         value: SystemUiOverlayStyle.light,
  //         child: 
  //       )

  //  SingleChildScrollView(
  //                   physics: AlwaysScrollableScrollPhysics(),
  //                   padding: EdgeInsets.symmetric(
  //                     horizontal: 25,
  //                     vertical: 75
  //                   ),
  //                   child: 
  //                 )
=======
   
>>>>>>> 97e973c90ab505df77b207601bb2478ceeb2a94f
