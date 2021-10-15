import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/Onboarding/Onboarding.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:bookollab/Models/OrderIDpayment_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
class testpayment extends StatefulWidget {
  static String id='testpayment_Screen';
  @override
  _testpaymentState createState() => _testpaymentState();
}

class _testpaymentState extends State<testpayment> {
  Razorpay _razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print(response);
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void openCheckout(String id,double amt) async {
    var options = {
      'key': 'rzp_test_qlUviOkjQzWXfJ',
      'amount': amt,
      'order_id': id,
      'name': 'Bookollab',
      'description': 'Harry Potter',
      'prefill': {'contact': '', 'email': ''},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(onPressed: (){
            getOrderID(56000);
          })
        ],
      ),
    );
  }
  Future<OrderIDpayment_model> getOrderID(double amt) async{
    String username="rzp_test_qlUviOkjQzWXfJ";
    String password="KaQ60n8ZkWPdCN2AeImDoPhr";
    final url="https://api.razorpay.com/v1/orders";
    var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
    var dio = Dio();
    await dio.post(url,
        data: {"amount":amt,
        "currency":"INR",
          "receipt":"Undefined"
        },
        options: Options(headers: <String, String>{'authorization': auth})).then((value) {
          print(value.data['id']);
          openCheckout(value.data['id'],amt);
    });
  }
}
