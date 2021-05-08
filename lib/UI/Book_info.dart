import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../Models/Book_info_model.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:jiffy/jiffy.dart';

final _firestore=FirebaseFirestore.instance;
class Book_info extends StatefulWidget {
  static String id='Book_info_Screen';
  @override
  _Book_infoState createState() => _Book_infoState();
}

class _Book_infoState extends State<Book_info> {

  String Book_name="";
  String Buyer_address="";
  String  doc_address="";
  String Buyer_phnumber="";
  double _quotedrentpercent=0;
  List<int> _LeasePeriod=[];
  var result=null;
  int leaseduration=0;
  String OrderID="";
  int _selectedLeaseperiod=0;
  Book_info_model Book_item_model;
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  String useruid=FirebaseAuth.instance.currentUser.uid;
  double totalrent=0;
  Razorpay _razorpay;
  maindisp_book_info_model itemmodeltemp;
  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(Duration.zero,(){
      itemmodeltemp=ModalRoute.of(context).settings.arguments;
      Book_name=itemmodeltemp.item.BookName;
      doc_address=itemmodeltemp.item.BookCollectionidentity;
      print(Book_name);
      setState(() {

      });
    });
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " + response.paymentId);
    //Update to database for entries
    DateTime Leasestartdate=DateTime.now().add(Duration(days:10));
    _firestore.collection("Transactions").doc(response.orderId).set({
      'BuyerUID':useruid,
      'ImageURL':itemmodeltemp.item.ImageURl,
      'SellerUID':itemmodeltemp.item.OwnerUID,
      'Payment_Status':"Success",
      'Order_ID':response.orderId,
      'Payment_ID':response.paymentId,
      'Book_Name':Book_name,
      'Order_Status':"Ongoing",
      'Buyer_Address':Buyer_address,
      'Buyer_PhoneNumber':Buyer_phnumber,
      'Seller_Address':itemmodeltemp.item.Seller_address,
      'Seller_PhoneNumber':itemmodeltemp.item.Seller_phnNumber,
      'Book_Taken_from_Seller':false,
      'Book_Taken_from_Buyer':false,
      'Book_Taken_from_Seller_Timestamp':DateTime.now(),
      'Book_Taken_from_Buyer_Timestamp':DateTime.now(),
      'Total_Amt':totalrent,
      'Lease_Duration':_selectedLeaseperiod,
      'Lease_Start_Date':Leasestartdate,
      'Lease_End_Date':Leasestartdate.add(Duration(days:_selectedLeaseperiod*40)),
    }).then((value) {
      print(itemmodeltemp.item.BookCollectionidentity);
      _firestore.collection("Book_Collection").doc(itemmodeltemp.item.BookCollectionidentity.trim()).update({
        'Availability':false
      }).then((value) {
        _firestore.collection("Users").doc(useruid).collection("Chat").doc(itemmodeltemp.item.OwnerUID.trim()).collection("Messages").add({
          "Msg_Type":"BKRENT_INFO",
          "text":Buyer_MSG_TEXT(Book_name,response.orderId),
          "from":itemmodeltemp.item.OwnerUID.trim(),
          "to":useruid.trim(),
          "timestamp":DateTime.now(),
          "Book_Collection_identity":itemmodeltemp.item.BookCollectionidentity.trim(),
          "BookName":Book_name,
          "SellerUID":itemmodeltemp.item.OwnerUID.trim(),
          "BuyerUID":useruid
        }).then((value) {
          _firestore.collection("Users").doc(itemmodeltemp.item.OwnerUID.trim()).collection("Chat").doc(useruid).collection("Messages").add({
            "Msg_Type":"BKRENT_INFO",
            "text":Seller_MSG_TEXT(Book_name,response.orderId),
            "from":useruid,
            "to":itemmodeltemp.item.OwnerUID.trim(),
            "timestamp":DateTime.now(),
            "Book_Collection_identity":itemmodeltemp.item.BookCollectionidentity.trim(),
            "BookName":Book_name,
            "SellerUID":itemmodeltemp.item.OwnerUID.trim(),
            "BuyerUID":useruid
          }).then((value) {
            Navigator.pop(context);
            _onBasicSuccessAlert(context, "Payment Successfully Completed");
          });

        });

      });

    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,);
    DateTime Leasestartdate=DateTime.now().add(Duration(days:10));
    _firestore.collection("Transactions").doc(OrderID).set({
      'BuyerUID':useruid,
      'ImageURL':itemmodeltemp.item.ImageURl,
      'SellerUID':itemmodeltemp.item.OwnerUID,
      'Payment_Status':"Failed",
      'Order_ID':OrderID,
      'Payment_ID':"NULL",
      'Book_Name':Book_name,
      'Order_Status':"Failed",
      'Buyer_Address':Buyer_address,
      'Buyer_PhoneNumber':Buyer_phnumber,
      'Seller_Address':itemmodeltemp.item.Seller_address,
      'Seller_PhoneNumber':itemmodeltemp.item.Seller_phnNumber,
      'Failure_Reason': response.message,
      'Book_Taken_from_Seller':false,
      'Book_Taken_from_Buyer':false,
      'Book_Taken_from_Seller_Timestamp':DateTime.now(),
      'Book_Taken_from_Buyer_Timestamp':DateTime.now(),
      'Total_Amt':totalrent,
      'Lease_Duration':_selectedLeaseperiod,
      'Lease_Start_Date':Leasestartdate,
      'Lease_End_Date':Leasestartdate.add(Duration(days:_selectedLeaseperiod*40)),
    }).then((value) {
      _onBasicWaitingAlertPressed(context, response.message);
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName);
  }
  void openCheckout(String id,double amt, String buyer_address,String buyer_phnumber) async {
    var options = {
      'key': 'rzp_test_qlUviOkjQzWXfJ',
      'amount': amt,
      'order_id': id,
      'name': 'BooxWooX',
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
          //refreshing views
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
                if(checkparameters(_selectedLeaseperiod)){
                  totalrent=(((_quotedrentpercent/100)*Book_item_model.quotedDeposit)*_selectedLeaseperiod)+Book_item_model.quotedDeposit;
                  showModalBottomSheet(context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                      ),
                      builder: (BuildContext context){
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius:35,
                                  backgroundColor: Colors.black12,
                                  backgroundImage: AssetImage("UIAssets/BookInfo/map.png"),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 18,),
                                  Icon(Icons.location_city_rounded),
                                  Text("Delivery Address",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical:8),
                                child: Container(
                                  height:55,
                                  child: TextField(
                                    onChanged: (value){
                                      Buyer_address=value;
                                    },
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[290],
                                      hintText: "Type your delivery address..",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 18,),
                                  Icon(Icons.phone_android),
                                  Text("Phone Number",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical:8),
                                child: Container(
                                  height:55,
                                  child: TextField(
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value){
                                      Buyer_phnumber=value;
                                    },
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[290],
                                      hintText: "Contact Number",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical:12.0,horizontal: 12),
                                    child: Container(
                                      width: 110,
                                      height: 25,
                                      child: Center(
                                        child: FittedBox(
                                          child: Text('Continue',style: TextStyle(
                                              fontFamily: 'LeelawUI',
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Color(0xFFFFCC00),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  onPressed: () async{
                                    if(Buyer_address==null||Buyer_address.trim().length==0||Buyer_address==""||Buyer_phnumber==null||Buyer_phnumber==""){
                                      _onBasicWaitingAlertPressed(context, "All fields are mandatory");
                                    }else{
                                      getOrderID(totalrent*100,Buyer_address,Buyer_phnumber);
                                    }

                                  },

                                ),
                              ),

                            ],
                          ),
                        );
                      });
                  //getOrderID(totalrent*100);
                }

              },
                child: Text("BORROW NOW",style: TextStyle(color: Colors.white),),
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
                                Book_item_model.availability==true?Text("Availability: Yes"):Text("Availability: No"),
                                SizedBox(height: 3,),
                                Book_item_model.ISBN!=null||Book_item_model.ISBN!=""?Text("ISBN: ${Book_item_model.ISBN}"):Text("ISBN: Not Provided"),
                                SizedBox(height: 60,),
                                Text("Deposit Amt: \u{20B9} ${Book_item_model.quotedDeposit}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17
                                  ),),
                                Text("Rent/Month: \u{20B9} ${_quotedrentpercent*Book_item_model.quotedDeposit/100}",style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17
                                ),),
                                DropDown(
                                  items: _LeasePeriod,
                                  hint: Text("Select Lent Duration"),
                                  onChanged: (value){
                                    print(value);
                                    _selectedLeaseperiod=value;
                                  },
                                )

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
        leaseduration=value.get("LeaseDuration");
        _LeasePeriod.clear();
        for(int i=1;i<=leaseduration;i++){
          _LeasePeriod.add(i);
        }
        Book_item_model=Book_info_model(author,Availability,Bookname,condition,dislike,like,hmcat,Imageurl,lgdesc,mrp,quotedprice,owneratings,owneruid,quant,category,conditiondesc,isbn,leaseduration);
        print(Bookname+"OOOOOOOOOOOOOOOOPPPPPPPPP");
        return true;
      });
    }catch(e){
      print(e);

    }
    return false;
  }
  void getOrderID(double amt, String buyer_address,String buyer_phnumber) async{
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
      OrderID=value.data['id'];
      openCheckout(value.data['id'],amt,buyer_address,buyer_phnumber);
    });
  }


  Future admin_params_get() async{
    try{
      await _firestore.collection("Admin").doc("Quoted_Parameters").get().then((value){

        _quotedrentpercent=value["Quoted_Rent_Percent"];
        return true;
      });
    }catch(e){
      print("yohooooooooooooooooo2"+e);

    }
    return false;
  }
  bool checkparameters(int selectedLeaseperiod) {
    if(selectedLeaseperiod==0||selectedLeaseperiod==null){
      _onBasicWaitingAlertPressed(context, "Select Lending Period");
      return false;
    }
    return true;
  }
  //validating user fields
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
  String Buyer_MSG_TEXT(String BookName,String OrderID){
    String text='''
  Your transaction for book $BookName with Order ID :$OrderID has been successful.
  Now please read the below provided instructions and complete the further process as mentioned.
  Instructions
- Post the payment, you have a 1 week duration (Transfer Window) within which the transfer of the book must be made from the lender to borrower. Any delay from the lenders end, will result in a penalty to the lender. Once the one week duration ends, the borrowing period will begin and hence, the borrower must make sure he/she receives the book before that. If the borrower receives the book within the one week duration, he/she would be required to accept the receiving of the borrowed book in the app.

- The borrower and lender are requested to follow all Covid Guidelines when making the transfer for your and your family's safety and good health.

- Towards the end of the borrowing period, another extra 1 week duration will be provided to both parties and the lender must make sure to receive the book back before that period ends. In case of any delay from the borrower's end, a penalty will be applicable on the borrower.

- If the borrower wishes to extend the borrowing period, he/she will have to initiate a request from 'My Borrowed Books' section regarding the same. Once the lender approves the request, the borrower will have to make a payment for borrowing the book for the next period. Please note that, the period won't be extended unless the payment has been made before the borrowing period ends. In any such case, the extension request will be rejected automatically.

- If upon returning the book, there is any issue regarding condition of book or if any damage is done to the book, the lender can raise an issue through the app and the matter will be looked into by our team and resolved accordingly. If any penalties are induced then an amount will be deducted from the security deposited which will be decided by our team.

- If there is no issue and the book has been safely returned, the lender will have to confirm the receiving of the book in the app and thereafter the deposit will be returned to the borrower. It is suggested that the book verification and receiving be done in front of the lender to avoid any issues later. Once, the receiving is confirmed, the transfer will be considered closed and complete and no further issues for that transaction will be entertained.
  ''';
    return text;
  }
  String Seller_MSG_TEXT(String BookName,String OrderID){
    String text='''
  A transaction for book $BookName with Order ID :$OrderID has been initiated with a confirmed payment.
  Now please read the below provided instructions and complete the further process as mentioned as a SELLER.
  Instructions
- Post the payment, you have a 1 week duration (Transfer Window) within which the transfer of the book must be made from the lender to borrower. Any delay from the lenders end, will result in a penalty to the lender. Once the one week duration ends, the borrowing period will begin and hence, the borrower must make sure he/she receives the book before that. If the borrower receives the book within the one week duration, he/she would be required to accept the receiving of the borrowed book in the app.

- The borrower and lender are requested to follow all Covid Guidelines when making the transfer for your and your family's safety and good health.

- Towards the end of the borrowing period, another extra 1 week duration will be provided to both parties and the lender must make sure to receive the book back before that period ends. In case of any delay from the borrower's end, a penalty will be applicable on the borrower.

- If the borrower wishes to extend the borrowing period, he/she will have to initiate a request from 'My Borrowed Books' section regarding the same. Once the lender approves the request, the borrower will have to make a payment for borrowing the book for the next period. Please note that, the period won't be extended unless the payment has been made before the borrowing period ends. In any such case, the extension request will be rejected automatically.

- If upon returning the book, there is any issue regarding condition of book or if any damage is done to the book, the lender can raise an issue through the app and the matter will be looked into by our team and resolved accordingly. If any penalties are induced then an amount will be deducted from the security deposited which will be decided by our team.

- If there is no issue and the book has been safely returned, the lender will have to confirm the receiving of the book in the app and thereafter the deposit will be returned to the borrower. It is suggested that the book verification and receiving be done in front of the lender to avoid any issues later. Once, the receiving is confirmed, the transfer will be considered closed and complete and no further issues for that transaction will be entertained.
  ''';
    return text;
  }
}

