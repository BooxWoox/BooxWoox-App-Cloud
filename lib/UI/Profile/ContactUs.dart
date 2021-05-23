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
                child: CustomCard("Maurya Bhat", "+91 8849229046", "Founder", "Overall", "bhatmaurya@gmail.com", "https://media-exp1.licdn.com/dms/image/C5603AQEyotKHU30koQ/profile-displayphoto-shrink_200_200/0/1620302234734?e=1626912000&v=beta&t=Chn7gu14UuYRRZM3fspGOHSZYV-T2jYS9VhtHiASkIs"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard("Tanmay Shrivastava", "+91 7667372643", "Co Founder", "Overall", "tanmayshrivatsava@gmail.com", "https://media-exp1.licdn.com/dms/image/C5103AQH2iSL3wS2Cwg/profile-displayphoto-shrink_200_200/0/1574151449242?e=1626912000&v=beta&t=1-moyLgBHi7Ac850ZV98R6TDk_uLyc010gc6DWjJyuk"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard("Pranav Bajaj", "+91 7887636763", "Manager", "Overall", "pranav4969@gmail.com", "https://media-exp1.licdn.com/dms/image/C5103AQHZnDjQ3T0Taw/profile-displayphoto-shrink_200_200/0/1553930393941?e=1626912000&v=beta&t=-LePD502DQlmhAl_Px2xieo22tc67TuZv7nLLQaUocI"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard("Utsav Majhi", "+91 9680063370", "Developer", "Overall", "utsavmajhi@gmail.com", "https://media-exp1.licdn.com/dms/image/C5103AQF9ODidPZDsKg/profile-displayphoto-shrink_400_400/0/1577910327355?e=1626912000&v=beta&t=rTAAN0x7-eNRG8YTC6yGQDxoMeNowafglrXCz402WZQ"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
