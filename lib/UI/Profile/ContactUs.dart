import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/Transactions/AllTransactions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webviewx/webviewx.dart';
import '../Utils/CustomCard.dart';
class ContactUs extends StatefulWidget {
  static String id='ContactUs_Screen';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Need Support"),
        leading: BackButton(onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
      backgroundColor: Colors.amber ,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard("Maurya Bhat", "+91 8849229046", "Founder", "Overall", "bhattmaurya@gmail.com", "https://firebasestorage.googleapis.com/v0/b/bookollab-3c360.appspot.com/o/ProfileImages%2FMaurya.jpg?alt=media&token=7df1dc68-a0f2-4b85-b7b0-38a70bfa99f1"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard("Tanmay Srivastava", "+91 7667372643", "Co Founder", "Overall", "tanmays.204@gmail.com", "https://firebasestorage.googleapis.com/v0/b/bookollab-3c360.appspot.com/o/ProfileImages%2FTanmay.jpg?alt=media&token=71d974a0-3994-4eb6-a066-81c1b49f7d7d"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard("Pranav Bajaj", "+91 7887636763", "Co Founder", "Overall", "pranavbajaj4969@gmail.com", "https://firebasestorage.googleapis.com/v0/b/bookollab-3c360.appspot.com/o/ProfileImages%2FPranav.jpeg?alt=media&token=9ff1a757-3aa2-43bc-8914-d568c28e4287"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard("Utsav Majhi", "+91 9680063370", " App Developer", "Overall", "utsavmajhi@gmail.com", "https://firebasestorage.googleapis.com/v0/b/bookollab-3c360.appspot.com/o/ProfileImages%2Futsav.jpeg?alt=media&token=4e483419-37ed-4b58-a94b-d78278a046c2"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
