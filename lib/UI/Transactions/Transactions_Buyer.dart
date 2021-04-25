import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:jiffy/jiffy.dart';
import 'BuyerTransaction_Category/Ongoing_transaction.dart';
import 'BuyerTransaction_Category/Failed_transaction.dart';
import 'BuyerTransaction_Category/Completed_transaction.dart';

final _firestore=FirebaseFirestore.instance;
class Transactions_Buyer extends StatefulWidget {
  static String id='Transactions_Buyer_Screen';
  @override
  _Transactions_BuyerState createState() => _Transactions_BuyerState();
}

class _Transactions_BuyerState extends State<Transactions_Buyer> with SingleTickerProviderStateMixin{
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text ("Buyer's Transactions"),
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFFFFCC00),
            child: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text("Ongoing"),
                ),
                Tab(
                  child: Text("Failed"),
                ),
                Tab(
                  child: Text("Completed"),
                ),
              ],
              controller: _tabController,
              indicatorColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Ongoing_transaction_Buyer(),
                Failed_transaction_Buyer(),
                Completed_transaction_Buyer(),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
