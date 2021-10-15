import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReceivedNotReturn extends StatefulWidget {

  @override
  _ReceivedNotReturnState createState() => _ReceivedNotReturnState();
}

class _ReceivedNotReturnState extends State<ReceivedNotReturn> {

  String RnRbookName = 'Perscient';
  String RnRauthorName = 'D.S. Murphy';
  String RnRmedium = 'Self';
  String RnRorderID = 'abcdef';
  String RnRpayID = 'abcdef';
  String RnRbookID = 'abcdef';
  String RnRownerContactNumebr = '1234567890';
  String rentDate = 'dd/mm/yyyy';
  String lastDate = 'dd/mm/yyyy';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.grey,
                height: 100,
                width: 75,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(RnRbookName + '-' + RnRauthorName, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text('Medium of transfer: ' + RnRmedium, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Order ID: ' + RnRorderID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Pay ID: ' + RnRpayID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Book ID: ' + RnRbookID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Owner Contact No.: ' + RnRownerContactNumebr, style: TextStyle(color: Colors.black, fontSize: 15),),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                width: 24,
              ),
                  Text('Rent start date', style: TextStyle(color: Colors.grey, fontSize: 15),),
                  SizedBox(
                    width: 36,
                  ),
                  Text('last date to initiate return', style: TextStyle(color: Colors.grey, fontSize: 15),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                width: 28,
              ),
                  Text(rentDate, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 48,
                  ),
                  Text(lastDate, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}









class BookNotReceived extends StatefulWidget {

  @override
  _BookNotReceivedState createState() => _BookNotReceivedState();
}

class _BookNotReceivedState extends State<BookNotReceived> {

  String BnRbookName = 'Perscient';
  String BnRauthorName = 'D.S. Murphy';
  String BnRmedium = 'Self';
  String BnRorderID = 'abcdef';
  String BnRpayID = 'abcdef';
  String BnRbookID = 'abcdef';
  String BnRownerContactNumebr = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.grey,
                height: 100,
                width: 75,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(BnRbookName + '-' + BnRauthorName, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text('Medium of transfer: ' + BnRmedium, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Order ID: ' + BnRorderID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Pay ID: ' + BnRpayID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Book ID: ' + BnRbookID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Owner Contact No.: ' + BnRownerContactNumebr, style: TextStyle(color: Colors.black, fontSize: 15),),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('*Please return the book in X-Y days, Post that then returning duration will start!', style: TextStyle(color: Colors.grey, fontSize: 15),),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Icon(Icons.location_pin),
              TextButton(
                child: Text('See your book\'s location', style: TextStyle(color: Colors.blue, fontSize: 14)),
                onPressed: (){},
              ),

              SizedBox(
                width: 40,
              ),

              ElevatedButton(
                onPressed: (){},
                child: Text('Cancel Order', style: TextStyle(fontSize: 15, color: Colors.red),),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  primary: Colors.transparent,
                  onSurface: Colors.red,
                  onPrimary: Colors.red,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}










class ReturnInitiated extends StatefulWidget {

  @override
  _ReturnInitiatedState createState() => _ReturnInitiatedState();
}

class _ReturnInitiatedState extends State<ReturnInitiated> {

  String RIbookName = 'Perscient';
  String RIauthorName = 'D.S. Murphy';
  String RImedium = 'Self';
  String RIorderID = 'abcdef';
  String RIpayID = 'abcdef';
  String RIbookID = 'abcdef';
  String RIownerContactNumebr = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.grey,
                height: 100,
                width: 75,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(RIbookName + '-' + RIauthorName, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text('Medium of transfer: ' + RImedium, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Order ID: ' + RIorderID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Pay ID: ' + RIpayID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Book ID: ' + RIbookID, style: TextStyle(color: Colors.black, fontSize: 15),),
                  Text('Owner Contact No.: ' + RIownerContactNumebr, style: TextStyle(color: Colors.black, fontSize: 15),),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('*Please return the book in X-Y days, Post that penalties will be applicable.', style: TextStyle(color: Colors.grey, fontSize: 15),),
              SizedBox(
                height: 2,
              ),
              Text('*Please give the book only afteer.', style: TextStyle(color: Colors.grey, fontSize: 15),),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Icon(Icons.location_pin),
              TextButton(
                child: Text('See your book\'s location', style: TextStyle(color: Colors.blue, fontSize: 14)),
                onPressed: (){},
              ),

              SizedBox(
                width: 40,
              ),

              ElevatedButton(
                onPressed: (){},
                child: Text('Confirm Return', style: TextStyle(fontSize: 15, color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  primary: Color(0xFFFFCC00),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}