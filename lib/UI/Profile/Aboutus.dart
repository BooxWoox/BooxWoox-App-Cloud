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


final FirebaseAuth _auth=FirebaseAuth.instance;
final _firestore=FirebaseFirestore.instance;


class Aboutus extends StatefulWidget {
  static String id='AboutUs_Screen';

  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  WebViewXController webviewController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BooxWoox"),
        leading: BackButton(onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
      body: WebViewX(
          initialContent: 'https://www.booxwoox.com/',
          initialSourceType: SourceType.URL,
          onWebViewCreated: (controller) => webviewController = controller,
      ),
    );
  }
}
