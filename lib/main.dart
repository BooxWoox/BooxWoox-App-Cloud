import 'package:flutter/material.dart';
import 'UI/SplashScreen.dart';
import 'UI/Onboarding.dart';
import 'UI/LoginPage.dart';
import 'UI/CreateAccountPage.dart';
void main() {
  runApp(bookollab());
}

class bookollab extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:CreateAccountPage.id,
      routes:{
        SplashScreen.id:(context) => SplashScreen(),
        Onboarding.id:(context) => Onboarding(),
        LoginPage.id:(context) => LoginPage(),
        CreateAccountPage.id:(context) => CreateAccountPage(),

      } ,
    );
  }
}

