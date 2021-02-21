import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'maindisplaypage.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';

class Homepage extends StatefulWidget {
  static String id='Homepage_Screen';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    maindisplaypage(),
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
      drawer: Drawer(),
      appBar: AppBar(
        title: Text ("Welcome"),
        actions: [
          GestureDetector(
            onTap: (){
              print("userprofile click");
            },
            child: Image.asset('UIAssets/Homepage/user_circle.png',
            color: Colors.white,
            fit: BoxFit.scaleDown,),
          ),
        ],
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
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
              BottomNavigationBarItem( icon: Image.asset('UIAssets/Homepage/chat_icon.png'), title: Text("Home")),
              BottomNavigationBarItem(icon: Image.asset('UIAssets/Homepage/bookollab_icon.png'), title: Text("official")),
              BottomNavigationBarItem(icon: Image.asset('UIAssets/Homepage/notification_icon.png'), title: Text("notifications")),
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
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}
