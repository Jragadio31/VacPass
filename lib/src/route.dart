import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/passengernavigation.dart';
import 'screens/verifiernavigation.dart';

class AppRoutes{
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-Register';
  static const String authVerifier = '/auth-Verifier';
  static const String authPassenger = '/auth-Passenger';

  static Map<String, WidgetBuilder> define(){
    return{
      authLogin: (context) => LoginScreen(),
      authRegister: (context) => RegisterScreen(),
      authVerifier: (context) => VerifierNav(),
      authPassenger: (context) => Passenger(),
    };
  }
}


