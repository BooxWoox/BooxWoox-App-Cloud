import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/Chat/ConversationPage.dart';
import 'package:bookollab/UI/Onboarding/Onboarding.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ChatsPage extends StatefulWidget {
  static String id = 'ChatsPage_Screen';

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  ScrollController _scrollController = new ScrollController();
  String UserUID = _auth.currentUser.uid.toString();
  List<String> chats = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("Users")
            .doc(UserUID)
            .collection("Chat")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading!'),
            );
          }
          return snapshot.data.docs.length!=0?Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String docID = snapshot.data.docs[index].id;
                        return FutureBuilder(
                          future: getChatUserInfo(docID),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.done) {
                              String username = userSnapshot.data["Username"];
                              String photoUrl =
                                  userSnapshot.data["Profile_ImageURL"];
                              if (photoUrl.isEmpty)
                                photoUrl =
                                    "https://i.pinimg.com/originals/77/5b/91/775b91d4b1bfcac2aa3292b47763c1b1.jpg";
                              return StreamBuilder<QuerySnapshot>(
                                  stream: _firestore
                                      .collection("Users")
                                      .doc(UserUID)
                                      .collection("Chat")
                                      .doc(snapshot.data.docs[index].id)
                                      .collection("Messages")
                                      .orderBy("timestamp", descending: true)
                                      .snapshots(),
                                  builder: (context, itemsnapshot) {
                                    if (!itemsnapshot.hasData) {
                                      return Center(
                                        child: Text('Loading!'),
                                      );
                                    }
                                    return InkWell(
                                      onTap: (){Navigator.pushNamed(context, ConversationsPage.id,
                                          arguments: ChatUser(snapshot.data.docs[index].id,username,photoUrl));},
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0, right: 20.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFEFEE),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 35.0,
                                              backgroundImage:
                                                  NetworkImage(photoUrl),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    username,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 8.0),
                                                  child: Container(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.59,
                                                    child: RichText(
                                                      overflow: TextOverflow.ellipsis,
                                                      strutStyle: StrutStyle(fontSize: 18.0),
                                                      text:TextSpan(
                                                        text: itemsnapshot.data.docs.first
                                                            .get("text"),
                                                        style: TextStyle(
                                                          color: Colors.blueGrey,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ) ,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else if (userSnapshot.connectionState ==
                                ConnectionState.none) {
                              return Text("No data");
                            }
                            return CircularProgressIndicator();
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ):Center(child: Text("No Chats",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black26
            ),),);
        },
      ),
    );
  }

  void loadmsg_get(String UserID, String DocID, int index) async {
    try {
      await _firestore
          .collection("Users")
          .doc(UserID)
          .collection("Chat")
          .doc(DocID)
          .collection("Messages")
          .orderBy("timestamp", descending: true)
          .snapshots()
          .listen((event) {
        print(event.docs.first.get("text"));
        setState(() {
          chats[index] = event.docs.first.get("text");
        });

        //chats.add(event.docs.last.get("text"));
      });
    } catch (e) {
      print("Error" + e);
    }
  }

  Future<DocumentSnapshot> getChatUserInfo(String userId) async {
    return await _firestore.collection("Users").doc(userId).get();
  }
}

class ChatUser{
  String id;
  String username;
  String photoUrl;
  ChatUser(this.id,this.username,this.photoUrl);
}
