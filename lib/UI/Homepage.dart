import 'package:bookollab/UI/AddBookPage.dart';
import 'package:bookollab/UI/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Filters/filters.dart';
import 'Onboarding/LoginPage.dart';
import 'maindisplaypage.dart';
import 'dart:async';
import 'package:bookollab/UI/Chat/chat_homepage.dart';
import 'package:bookollab/UI/Notification/notification.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class Homepage extends StatefulWidget {
  static String id = 'Homepage_Screen';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    MainDisplayPage(),
    // Chat_homepage(),
    // notification(),
  ];

  @override
  void initState() {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'UIAssets/title.png',
          width: MediaQuery.of(context).size.width * 0.3,
          fit: BoxFit.fitWidth,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print("userprofile click");
              Navigator.pushNamed(context, ProfilePage.id);
            },
            child:
                // Image.asset(
                //   'UIAssets/Homepage/notification_icon.png',
                //   color: Colors.black,
                //   fit: BoxFit.scaleDown,
                // ),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Filters.id);
            },
            icon: Icon(Icons.control_point_sharp),
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // shadowColor: Color(0xFFF7C100),
        elevation: 0,
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _pageIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: onTabTapped,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Color(0xFFFFCC00),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: Colors.black,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_pin_rounded,
                  color: Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  // void notificationUserActive(String uid) {
  //   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //   firebaseMessaging.getToken().then((deviceToken) {
  //     print(deviceToken);
  //     _firestore.collection("Notification_token").doc(deviceToken).set({
  //       'device_Token': deviceToken,
  //       'UserUID': uid.trim(),
  //       'isActive': true,
  //       'Timestamp': DateTime.now(),
  //     });
  //   });
  // }
}
