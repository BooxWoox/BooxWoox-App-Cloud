import 'package:bookollab/UI/AddBookPage.dart';
import 'package:bookollab/UI/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'maindisplaypage.dart';
import 'dart:async';
import 'package:bookollab/UI/Chat/chat_homepage.dart';
import 'package:bookollab/UI/Notification/notification.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'liked.dart';

//final _firestore = FirebaseFirestore.instance;
//final _auth = FirebaseAuth.instance;

class Homepage extends StatefulWidget {
  static String id = 'Homepage_Screen';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> tabPages = [
    maindisplaypage(),
    Chat_homepage(),
    liked(),
    ProfilePage(),
  ];
  final controller = PageController(initialPage: 0);
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //String useruid = _auth.currentUser.uid;
    //notificationUserActive(useruid);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: controller,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: onTapped,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'UIAssets/Homepage/bookollab_icon.png',
                    color: Colors.black,
                  ),
                  label: 'home',
                  activeIcon: Image.asset(
                    'UIAssets/Homepage/bookollab_icon.png',
                    color: Colors.orangeAccent,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'UIAssets/Homepage/chat_icon.png',
                    color: Colors.black,
                  ),
                  label: 'Chat',
                  activeIcon: Image.asset(
                    'UIAssets/Homepage/chat_icon.png',
                    color: Colors.orangeAccent,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'UIAssets/Homepage/like_outline.png',
                    height: 25.00,
                  ),
                  label: 'notification',
                  activeIcon: Image.asset(
                    'UIAssets/Homepage/like_outline.png',
                    height: 25.00,
                    color: Colors.orangeAccent,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'UIAssets/Homepage/profile_circle.png',
                    color: Colors.black,
                  ),
                  label: 'profile',
                  activeIcon: Image.asset(
                    'UIAssets/Homepage/profile_circle.png',
                    color: Colors.orangeAccent,
                  )),
            ],
            selectedItemColor: Colors.orangeAccent,
            unselectedItemColor: Colors.black,
          ),
        ),
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
      controller.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  void onPageChanged(int page) {
    setState(() {
      this.selectedIndex = page;
    });
  }

  /*  void notificationUserActive(String uid) {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((deviceToken) {
      print(deviceToken);
      _firestore.collection("Notification_token").doc(deviceToken).set({
        'device_Token': deviceToken,
        'UserUID': uid.trim(),
        'isActive': true,
        'Timestamp': DateTime.now(),
      });
    });
  } */
}
