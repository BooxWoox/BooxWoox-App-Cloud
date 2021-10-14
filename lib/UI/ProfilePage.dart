import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/Notification/NotificationSetting.dart';
import 'package:bookollab/UI/Profile/Aboutus.dart';
import 'package:bookollab/UI/Profile/ContactUs.dart';
import 'package:bookollab/UI/Profile/EditBook.dart';
import 'package:bookollab/UI/Profile/ReturnBooks.dart';
import 'package:bookollab/UI/Profile/legals.dart';
import 'package:bookollab/UI/Transactions/AllTransactions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Transactions/Transactions_Seller.dart';
import 'Transactions/Transactions_Buyer.dart';
import 'package:bookollab/UI/Onboarding/LoginPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bookollab/UI/Profile/Mybooks.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class ProfilePage extends StatefulWidget {
  static String id = 'ProfilePage_Screen';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  String username = "";
  @override
  void initState() {
    // TODO: implement initState
    getusername();

    super.initState();
  }

  void getusername() async {
    var uid = await _auth.currentUser.uid;
    try {
      await _firestore
          .collection("Users")
          .doc("${_auth.currentUser.uid}")
          .get()
          .then((value) {
        print(value["Username"]);
        setState(() {
          username = value["Username"];
        });
      });
    } catch (e) {
      print(e.message);
      _auth.signOut().then((value) {
        Navigator.pushReplacementNamed(context, LoginPage.id);
      });
    }
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      endDrawer: new AppDrawer(),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Homepage.id);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.00),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
              child: Icon(
                Icons.menu,
                size: 25.00,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        shadowColor: Color(0xFFF7C100),
      ),
      body: Padding(
        padding: EdgeInsets.all(35.00),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 129.00,
                width: 354.00,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.00),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                              'UIAssets/LoginScreen/DummyProfile.png'),
                          radius: 35.00,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(25.00),
                            child: Column(
                              children: [
                                Text(
                                  'User Name', // 'username'
                                  style: TextStyle(
                                      fontFamily: "Avenir95Black",
                                      fontSize: 15),
                                ),
                                SizedBox(height: 7.00),
                                Padding(
                                  padding: EdgeInsets.only(left: 25.00),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 15.00,
                                      ),
                                      Text('Ph.number')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: 20,
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                  elevation: 11.00,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 354,
                height: 254,
                child: Card(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Mybooks.id);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.bookmark_outline),
                            ),
                            SizedBox(
                              width: 50.0,
                            ),
                            Text(
                              "Manage my books",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'whiteMountainView display4'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 0.00),
                        child: Divider(
                          height: 20,
                          thickness: 2,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ReturnBooks.id);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.keyboard_return),
                            ),
                            SizedBox(
                              width: 50.0,
                            ),
                            Text(
                              "Return Book",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'whiteMountainView display4'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 0.00),
                        child: Divider(
                          height: 20,
                          thickness: 2,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AllTransactions.id);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.sync_alt),
                            ),
                            SizedBox(
                              width: 50.0,
                            ),
                            Text(
                              "My transactions",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'whiteMountainView display4'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 0.00),
                        child: Divider(
                          height: 20,
                          thickness: 2,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, LoginPage.id);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.logout_sharp),
                            ),
                            SizedBox(
                              width: 50.0,
                            ),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'whiteMountainView display4'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  elevation: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void notificationUserDeactive(String uid) {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((deviceToken) {
      print(deviceToken);
      _firestore.collection("Notification_token").doc(deviceToken).update({
        'isActive': false,
        'Timestamp': DateTime.now(),
      });
    });
  }
}

/* Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: CircleAvatar(
                    child: Image.asset('UIAssets/LoginScreen/DummyProfile.png'),
                    radius: 55,
                    backgroundColor: Colors.white,
                  ),
                  backgroundColor: Colors.black12,
                  radius: 66,
                ),
              ),
              Center(
                  child: Text(
                username,
                style: TextStyle(fontFamily: "Avenir95Black", fontSize: 24),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Mybooks.id);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Image.asset("UIAssets/Homepage/bookollab_icon.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "My Books",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AllTransactions.id);
                  print("All Transactions");
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.black54,
                        ),
                        backgroundColor: Colors.black26,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "All Transactions",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Aboutus.id);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Image.asset("UIAssets/Profile/Iconfeatherinfo.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "About Us",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ContactUs.id);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("UIAssets/Profile/Iconcall.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Need Support ?",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  print("Logout");
                  String useruid = _auth.currentUser.uid;
                  notificationUserDeactive(useruid);
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, LoginPage.id);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("UIAssets/Profile/logout_icon.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Log Out",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ), */

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About Us'),
            onTap: () {
              Navigator.pushNamed(context, Aboutus.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text('Need support'),
            onTap: () {
              Navigator.pushNamed(context, ContactUs.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_notifications_outlined),
            title: Text('Notification setting'),
            onTap: () {
              Navigator.pushNamed(context, NotificationSetting.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.policy_outlined),
            title: Text('Legals'),
            onTap: () {
              Navigator.pushNamed(context, Legals.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.report_problem_outlined),
            title: Text('Report'),
            onTap: () {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    'Report an issue',
                    textAlign: TextAlign.center,
                  ),
                  content: Padding(
                    padding: EdgeInsets.all(0.00),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type here',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                      maxLines: 10,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  actions: <Widget>[
                    SizedBox(
                      width: 15.0,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xFFE5E5E5),
                      height: 50.00,
                      minWidth: 100.00,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text('Submit'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xFFFFBD06),
                      height: 50.00,
                      minWidth: 100.00,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.live_help_outlined),
            title: Text('FAQ'),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
