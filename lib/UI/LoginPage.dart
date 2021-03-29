import 'package:bookollab/UI/Homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  static String id='Login_Screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email_typed="";
  String pass_typed="";
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(26.0),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 10),
                  child: Text('Username',
                  style: TextStyle(
                    fontSize: 16
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:48.0),
                  child: TextField(
                    onChanged: (value){
                      email_typed=value;
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 10),
                  child: Text('Password',

                    style: TextStyle(
                        fontSize: 16,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:48.0),
                  child: TextField(

                    onChanged: (value){
                      pass_typed=value;
                    },
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 20),
                      child: Text(
                        "Forgot Password?"
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
                      child: Container(
                        width: 110,
                        height: 25,
                        child: Center(
                          child: FittedBox(
                            child: Text('Done',style: TextStyle(
                                fontFamily: 'LeelawUI',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ),
                    color: Color(0xFFFFCC00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    onPressed: () async{

                      //login server starts calling API
                      try{
                        var user=await _auth.signInWithEmailAndPassword(email: email_typed.trim().toLowerCase(), password: pass_typed).then((value){
                          print("Successfully Logged in as ${value.user.uid}");

                          Navigator.pushReplacementNamed(context, Homepage.id);
                        });
                        ;

                      }catch(e){
                          print("Error in log in"+e.toString());
                      }
                    },

                  ),
                ),
              ],
            )
          ],

        ),
      ),
    );
  }
}
