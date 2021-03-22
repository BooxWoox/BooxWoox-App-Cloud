import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/Onboarding.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'ChatsPage.dart';

final _firestore=FirebaseFirestore.instance;

class Chat_homepage extends StatefulWidget {
  static String id='Chat_homepage_Screen';
  @override
  _Chat_homepageState createState() => _Chat_homepageState();
}

class _Chat_homepageState extends State<Chat_homepage> with SingleTickerProviderStateMixin{
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

      body: Column(
        children: [
          Container(
            color: Color(0xFFFFCC00),
            child: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text("CHATS"),
                ),
                Tab(
                  child: Text("REQUESTS"),
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
                ChatsPage(),
                Center(child: Text("Requests Tab Bar View")),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}

