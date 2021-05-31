import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/Transactions/AllTransactions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore=FirebaseFirestore.instance;
class Mybooks extends StatefulWidget {
  static String id = 'maindisplaypage_Screen';
  const Mybooks({Key key}) : super(key: key);
  @override
  _MybooksState createState() => _MybooksState();
}

class _MybooksState extends State<Mybooks> {
  String userUID=FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("Book_Collection")
            .where("OwnerUID",isEqualTo:userUID)
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
                          height: 180,
                          child: Row(
                            children: [
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                ),
                                child: Container(
                                  height: 140,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                    child: Image.network(
                                      snapshot.data.docs[index].get("ImageUrl"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data.docs[index].get("BookName"),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  Text(snapshot.data.docs[index].get("Author")),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text("MRP :"),
                                ],
                              )
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
