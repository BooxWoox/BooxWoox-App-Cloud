import 'package:bookollab/UI/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'dart:io';
import 'maindisplaypage.dart';
import 'dart:async';
import 'package:bookollab/UI/Chat/chat_homepage.dart';
import 'package:bookollab/UI/Notification/notification.dart';
import 'package:flare_flutter/flare_actor.dart';


import 'package:flutter/services.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:image_picker/image_picker.dart';


class AddBookPage extends StatefulWidget {
  static String id='AddBookPage_Screen';
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  File _ImageFile;
  String barcoderesult = "";
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  String BookName="",Author="",condition="",bkdesc="";
  double MRP=0;
  double quotedprice=0;
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
        bottomSheet:RaisedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
            child: Container(
              width: width,
              height: 25,
              child: Center(
                child: FittedBox(
                  child: Row(
                    children: [
                      Icon(Icons.book_outlined),
                      Text(' Submit',style: TextStyle(
                          fontFamily: 'LeelawUI',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          color: Color(0xFFFFCC00),

          onPressed: () async{

          },

        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Book Name",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "LeelawUI",
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value){
                        BookName =value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[290],
                        hintText: "Type your Book Name..",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Author",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                                child: TextField(
                                  onChanged: (value){
                                    Author =value;
                                  },
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[290],
                                    hintText: "Optional",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Condition",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                                child: TextField(
                                  onChanged: (value){
                                    condition =value;
                                  },
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[290],
                                    hintText: "Used or New",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ISBN (Optional)",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LeelawUI",
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            onChanged: (value){
                              barcoderesult =value;
                            },
                            autocorrect: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[290],
                              hintText: "Scan QR or type manually",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.camera_alt), onPressed:(){
                          //_scanQR();
                        })
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("MRP",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  MRP =double.parse(value);
                                },
                                autocorrect: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[290],
                                  hintText: "Enter MRP",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Quoted Price",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value){
//                                  if(double.parse(value)>(60/100)*MRP){
//                                    quotedprice =(60/100)*MRP;
//                                  }else{
                                    quotedprice=double.parse(value);
                                  //}

                                },
                                autocorrect: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[290],
                                  hintText: " < 60% of MRP",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Book Description (Optional)",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LeelawUI",
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value){
                        bkdesc =value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[290],
                        hintText: "Enter Info of Book..",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Upload Front Book Cover",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LeelawUI",
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
                      child: Container(
                        width: width,
                        height: 25,
                        child: Center(
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt),
                                Text(' Capture',style: TextStyle(
                                    fontFamily: 'LeelawUI',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    color: Color(0xFFFFCC00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    onPressed: () async{
//                      _pickImage(ImageSource.camera).whenComplete((){
//                        _cropImage();
//                      });
                    },

                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
//  Future _scanQR() async {
//    try {
//      String qrResult = await BarcodeScanner.scan();
//      setState(() {
//        barcoderesult = qrResult;
//      });
//    } on PlatformException catch (ex) {
//      if (ex.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          barcoderesult = "Camera permission was denied";
//        });
//      } else {
//        setState(() {
//          barcoderesult = "Unknown Error $ex";
//        });
//      }
//    } on FormatException {
//      setState(() {
//        barcoderesult = "You pressed the back button before scanning anything";
//      });
//    } catch (ex) {
//      setState(() {
//        barcoderesult = "Unknown Error $ex";
//      });
//    }
//  }
//  Future<void> _pickImage(ImageSource source) async{
//    File selected=await ImagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      _ImageFile=selected;
//    });
//  }
//
//  Future<void> _cropImage() async{
//    File croppped=await ImageCropper.cropImage(sourcePath: _ImageFile.path,
//    );
//    setState(() {
//      _ImageFile=croppped??_ImageFile;
//    });
//  }
}

