import 'package:bookollab/State/auth.dart';
import 'package:bookollab/UI/Onboarding/LoginSecureDetails.dart';
import 'package:bookollab/UI/maindisplaypage.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'LoginPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'Onboarding.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'Splash_Screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    String userPhoneNumber = await LoginSecureDetails.getPhoneNumber();
    String accessToken = await LoginSecureDetails.getAccessToken();


    if(userPhoneNumber != null && accessToken != null)
    {
      context.read(apiProvider).token = accessToken;
      Navigator.pushReplacementNamed(context, maindisplaypage.id);
    }
    else{
      Navigator.pushReplacementNamed(context, Onboarding.id);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Image.asset('UIAssets/booxWoox_splash.png')));
  }
}
