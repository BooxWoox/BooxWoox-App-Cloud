import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:jiffy/jiffy.dart';

final _firestore=FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
class Completed_Seller_Transaction extends StatefulWidget {
  static String id='Completed_transaction_Seller_Screen';
  @override
  _Completed_Seller_TransactionState createState() => _Completed_Seller_TransactionState();
}

class _Completed_Seller_TransactionState extends State<Completed_Seller_Transaction> {
  String UserUID=_auth.currentUser.uid.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("Transactions").where("SellerUID",isEqualTo:UserUID).where("Book_Taken_from_Buyer",isEqualTo: true).snapshots(),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 90,
                                    child: Image.network(snapshot.data.docs[index].get("ImageURL"),fit: BoxFit.fill,),
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data.docs[index].get("Book_Name"),style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600
                                      ),),
                                      SizedBox(height: 12,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Payment Status: "),
                                          snapshot.data.docs[index].get("Payment_Status")=="Success"?Text("Success",style:
                                          TextStyle(
                                            color: Colors.green,
                                          ),):Text("Failure",style: TextStyle(
                                              color: Colors.red
                                          ),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Total Amt: "),
                                          Text(" \u{20B9} ${snapshot.data.docs[index].get("Total_Amt").toString()}"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Order ID: "),
                                          Text(snapshot.data.docs[index].get("Order_ID")),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Rent Start Date: ",style: TextStyle(fontWeight: FontWeight.w500),),
                                          Text(getCustomFormattedDateTime(snapshot.data.docs[index].get("Lease_Start_Date").toDate().toString(),'dd MMMM yyyy').toString(),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Rent End Date: ",style: TextStyle(fontWeight: FontWeight.w500),),
                                          Text(getCustomFormattedDateTime(snapshot.data.docs[index].get("Lease_End_Date").toDate().toString(),'dd MMMM yyyy').toString(),)
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:18.0),
                                child: Divider(
                                  height: 20,
                                  thickness: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  Text("Book Received Date: ${getCustomFormattedDateTime(snapshot.data.docs[index].get("Book_Taken_from_Seller_Timestamp").toDate().toString(),'dd MMMM yyyy').toString()}"),
                                  Text("Book Delivered Date: ${getCustomFormattedDateTime(snapshot.data.docs[index].get("Book_Taken_from_Buyer_Timestamp").toDate().toString(),'dd MMMM yyyy').toString()}"),
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
  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
  }
}
