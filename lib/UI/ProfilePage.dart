import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatefulWidget {
  static String id='ProfilePage_Screen';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  String username="";
  @override
  void initState(){
    // TODO: implement initState
    getusername();
    super.initState();
  }

  void getusername() async{
    var uid = await _auth.currentUser.uid;
    setState(() {
      username=uid;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFCC00),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
      body:

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: CircleAvatar(
                    child: Image.asset('UIAssets/LoginScreen/DummyProfile.png'),
                    radius: 55,
                    backgroundColor: Colors.white,
                  ),
                  backgroundColor: Colors.black12,
                  radius: 66,
                ),
              ),
              Center(child: Text(username,
              style: TextStyle(
                fontFamily: "Avenir95Black",
                fontSize: 24
              ),)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 25,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("UIAssets/Homepage/bookollab_icon.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("My Books",
                    style: TextStyle(
                      fontSize: 15
                    ),),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              Row(

                children: [
                  SizedBox(width: 25,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("UIAssets/Profile/logout_icon.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Log Out",
                    style: TextStyle(
                      fontSize: 15
                    ),),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
