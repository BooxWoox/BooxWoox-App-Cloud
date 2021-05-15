import 'package:bookollab/UI/Chat/ChatsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ConversationsPage extends StatefulWidget {
  static String id = 'Conversations_Page';

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String UserUID = _auth.currentUser.uid.toString();

  ChatUser first_user, second_user;

  @override
  void initState() {
    _firestore.collection("Users").doc(UserUID).get().then((querySnapshot) {
      var doc = querySnapshot.data();
      print(doc);
      String username=doc['Username'];
      String profile_url=doc['Profile_ImageURL'];
      if (profile_url.isEmpty)
        profile_url="https://i.pinimg.com/originals/77/5b/91/775b91d4b1bfcac2aa3292b47763c1b1.jpg";
      first_user = ChatUser(UserUID, username,profile_url );
      print(first_user.username);
      setState(() {});
    });
    super.initState();
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
        backgroundColor: Color(0xFFFFCC00),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection("Users")
                .doc(UserUID)
                .collection("Chat")
                .doc(second_user.id)
                .collection("Messages")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Loading!'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var doc = snapshot.data.docs[index];
                  var chat = doc.data();
                  return Container(
                    padding: EdgeInsets.all(4.0),
                    child: chat['from'] == second_user.id
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 24.0,
                                backgroundImage:
                                    NetworkImage(second_user.photoUrl),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: width/2),
                                    child: Card(
                                      shape:RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(chat['text'],),
                                      ),
                                    ),
                                  ),
                                  Text(DateFormat.yMMMd().add_jm().format(chat['timestamp'].toDate()))
                                ],
                              ),
                            ],
                          )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: width/2),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(chat['text'],),
                                      ),
                                    ),
                                  ),
                                  Text(DateFormat.yMMMd().add_jm().format(chat['timestamp'].toDate()))
                                ],
                              ),
                              CircleAvatar(
                                radius: 24.0,
                                backgroundImage:
                                    NetworkImage(first_user==null?"https://i.pinimg.com/originals/77/5b/91/775b91d4b1bfcac2aa3292b47763c1b1.jpg":first_user.photoUrl),
                              ),
                            ],
                          ),
                  );
                },
              );
            })
    );
  }
}


void readTimestamp(int timestamp) {

 var time=DateTime.fromMicrosecondsSinceEpoch(timestamp);
print(time);
}
