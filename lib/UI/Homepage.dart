import 'package:bookollab/UI/AddBookPage.dart';
import 'package:bookollab/UI/Chat/chat_homepage.dart';
import 'package:bookollab/UI/Favorite.dart';
import 'package:bookollab/UI/Notification/notification.dart';
import 'package:bookollab/UI/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Filters/filters.dart';
import 'Onboarding/LoginPage.dart';
import 'maindisplaypage.dart';
import 'package:bookollab/State/auth.dart';

class Homepage extends StatefulWidget {
  static String id = 'Homepage_Screen';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> tabPages = [
    maindisplaypage(),
   // Chat_homepage(),
   // Favorite(),
   // ProfilePage(),
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'UIAssets/title.png',
          width: MediaQuery.of(context).size.width * 0.3,
          fit: BoxFit.fitWidth,
          alignment: Alignment.centerLeft,
        ),
        actions: [
         /*  GestureDetector(
            onTap: () {
              print("userprofile click");
              // Navigator.pushNamed(context, notification.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('No notifications at this time'),
                ),
              );
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
          ), */
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Filters.id);
            },
            icon: Icon(Icons.tune, color: Colors.black),
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // shadowColor: Color(0xFFF7C100),
        elevation: 0,
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: controller,
      ),
      /* bottomNavigationBar: Container(
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
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: 'home',
                activeIcon: Icon(Icons.home,
                 color: Color(0xFFFFCC00)),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: Colors.black,
                ),
                label: 'Chat',
                activeIcon: Icon(Icons.chat,
                 color: Color(0xFFFFCC00)),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
                  label: 'notification',
                  activeIcon: Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFFFFCC00),
                ),),
              BottomNavigationBarItem(
                  icon: Icon(
                  Icons.person_pin_rounded,
                  color: Colors.black,
                ),
                  label: 'profile',
                  activeIcon: Icon(
                  Icons.person_pin_rounded,
                  color: Color(0xFFFFCC00),
                ),),
            ],
            selectedItemColor:  Color(0xFFFFCC00),
            unselectedItemColor: Colors.black,
          ),
        ),
      ), */
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
