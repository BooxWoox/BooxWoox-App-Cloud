import 'package:flutter/material.dart';
import 'UI/SplashScreen.dart';
import 'UI/Onboarding.dart';
import 'UI/LoginPage.dart';
import 'UI/CreateAccountPage.dart';
import 'UI/Homepage.dart';
import 'UI/maindisplaypage.dart';
import 'UI/OTPverify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/ProfilePage.dart';
import 'UI/Book_info.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(bookollab());
}

class bookollab extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:LoginPage.id,
      routes:{
        SplashScreen.id:(context) => SplashScreen(),
        Onboarding.id:(context) => Onboarding(),
        LoginPage.id:(context) => LoginPage(),
        CreateAccountPage.id:(context) => CreateAccountPage(),
        Homepage.id:(context) => Homepage(),
        maindisplaypage.id:(context)=>maindisplaypage(),
        OTPverify.id:(context) => OTPverify(),
        ProfilePage.id:(context) => ProfilePage(),
        Book_info.id:(context) =>Book_info(),

      } ,
    );
  }
}

