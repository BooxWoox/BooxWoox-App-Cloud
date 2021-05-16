import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class RequestsPage extends StatefulWidget {
  static String id = 'RequestsPage_Screen';

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
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
            .where('first_user_req_accepted', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading!'),
            );
          }
          return snapshot.data.docs.length > 0
              ? ListView.builder(
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
                          return Container(
                            margin: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 20.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFEFEE),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 32.0,
                                      backgroundImage: NetworkImage(photoUrl),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        username,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Would you like to accept this request?",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.check_circle),
                                        color: Colors.green,
                                        iconSize: 32,
                                        onPressed: () {
                                          accept_request(docID);
                                        })
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else if (userSnapshot.connectionState ==
                            ConnectionState.none) {
                          return Text("No data");
                        }
                        return CircularProgressIndicator();
                      },
                    );
                  },
                )
              : Center(child: Text('NO REQUESTS!!!'));
        },
      ),
    );
  }

  void accept_request(String docId) {
    _firestore
        .collection("Users")
        .doc(UserUID)
        .collection("Chat")
        .doc(docId)
        .update({"first_user_req_accepted": true}).then((_) {
      _firestore
          .collection("Users")
          .doc(docId)
          .collection("Chat")
          .doc(UserUID)
          .update({"second_user_req_accepted": true}).then((_) {
        print("success!");
      });
    });

  }

  Future<DocumentSnapshot> getChatUserInfo(String userId) async {
    return await _firestore.collection("Users").doc(userId).get();
  }
}

class ChatUser {
  String id;
  String username;
  String photoUrl;

  ChatUser(this.id, this.username, this.photoUrl);
}
