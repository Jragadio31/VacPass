import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/homeverifier.dart';
import 'screens/home.dart';
import 'screens/passenger.dart';

class AppRoutes{
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-Register';
  static const String authHome = '/auth-Home';
  static const String authVerifier = '/auth-Verifier';
  static const String authPassenger = '/auth-Passenger';

  static Map<String, WidgetBuilder> define(){
    return{
      authLogin: (context) => LoginScreen(),
      authRegister: (context) => RegisterScreen(),
      authHome: (context) => Home(),
      authVerifier: (context) => Verifier(),
      authPassenger: (context) => Passenger(),
    };
  }
}


