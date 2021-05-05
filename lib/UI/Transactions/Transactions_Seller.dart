import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/Transactions/SellerTransaction_Category/Completed_Seller_Transaction.dart';
import 'package:bookollab/UI/Transactions/SellerTransaction_Category/Ongoing_Seller_Transaction.dart';
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


final _firestore=FirebaseFirestore.instance;
class Transactions_Seller extends StatefulWidget {
  static String id='Transactions_Seller_Screen';

  @override
  _Transactions_SellerState createState() => _Transactions_SellerState();
}

class _Transactions_SellerState extends State<Transactions_Seller> with SingleTickerProviderStateMixin{
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  int _pageIndex = 0;
  PageController _pageController;
  List<Widget> tabPages = [
    Ongoing_Seller_Transaction(),
    Completed_Seller_Transaction(),
    Text("Pending"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleSwitch(
              minWidth: 115,
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              labels: ['Ongoing', 'Failed','Completed'],
              icons: [Icons.circle_notifications, Icons.update,Icons.message],
              activeBgColors: [Colors.blue,Colors.red,Colors.green],
              onToggle: (index) {
                print('switched to: $index');
                // onPageChanged(index);
                _pageController.jumpToPage(index);
              },
            ),
          ),
          Expanded(
            child: PageView(
              physics:new NeverScrollableScrollPhysics(),
              children: tabPages,
              controller: _pageController,
            ),
          ),

        ],
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }
  void onTabTapped(int index) {
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}

