import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/Transactions/Transactions_Buyer.dart';
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
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Transactions_Seller.dart';

final _firestore=FirebaseFirestore.instance;

class AllTransactions extends StatefulWidget {
  static String id='AllTransactionsyy_Shcreen';
  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> with TickerProviderStateMixin{
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Transactions"),
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xFFFFCC00),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_shopping_cart_sharp),
                      Text("Buyer"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_pin_rounded),
                      Text("Seller"),
                    ],
                  ),
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
                //ChatsPage(),
                Transactions_Buyer(),
                Transactions_Seller(),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
