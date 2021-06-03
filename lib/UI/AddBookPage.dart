
import 'package:bookollab/UI/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'LoginPage.dart';
import 'dart:io';
import 'package:images_picker/images_picker.dart';
import 'maindisplaypage.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:bookollab/UI/Homepage.dart';
import 'package:random_string/random_string.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


final _firestore=FirebaseFirestore.instance;
FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
class AddBookPage extends StatefulWidget {
  static String id='AddBookPage_Screen';
  @override
  _AddBookPageState createState() => _AddBookPageState();
}
class _AddBookPageState extends State<AddBookPage>  {
  final SweetSheet _sweetSheet = SweetSheet();
  int leaseduration=-1;
  String _scanBarcode = '';
  TextEditingController _controller;
  String cityName="Select Your City";
  File _ImageFile;
  String barcoderesult = "";
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  String BookName="",Author="",condition="",bkdesc="",pickup_address="",seller_UPI="",seller_phone="",Seller_fullname="";
  double MRP=0;
  double quotedprice=0;
  double rentprice=0;
  double commission_fee=10; //By default

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSellerDetails(FirebaseAuth.instance.currentUser.uid);
    getQuotedParameters();
  }
  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Books"),
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
            if(check(cityName,BookName,condition,MRP,quotedprice,_ImageFile,leaseduration,pickup_address,seller_UPI,seller_phone,Seller_fullname)){
              //checks passed
              pd.show(max: 100, msg: 'Uploading...');

              //TEMPORARY SEARCHING ALGORITHM(SPLITIING STRING METHOD)
              List<String> splitList=BookName.split(' ');
              List<String> indexList=[];

              //backend starts
              String useruid=FirebaseAuth.instance.currentUser.uid;
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              final String formattedDate = formatter.format(DateTime.now());
              String uploadname=useruid+formattedDate+randomAlphaNumeric(10)+BookName.trim().replaceAll(' ', '');

              try{
                var reference=_firebaseStorage.ref()
                    .child('BookFrontCovers')
                    .child('/${uploadname}.jpg');
                reference.putFile(_ImageFile).then((val){
                  pd.update(value: 50);
                  String docid=(DateTime.now().toString())+useruid;
                  val.ref.getDownloadURL().then((value) {
                    _firestore.collection("Book_Collection").doc(docid).set({
                      "Book_Collection_ID":docid,
                      "Author":Author,
                      "adminapproval":0,//by default false
                      "tags":[""],
                      "Availability":true,
                      "BookName":BookName,
                      "Condition":"Used",
                      "Condition Description":condition,
                      "Dislikes":0,
                      "Homepage_category":"",
                      "ISBN":_scanBarcode.toString(),
                      "ImageUrl":value.toString(),
                      "Likes":0,
                      "Long Description":bkdesc,
                      "MRP":MRP,
                      "OwnerRatings":"5",
                      "OwnerUID":useruid,
                      "LeaseDuration":leaseduration,
                      "Quantity":1,
                      "QuotedDeposit":quotedprice,
                      'SellerFullName':Seller_fullname.trim(),
                      "seller_address":pickup_address,
                      'seller_UPI':seller_UPI,
                      "seller_phoneNumber":seller_phone,
                      "SearchingIndex":indexList,
                      "category":"Unknown",
                    }).then((value) {
                      pd.update(value: 99);
                    });
                  });
                }).then((value) {
                  pd.close();
                  Navigator.pushNamed(context,Homepage.id);
                  _onBasicSuccessAlert(context, "Book has been successfully added for admin approval");
                });
              }catch(e){
                pd.close();
                _sweetSheet.show(
                  context: context,
                  title: Text("Warning"),
                  description: Text(
                      'Unexpected Error :(\n${e.message} '),
                  color: SweetSheetColor.WARNING,
                  icon: Icons.delete_forever,
                  positive: SweetSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'OK',
                    color: Colors.white,
                  ),
                );
              }

            }
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
                              child: Flexible(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: StrutStyle(fontSize: 18.0),
                                  text:TextSpan(
                                    text: "MRP",
                                    style: TextStyle(color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  ) ,
                                ),
                              ),
                            ),
                            Container(
                              width: width/4.3,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  MRP =double.parse(value);
                                },
                                autocorrect: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[290],
                                  hintText: "MRP",
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
                              child: Container(
                                width: width/3.4,
                                child: Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 18.0),
                                    text:TextSpan(
                                      text: "Quoted Deposit",
                                      style: TextStyle(color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    ) ,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width/3.3,
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
                                  hintText: ">30% & <60% of MRP",
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
                              padding: const EdgeInsets.symmetric(vertical:8.0),
                              child: Container(
                                width: width/4.5,
                                child: AutoSizeText(
                                  'Rent Duration\n(months)',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "LeelawUI",
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  minFontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:5.0),
                              child: Container(
                                width:60,
                                child: DropDown(
                                  items: [1, 2, 3, 4],
                                  hint: Text("Max.",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),),
                                  onChanged: (value){
                                    print(value);
                                    leaseduration=value;
                                  },
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("*Quoted Deposit is the security deposit which can be within 30-60 percent of MRP value.",
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${rentprice}% of Quoted Deposit will be sent to owner as Rent for the book.",
                    style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${commission_fee}% of rental amount would be deducted as convenience fee.",
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
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
                    child: Text("Pickup Address",
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
                        pickup_address =value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[290],
                        hintText: "Enter your Pickup Address..",
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
                    child: DropdownButton<String>(
                      focusColor:Colors.white,
                      value: cityName,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor:Colors.black,
                      items: <String>[
                        'Select Your City',
                        'Ahmedabad',
                        'Others',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style:TextStyle(color:Colors.black),),
                        );
                      }).toList(),
                      hint:Text(
                        "Please select your city",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          cityName = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("UPI ID",
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
                        seller_UPI =value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[290],
                        hintText: "Enter UPI ID..",
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
                    child: Text("Contact Number",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LeelawUI",
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value){
                        seller_phone =value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[290],
                        hintText: "Enter your Phone Number.",
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
                      print("camera");
                      List<Media> res = await ImagesPicker.openCamera(
                       maxSize: 1,
                        quality: 0.0001,
                        cropOpt: CropOption(
                          aspectRatio: CropAspectRatio.custom,
                          cropType: CropType.rect,
                        ),
                        pickType: PickType.image,
                      );
                      if(res!=null){
                        final dir = await path_provider.getTemporaryDirectory();
                        final targetPath = dir.absolute.path + "/temp.jpg";
                        testCompressAndGetFile(File(res[0].path),targetPath).then((value) {
                          _ImageFile=value;
                        });
                      }else{
                        print("not wrking or null return");
                      }
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
        _scanBarcode="";
      }
      else{
        _controller = new TextEditingController(text: barcodeScanRes);
        _scanBarcode = barcodeScanRes;
      }

    });
  }


  bool check(String city, String bookName, String condition, double mrp, double quotedprice, File imageFile,int leaseduration,String pickup_address, String seller_upi,String sellercontact, String seller_fullname) {

   if(city.isEmpty||city==null||city!="Ahmedabad"){
     _onBasicWaitingAlertPressed(context,"Sorry we are currently operating in Ahmedabad only\nStay tuned :)");
     return false;
   }
   if(bookName.trim()==""||bookName.trim().isEmpty||bookName.trim().length==0){
      _onBasicWaitingAlertPressed(context,"BookName can't be Empty");
      return false;
    }
    if(condition.trim()==""||condition.trim().isEmpty||condition.trim().length==0){
      _onBasicWaitingAlertPressed(context,"Condition field can't be Empty");
      return false;
    }
    if(mrp==0||mrp.isNaN){
      _onBasicWaitingAlertPressed(context,"Recheck MRP Field");
      return false;
    }
    if(quotedprice>(60/100)*mrp || quotedprice<(30/100)*mrp){
      _onBasicWaitingAlertPressed(context,"Quoted Price should be >=30% and <=60% of MRP");
      return false;
    }
    if(imageFile==null){
      _onBasicWaitingAlertPressed(context,"Please Upload Front cover of Book");
      return false;
    }
    if(leaseduration==-1||leaseduration==null){
      _onBasicWaitingAlertPressed(context,"Please enter Max. period for Lenting");
      return false;
    }
    if(pickup_address==null||pickup_address.trim()==0||pickup_address.trim()==""){
      _onBasicWaitingAlertPressed(context,"Please check pickup address");
      return false;
    }
    if(seller_upi==null||seller_upi.trim().length==0||seller_upi.trim()==""){
      _onBasicWaitingAlertPressed(context,"UPI ID is mandatory");
      return false;
    }
    if(sellercontact==null||sellercontact.trim().length==0||sellercontact.trim()==""){
      _onBasicWaitingAlertPressed(context,"Please provide your contact number");
      return false;
    }
    if(seller_fullname.isEmpty||seller_fullname.trim().length==0||seller_fullname==null)
      {
        _onBasicWaitingAlertPressed(context, "Some unknown error has occured :(");
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
  void getSellerDetails(String uid) {
    _firestore.collection("Users").doc(uid.trim()).get().then((value) {
          setState(() {
            Seller_fullname=value.get("FullName");
          });
    });
  }
  void getQuotedParameters() {
    _firestore.collection("Admin").doc("Quoted_Parameters").get().then((value) {
      setState(() {
        rentprice=double.parse(value.get("Quoted_Rent_Percent").toString());
        commission_fee=double.parse(value.get("SellerShare_Cut_Percent").toString());
      });
    });
  }
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 10,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

}


