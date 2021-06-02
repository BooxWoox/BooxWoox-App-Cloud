import 'package:bookollab/UI/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bookollab/UI/Chat/chat_homepage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
class notification extends StatefulWidget {
  static String id='Notification_Screen';
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  String userUID=FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("Notification_Messages")
            .orderBy("Timestamp",descending: true)
            .where("userUID",isEqualTo:userUID)
            .snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData)
          {
            return Center(
              child: Text('Loading!'),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: Container(
                          height: 110,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.circle_notifications,size: 60,color: Colors.amber,),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/1.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(DateFormat.yMMMd()
                                        .add_jm()
                                        .format(snapshot.data.docs[index].get("Timestamp").toDate()),style:
                                    TextStyle(
                                      fontWeight: FontWeight.w500,
                                        fontSize: 12
                                    ),),
                                    SizedBox(height: 10,),
                                    Text("${snapshot.data.docs[index].get("Message")}",
                                    overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    style: TextStyle(
                                      fontSize: 14
                                    ),),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }


}
