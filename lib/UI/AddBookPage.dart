import 'package:bookollab/UI/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'dart:io';
import 'maindisplaypage.dart';
import 'dart:async';
import 'package:bookollab/UI/Chat/chat_homepage.dart';
import 'package:bookollab/UI/Notification/notification.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
//import 'package:image_cropper/image_cropper.dart';



class AddBookPage extends StatefulWidget {
  static String id='AddBookPage_Screen';
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  String _scanBarcode = '';
  TextEditingController _controller;

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
                            controller: _controller,
                            onChanged: (value){
                              _scanBarcode =value;
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
                          scanBarcodeNormal();
                          setState(() {
                            
                          });
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
                     _pickImage(ImageSource.camera);
                    },

                  ),
                  SizedBox(height: 50,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes="";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if(barcodeScanRes=="-1"){
        _controller.clear();
      }
      else{
        _controller = new TextEditingController(text: barcodeScanRes);
        _scanBarcode = barcodeScanRes;
      }

    });
  }


 Future<void> _pickImage(ImageSource source) async{
   File selected=await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 500,maxWidth: 500);
   if(selected!=null){
     _ImageFile=selected;
     File _croppedImage = await ImageCropper.cropImage(
         sourcePath: selected.path,
         aspectRatioPresets: [
           CropAspectRatioPreset.square,
           CropAspectRatioPreset.ratio3x2,
           CropAspectRatioPreset.original,
           CropAspectRatioPreset.ratio4x3,
           CropAspectRatioPreset.ratio16x9
         ],

         androidUiSettings: AndroidUiSettings(
             toolbarColor: Colors.blue,
             toolbarTitle: 'Cropper',
             statusBarColor: Colors.blue[700],
             initAspectRatio: CropAspectRatioPreset.original,
             lockAspectRatio: false
         )
     );
     setState(() {
       //_ImageFile=_croppedImage??_ImageFile;
     });
   }
 }


}

