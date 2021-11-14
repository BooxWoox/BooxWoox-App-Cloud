import 'dart:io';

import 'package:bookollab/Api/books.dart';
import 'package:bookollab/Models/book.dart';

import 'package:bookollab/State/auth.dart';
import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/Onboarding/LoginSecureDetails.dart';
import 'package:bookollab/UI/Onboarding/SplashScreen.dart';
//import 'package:bookollab/UI/Notification/NotificationSetting.dart';
import 'package:bookollab/UI/Profile/Aboutus.dart';
import 'package:bookollab/UI/Profile/ContactUs.dart';
//import 'package:bookollab/UI/Profile/EditBook.dart';
import 'package:bookollab/UI/Profile/ReturnBooks.dart';
//import 'package:bookollab/UI/Profile/legals.dart';
import 'package:bookollab/UI/Transactions/AllTransactions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Transactions/Transactions_Seller.dart';
import 'Transactions/Transactions_Buyer.dart';
import 'package:bookollab/UI/Onboarding/LoginPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:bookollab/UI/Profile/Mybooks.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class ProfilePage extends StatefulWidget {
  static String id = 'ProfilePage_Screen';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final _auth = FirebaseAuth.instance;
  XFile imageFile;
  File profileImage;
  String token = "";
  UserDetails userdetails;
  ImageData prfimage;

  getDetails() async {
    final apiprovider = context.read(apiProvider);
    token = apiprovider.token;
    var details = await BooksRepository.GetUserDetails(token);
    setState(() {
      userdetails = details;
    });
  }

  addImage() async {
    var image =
        await BooksRepository.GetImage(token, 'profileImages', profileImage.path);
    setState(() {
      prfimage = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDetails();
    super.initState();
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (userdetails == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Fetching Data!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        endDrawer: new AppDrawer(),
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pushReplacementNamed(context, Homepage.id);
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 25.00,
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          // shadowColor: Color(0xFFF7C100),
        ),
        body: Padding(
          padding: EdgeInsets.all(35.00),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 150.00,
                  width: 354.00,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.00),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){ _getFromGallery();},
                                child: CircleAvatar(
                                  backgroundImage: prfimage != null
                                      ? NetworkImage(
                                          prfimage.url,) //Image.file(profileImage)
                                      : AssetImage(
                                          'UIAssets/LoginScreen/DummyProfile.png'),
                                  radius: 45.00,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Column(
                                children: [
                                  Text(
                                    'User Name', // 'username'
                                    style: TextStyle(
                                        fontFamily: "Avenir95Black",
                                        fontSize: 15),
                                  ),
                                  
                                  Padding(
                                    padding: EdgeInsets.only(left: 40.00),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 15.00,
                                        ),
                                        Text(
                                          userdetails.phone,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () {
                             
                            },
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
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            //  Navigator.pushNamed(context, Mybooks.id);
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
                          onTap: () async {
                            await LoginSecureDetails.logout();
                            Navigator.of(context)
                                .pushReplacementNamed(SplashScreen.id);
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
  }

  _getFromGallery() async {
    XFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = XFile(pickedFile.path);
        profileImage = File(imageFile.path);
        addImage();
      });
    }
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
              // Navigator.pushNamed(context, NotificationSetting.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.policy_outlined),
            title: Text('Legals'),
            onTap: () {
              // Navigator.pushNamed(context, Legals.id);
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
