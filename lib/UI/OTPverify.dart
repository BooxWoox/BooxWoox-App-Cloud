import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';

class OtpScreenArguments {
  String phone;

  OtpScreenArguments(this.phone);
}

class OTPverify extends StatefulWidget {
  static String id = 'OTPverify_Screen';

  final args = ModalRoute.of(context).settings.arguments as OtpScreenArguments;

  const OTPverify({
    Key key,
  }) : super(key: key);

  @override
  _OTPverifyState createState() => _OTPverifyState();
}

class _OTPverifyState extends State<OTPverify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('UIAssets/OtpScreen/secure.png'),
          Text(
            "Please enter your 6 digit mobile number",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text("sent to your mobile number"),

        ],
      ),
    );
  }
}
