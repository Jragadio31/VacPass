import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../route.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

 TextEditingController _email = TextEditingController();
 TextEditingController _password = TextEditingController();
 String _emaillabel = '';
 String _passwordlabel = '';
  
  
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _emaillabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            validator: (String value) {
              if (value.isEmpty) return 'Email is Required';
                if (!RegExp( r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                    return 'Please enter a valid email Address';
                }
                  return null;
            },
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.pinkAccent
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            onChanged: ((value){
              if(_email.text.isNotEmpty && _email.text.length == 1) setState(() {_emaillabel = 'Email address'; });
              if(_email.text.isEmpty) setState(() {_emaillabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _passwordlabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 12),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            obscureText: true,
            controller: _password,
            validator: (String value) {
              if (value.isEmpty) return 'Password is Required';
                 return null;
            },
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.pinkAccent
              ),
              hintText: 'password',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            onChanged: ((value){
              if(_password.text.isNotEmpty && _password.text.length == 1) setState(() {_passwordlabel = 'Password'; });
              if(_password.text.isEmpty) setState(() {_passwordlabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildForgetPassword(){
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => print("Forgot Password Pressed"),
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
            try{
              auth.signInWithEmailAndPassword(email: _email.text, password: _password.text).then((_){
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
                          Navigator.of(context).pushNamed(AppRoutes.authHome),
                      }else print('snapshot does not exist'),
                    } 
                  );
                }
              );
            } on PlatformException catch(e){
              print(e.message);
            } on Exception catch(e){
              print(e);
            }
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
                      child:  Image.asset('Images/vacpass-logo2.png', width:100, height: 100),
                    ),
                    Text('Vacpass',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          SizedBox(height: 50),
                          buildEmail(),
                          SizedBox(height: 20),
                          buildpassword(),
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
    );
  }
}