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
import 'package:sweetsheet/sweetsheet.dart';


final _firestore=FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class Ongoing_transaction_Buyer extends StatefulWidget {
  static String id='Ongoing_transaction_Screen';
  @override
  _Ongoing_transaction_BuyerState createState() => _Ongoing_transaction_BuyerState();
}

class _Ongoing_transaction_BuyerState extends State<Ongoing_transaction_Buyer> {
  final SweetSheet _sweetSheet = SweetSheet();
  String Buyer_fullname="";
  String Seller_fullname="";
  String Bkname="";
  @override
  Widget build(BuildContext context) {
    String UserUID=_auth.currentUser.uid.toString();
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("Transactions")
              .where("BuyerUID",isEqualTo:UserUID)
              .where("Payment_Status",isEqualTo: "Success")
              .where("Order_Status",isEqualTo: "Ongoing")
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: StrutStyle(fontSize: 17.0),
                                            text:TextSpan(
                                              text: snapshot.data.docs[index].get("Book_Name"),
                                              style:TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ) ,
                                          ),
                                        ),
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
                                            Text("Paid Amt: "),
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
                                    snapshot.data.docs[index].get("Book_Taken_from_Seller")?Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.assignment_return,color: Colors.redAccent,size: 24,), onPressed: (){
                                              String buyeruid=snapshot.data.docs[index].get("BuyerUID");
                                              String selleruid=snapshot.data.docs[index].get("SellerUID");
                                              double buyershare=double.parse(snapshot.data.docs[index].get("BuyerShare_Amt").toString());
                                              double sellershare=double.parse(snapshot.data.docs[index].get("SellerShare_Amt").toString());
                                              String buyerphn=snapshot.data.docs[index].get("Buyer_PhoneNumber");
                                              String sellerphn=snapshot.data.docs[index].get("Seller_PhoneNumber");
                                              String orderid=snapshot.data.docs[index].id;
                                              double totalamt=double.parse(snapshot.data.docs[index].get("Total_Amt").toString());
                                              //Confirmation from user
                                              _sweetSheet.show(
                                                context: context,
                                                title: Text("Warning"),
                                                description: Text(
                                                    'This action is irreversible\nAre you sure?'),
                                                color: SweetSheetColor.WARNING,
                                                icon: Icons.warning,
                                                positive: SweetSheetAction(
                                                  onPressed: () {
                                                    if(snapshot.data.docs[index].get("Buyer_Return_Initiation")){
                                                      _onBasicWaitingAlertPressed(context, "Return request has already been initiated");
                                                    }else{
                                                      ReturnInitaiation(snapshot.data.docs[index].id,snapshot.data.docs[index].get("Seller_Address"),snapshot.data.docs[index].get("Buyer_Address"),buyeruid,selleruid,buyershare,sellershare,buyerphn,sellerphn,orderid,totalamt,
                                                          snapshot.data.docs[index].get("Book_Name"));
                                                    }
                                                    Navigator.pop(context);

                                                  },
                                                  title: 'CONTINUE',
                                                  color: Colors.white,
                                                  icon: Icons.open_in_new,
                                                ),
                                                negative: SweetSheetAction(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  title: 'CANCEL',
                                                ),
                                              );
                                        }),
                                        Text("Return"),
                                      ],
                                    ):SizedBox(),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                                  child: Divider(
                                    height: 20,
                                    thickness: 2,
                                  ),
                                ),
                                snapshot.data.docs[index].get("Book_Taken_from_Seller")==false?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Have you collected the book from seller or want to cancel?"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            FlatButton(
                                              color:Colors.greenAccent,
                                                onPressed: (){
                                                //confirmation warning
                                                  _sweetSheet.show(
                                                    context: context,
                                                    title: Text("Warning"),
                                                    description: Text(
                                                        'This action is irreversible\nAre you sure?'),
                                                    color: SweetSheetColor.WARNING,
                                                    icon: Icons.warning,
                                                    positive: SweetSheetAction(
                                                      onPressed: () {
                                                        _confirming_received_from_seller(snapshot.data.docs[index].id);
                                                        Navigator.pop(context);
                                                      },
                                                      title: 'CONTINUE',
                                                      color: Colors.white,
                                                      icon: Icons.open_in_new,
                                                    ),
                                                    negative: SweetSheetAction(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      title: 'CANCEL',
                                                    ),
                                                  );

                                                }, child: Text("Yes, Received")),
                                            FlatButton(
                                                color:Colors.red,
                                                onPressed: (){
                                                  String buyeruid=snapshot.data.docs[index].get("BuyerUID");
                                                  String selleruid=snapshot.data.docs[index].get("SellerUID");
                                                  double buyershare=double.parse(snapshot.data.docs[index].get("BuyerShare_Amt").toString());
                                                  double sellershare=double.parse(snapshot.data.docs[index].get("SellerShare_Amt").toString());
                                                  String buyerphn=snapshot.data.docs[index].get("Buyer_PhoneNumber");
                                                  String sellerphn=snapshot.data.docs[index].get("Seller_PhoneNumber");
                                                  String orderid=snapshot.data.docs[index].id;
                                                  double totalamt=double.parse(snapshot.data.docs[index].get("Total_Amt").toString());

                                                  //confirmation warning
                                                  _sweetSheet.show(
                                                    context: context,
                                                    title: Text("Warning"),
                                                    description: Text(
                                                        'This action is irreversible\nAre you sure?'),
                                                    color: SweetSheetColor.WARNING,
                                                    icon: Icons.warning,
                                                    positive: SweetSheetAction(
                                                      onPressed: () {
                                                        cancelorderrequest(snapshot.data.docs[index].id,snapshot.data.docs[index].get("Seller_Address"),snapshot.data.docs[index].get("Buyer_Address"),buyeruid,selleruid,buyershare,sellershare,buyerphn,sellerphn,orderid,totalamt);
                                                        Navigator.pop(context);
                                                      },
                                                      title: 'CONTINUE',
                                                      color: Colors.white,
                                                      icon: Icons.open_in_new,
                                                    ),
                                                    negative: SweetSheetAction(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      title: 'CANCEL',
                                                    ),
                                                  );



                                                }, child: Text("Cancel Order")),
                                          ],
                                        )

                                      ],
                                    ):
                                    Column(
                                      children: [
                                        Text("Book Received Date: ${getCustomFormattedDateTime(snapshot.data.docs[index].get("Book_Taken_from_Seller_Timestamp").toDate().toString(),'dd MMMM yyyy').toString()}"),
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
  void ReturnInitaiation(String docID,String to_address,String from_address,String BuyerUID,String SellerUID,double Buyershareamt,double Sellershareamt,String buyerphn,String sellerphn,String orderID,double totalamt,String bookname){
    _firestore.collection("Transactions").doc(docID).update({
      "Buyer_Return_Initiation":true,
    }).then((value) {
      _firestore.collection("Transactions").doc(orderID).get().then((value) {
        setState(() {
          Buyer_fullname=value.get("BuyerFullName");
          Seller_fullname=value.get("SellerFullName");
        });
      }).then((value) {
        countDocuments("Delivery_System").then((value) {
          _firestore.collection("Delivery_System").doc(orderID+SellerUID).set({
            "Seq_No":value.toInt()+1,
            "BookName":bookname,
            "Order_ID":orderID,
            "Total_Amt":totalamt,
            "Status":"Delivering",
            "BuyerUID":BuyerUID,
            "SellerUID":SellerUID,
            "BuyerShare_Amt":Buyershareamt,
            "SellerShare_Amt":Sellershareamt,
            "from_Name":Buyer_fullname,
            "to_Name":Seller_fullname,
            "from_PhoneNumber":buyerphn,
            "to_PhoneNumber":sellerphn,
            "to_address":to_address,
            "order_creation_date":DateTime.now(),
            "from_address":from_address,
          });
        }).then((value){
          _firestore.collection("Notification_Messages").doc().set({
            'userUID':SellerUID,
            'isSeen':false,
            'Timestamp':DateTime.now(),
            'Message': "Borrower has initiated a return request for book ${bookname} \n It will take 5-6 days to be delivered to you."
          });
        });
      });
    }).then((value) {
      _onBasicSuccessAlert(context, "Return Request Initiated");
    });
  }
  void _confirming_received_from_seller(String docID){
    _firestore.collection("Transactions").doc(docID).update({
      "Book_Taken_from_Seller":true,
      "Book_Taken_from_Seller_Timestamp":DateTime.now(),
    }).then((value) {

    });
  }
  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
  }
  void cancelorderrequest(String docID,String to_address,String from_address,String BuyerUID,String SellerUID,double Buyershareamt,double Sellershareamt,String buyerphn,String sellerphn,String orderID,double totalamt){
    String bkcollectionId="";
    _firestore.collection("Transactions").doc(docID).get().then((value) {
      Buyer_fullname=value.get("BuyerFullName");
      Seller_fullname=value.get("SellerFullName");
      Bkname=value.get("Book_Name");
      bkcollectionId=value.get("BookCollection_ID");
    }).then((value) {
      _firestore.collection("Transactions").doc(docID).delete().then((value) {
        _firestore.collection("Admin_Refund_Transactions").doc().set({
          "Order_ID":orderID,
          "Total_Amt":totalamt,
          "Status":"Delivering",
          "Refund_Status":false,
          "Refund_Type":"Cancelled",
          "Refund_Timestamp":"",
          "BuyerUID":BuyerUID,
          "SellerUID":SellerUID,
          "BuyerShare_Amt":Buyershareamt,
          "SellerShare_Amt":Sellershareamt,
          "BuyerFullName":Buyer_fullname,
          "SellerFullName":Seller_fullname,
          "Buyer_PhoneNumber":buyerphn,
          "Seller_PhoneNumber":sellerphn,
          "Buyer_Address":from_address,
          "order_creation_date":DateTime.now(),
          "Seller_Address":to_address,
        }).then((value){
          _firestore.collection("Delivery_System").doc(orderID+BuyerUID).delete().then((value) {
          }).then((value) {
            _firestore.collection("Notification_Messages").doc().set({
              'userUID':SellerUID,
              'isSeen':false,
              'Timestamp':DateTime.now(),
              'Message': "Borrower has cancelled the request for book ${Bkname}"
            });
          }).then((value) {
            _firestore.collection("Book_Collection").doc(bkcollectionId).update({
              'Availability':true,
            }).then((value){
              _onBasicSuccessAlert(context, "Order cancelled and money will be refunded with 3-4 working days");
            });
          });
        });
      });
    });



    // _firestore.collection("Admin_Refund_Transactions").doc().
  }

  _onBasicSuccessAlert(context,String descrip) async {
    await Alert(
      type: AlertType.success,
      context: context,
      title: "Success",
      desc: descrip,
    ).show();
    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }
  _onBasicWaitingAlertPressed(context,String descrip) async {
    await Alert(
      type: AlertType.error,
      context: context,
      title: "Warning",
      desc: descrip,
    ).show();
    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }
  Future<int> countDocuments(String collectionID) async {
    QuerySnapshot _myDoc = await _firestore.collection(collectionID).get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return (_myDocCount.length);  // Count of Documents in Collection
  }
}

