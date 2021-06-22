import 'dart:async';

import 'package:bookollab/UI/Chat/ChatsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ConversationsPage extends StatefulWidget {
  static String id = 'Conversations_Page';

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  ScrollController _controller = ScrollController();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String UserUID = _auth.currentUser.uid.toString();

  ChatUser first_user, second_user;

  final messageController = TextEditingController();

  @override
  void initState() {
    _firestore.collection("Users").doc(UserUID).get().then((querySnapshot) {
      var doc = querySnapshot.data();
      String username = doc['Username'];
      String profile_url = doc['Profile_ImageURL'];
      if (profile_url.isEmpty)
        profile_url =
            "https://i.pinimg.com/originals/77/5b/91/775b91d4b1bfcac2aa3292b47763c1b1.jpg";
      first_user = ChatUser(UserUID, username, profile_url);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    second_user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(second_user.username),
          // leading: CircleAvatar(
          //   radius: 20.0,
          //   backgroundImage:
          //   NetworkImage(user.photoUrl),
          // ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color(0xFFFFCC00),
          shadowColor: Colors.transparent,
        ),
        backgroundColor: Color(0xfff5f5f5),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection("Users")
                .doc(UserUID)
                .collection("Chat")
                .doc(second_user.id)
                .collection("Messages")
                .orderBy("timestamp", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Loading!'),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var doc = snapshot.data.docs[index];
                        var chat = doc.data();
                        return Container(
                          padding: EdgeInsets.all(4.0),
                          child: chat['from'] == second_user.id
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 24.0,
                                      backgroundImage:
                                          NetworkImage(second_user.photoUrl),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Container(
                                        //   constraints: BoxConstraints(
                                        //       maxWidth: width / 2),
                                        //   child: Card(
                                        //     shape: RoundedRectangleBorder(
                                        //       side: BorderSide(
                                        //           color: Colors.white70,
                                        //           width: 1),
                                        //       borderRadius:
                                        //           BorderRadius.circular(10),
                                        //     ),
                                        //     child: Padding(
                                        //       padding:
                                        //           const EdgeInsets.all(6.0),
                                        //       child: Text(
                                        //         chat['text'],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Container(
                                          constraints:BoxConstraints(maxWidth: width/1.2),
                                          child: BubbleSpecialOne(
                                            text: chat['text'],
                                            isSender: false,
                                            color: Color(0xFFE8E8EE),
                                            sent: true,
                                          ),
                                        ),
                                        Text(DateFormat.yMMMd()
                                            .add_jm()
                                            .format(chat['timestamp'].toDate()))
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Container(
                                        //   constraints: BoxConstraints(
                                        //       maxWidth: width / 2),
                                        //   child: Card(
                                        //     child: Padding(
                                        //       padding:
                                        //           const EdgeInsets.all(4.0),
                                        //       child: Text(
                                        //         chat['text'],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Container(
                                          constraints:BoxConstraints(maxWidth: width/1.2),
                                          child: BubbleSpecialOne(
                                            text: chat['text'],
                                            isSender: true,
                                            color: Color(0xfffff192),
                                            sent: true,
                                          ),
                                        ),
                                        Text(DateFormat.yMMMd()
                                            .add_jm()
                                            .format(chat['timestamp'].toDate()))

                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 24.0,
                                      backgroundImage: NetworkImage(first_user ==
                                              null
                                          ? "https://i.pinimg.com/originals/77/5b/91/775b91d4b1bfcac2aa3292b47763c1b1.jpg"
                                          : first_user.photoUrl),
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                    child: TextField(
                      onTap: (){
                        Timer(
                            Duration(milliseconds: 300),
                                () => _controller
                                .jumpTo(_controller.position.minScrollExtent));
                      },
                      controller: messageController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        fillColor: Color(0xffffffff),
                        filled: true,
                        suffixIcon: IconButton(
                          icon:Icon(
                            Icons.send,
                          color: Colors.black,),
                          onPressed: (){
                           send_message();
                          },
                        ),
                        contentPadding:
                        EdgeInsets.symmetric( vertical: 8,horizontal: 24),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onSubmitted: (a){
                        send_message();
                      },
                    ),
                  )
                ],
              );
            }));
  }

  void send_message(){
    String message=messageController.text;
    if(message.trim().isNotEmpty) {
      _firestore.collection("Users").doc(first_user.id).collection("Chat").doc(
          second_user.id).collection("Messages").add(
          {
            "to": second_user.id,
            "from": first_user.id,
            "text": message,
            "timestamp": DateTime.now()
          }).then((value) {
        print(value);
      });
      _firestore.collection("Users").doc(second_user.id).collection("Chat")
          .doc(first_user.id).collection("Messages").add(
          {
            "to": second_user.id,
            "from": first_user.id,
            "text": message,
            "timestamp": DateTime.now()
          })
          .then((value) {
        print(value);
      });
    }
    messageController.clear();

  }


  DateTime timeformat(Timestamp timestamp){
    Timestamp now = timestamp;
    DateTime dateNow = now.toDate();
    return dateNow;
  }
}


