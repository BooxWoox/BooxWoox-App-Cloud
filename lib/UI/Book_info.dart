import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../Models/Book_info_model.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

final _firestore=FirebaseFirestore.instance;
class Book_info extends StatefulWidget {
  static String id='Book_info_Screen';
  @override
  _Book_infoState createState() => _Book_infoState();
}

class _Book_infoState extends State<Book_info> {
  String Book_name="";
  String  doc_address="";
  double _quotedrent=0;
  var result=null;
  Book_info_model Book_item_model;
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();

  Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(Duration.zero,(){
      maindisp_book_info_model itemmodel=ModalRoute.of(context).settings.arguments;
      Book_name=itemmodel.item.BookName;
      doc_address=itemmodel.item.BookCollectionidentity;
      print(Book_name);
      setState(() {
      });
    });
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName);
  }
  void openCheckout(String id,double amt) async {
    var options = {
      'key': 'rzp_test_qlUviOkjQzWXfJ',
      'amount': amt,
      'order_id': id,
      'name': 'Bookollab',
      'description': Book_name,
      'prefill': {'contact': '', 'email': ''},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error:"+e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    maindisp_book_info_model itemmodel=ModalRoute.of(context).settings.arguments;
    if(Book_item_model==null || result==null){
      result=item_details_get(itemmodel.item.BookCollectionidentity).then((value){

        setState(() {

        });
      });
      admin_params_get().then((value) {

        setState(() {

        });
      });
      return Scaffold(
        body: Center(
          child: Text("Fetching Data!",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
        ),
      );
    }
    else
      return Scaffold(
        bottomSheet: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(
                      color: Colors.grey,
                      width: 1.2
                  ))
              ),
              height: 60,
              width: width/2,
              child: ElevatedButton(onPressed: () {  },
                child: Text("ADD TO FAV",style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Colors.white, // background
                  onPrimary: Colors.white, // foreground
                ),),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(
                      color: Colors.grey,
                      width: 1
                  ))
              ),
              height: 60,
              width: width/2,
              child: ElevatedButton(onPressed: () {
                double totalrent=_quotedrent+Book_item_model.quotedDeposit;

                getOrderID(totalrent*100);
              },
                child: Text("RENT NOW",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Color(0xFFFFCC00), // background
                  onPrimary: Colors.white, // foreground
                ),),
            ),
          ],
        ),
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFFFFCC00),
          shadowColor: Color(0xFFF7C100),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 260,
                          width: 170,
                          child: Image.network(Book_item_model.Imageurl,
                              fit: BoxFit.contain),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 20),
                            child: Text(itemmodel.item.BookName,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "LeelawUI",
                                  fontWeight: FontWeight.w800
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Condition: ${Book_item_model.Condition}"),
                                SizedBox(height: 3,),
                                Book_item_model.availability==true?Text("Availability: Yes"):Text("Availability: Yes"),
                                SizedBox(height: 3,),
                                Book_item_model.ISBN!=null||Book_item_model.ISBN!=""?Text("ISBN: ${Book_item_model.ISBN}"):Text("ISBN: Not Provided"),
                                SizedBox(height: 60,),
                                Text("Deposit Amt: \u{20B9} ${Book_item_model.quotedDeposit}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17
                                  ),),
                                Text("Rent/Month: \u{20B9} $_quotedrent",style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17
                                ),)

                              ],
                            ),
                          ),

                        ],

                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Description",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800
                            ),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Book_item_model.Longdescription),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),

              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Condition Description",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800
                            ),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Book_item_model.Conditiondescription),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0),
                child: Divider(
                  height: 20,
                  thickness: 2,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Seller Ratings",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800
                        ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Text("3.9",
                                style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.w400,
                                ),),
                              Icon(Icons.star,
                                size: 35,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:18.0),
                                child: VerticalDivider(
                                  width: 20,
                                  thickness: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  Text("Positive: 20",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontFamily:  "LeelawUI",
                                        color: Colors.grey
                                    ),),
                                  Text("Negative: 5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontFamily:  "LeelawUI",
                                        color: Colors.grey
                                    ),)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80,)
            ],
          ),
        ),
      );
  }
  Future item_details_get(String docname) async{

    try{
      await _firestore.collection("Book_Collection").doc(docname.trim()).get().then((value){
        print(doc_address.trim());
        //Book_item_model=Book_info_model(value.get("Author"), value.get("Availability"), value.get("BookName"), value.get("Condition"), value.get("Dislikes"), value.get("Likes"),value.get("Homepage_category"), value.get("ImageUrl"), value.get("Long Description"), value.get("MRP"), value.get("QuotedDeposit"), value.get("OwnerRatings"), value.get("OwnerUID"), value.get("Quantity"), value.get("category"), value.get("Condition Description"),value.get("ISBN"));
        String author=value.get("Author");
        bool Availability=value.get("Availability");
        String Bookname=value.get("BookName");
        String condition=value.get("Condition");
        int dislike=value.get("Dislikes");
        int like=value.get("Likes");
        String hmcat=value.get("Homepage_category");
        String Imageurl=value.get("ImageUrl");
        String lgdesc=value.get("Long Description");
        double mrp=value.get("MRP");
        double quotedprice=value.get("QuotedDeposit");
        String owneratings=value.get("OwnerRatings");
        String owneruid=value.get("OwnerUID");
        int quant=value.get("Quantity");
        String category=value.get("category");
        String conditiondesc=value.get("Condition Description");
        String isbn=value.get("ISBN");
        Book_item_model=Book_info_model(author,Availability,Bookname,condition,dislike,like,hmcat,Imageurl,lgdesc,mrp,quotedprice,owneratings,owneruid,quant,category,conditiondesc,isbn);
        print(Bookname+"OOOOOOOOOOOOOOOOPPPPPPPPP");
        return true;
      });
    }catch(e){
      print(e);

    }
    return false;
  }
  void getOrderID(double amt) async{
    String username="rzp_test_qlUviOkjQzWXfJ";
    String password="KaQ60n8ZkWPdCN2AeImDoPhr";
    final url="https://api.razorpay.com/v1/orders";
    var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
    var dio = Dio();
    await dio.post(url,
        data: {
          "amount":amt,
          "currency":"INR",
          "receipt":"Undefined"
        },
        options: Options(headers: <String, String>{'authorization': auth})).then((value) {
      print(value.data['id']);
      openCheckout(value.data['id'],amt);
    });
  }


  Future admin_params_get() async{
    try{
      await _firestore.collection("Admin").doc("Quoted_Parameters").get().then((value){
        _quotedrent=value.get("Quoted_Rent");
        return true;
      });
    }catch(e){
      print("yohooooooooooooooooo2");

    }
    return false;
  }
}