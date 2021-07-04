import 'dart:io';

import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:images_picker/images_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final _firestore=FirebaseFirestore.instance;
FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
class AddNewBook extends StatefulWidget {
  const AddNewBook({Key key}) : super(key: key);

  @override
  _AddNewBookState createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  String BookName="",Author="",condition,bkdesc="",pickup_address="",seller_UPI="",seller_phone="",Seller_fullname="";
  double MRP=0;
  double quotedprice=0;
  int leaseduration=1;
  double rentprice=0;
  double commission_fee=10;//By default
  // list of string options
  List<String> options = [];
  List<String> tags = [];
  int quality=100;
  File _ImageFile;

  String bookCoverPath;
  String isbnBarcode;
  TextEditingController isbnController;
  String age;
  Map<String, String> upis = {
    "Personal ID": "personal@okaxis",
    "Company ID": "company@oksbi",
    "Secondary ID": "secondary@okiobrtbvtyrgytr5vbtybtyhbhty"
  };
  Map<String, String> addresses = {
    "Home Adress": "address..",
    "Company Address": "address.."
  };
  String selectedAddress;
  String selectedUpiId;

  @override
  void initState() {
    super.initState();
    isbnController = new TextEditingController();
    getSellerDetails(FirebaseAuth.instance.currentUser.uid);
    getQuotedParameters();
  }

  @override
  void dispose() {
    isbnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    if (isbnBarcode != null && isbnBarcode != "" && isbnBarcode != "-1") {
      isbnController.text = isbnBarcode;
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Add Books",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Avenir95Black",
            ),
          ),
          backgroundColor: Color(0xFFFFBD06),
          iconTheme: IconThemeData(color: Colors.black)),
      body: SafeArea(
        child: DirectSelectContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                      secondary: Color(0xFFFFBD06),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Book Details",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormLabel("Book Name"),
                                  TextFormField(
                                    onChanged: (value){
                                      BookName=value;
                                    },
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Color(0xffE9E9E9),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      hintText: "Book name here",
                                    ),

                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormLabel("Author Name"),
                                  TextFormField(
                                    onChanged: (value){
                                      Author=value;
                                    },
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Color(0xffE9E9E9),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      hintText: "Author name here",
                                    ),

                                  ),
                                ],
                              ),
                            ),
                            FormLabel("Condition"),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffE9E9E9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DirectSelectList<String>(
                                      defaultItemIndex: ["used", "new"].indexOf(
                                        condition != null ? condition : "used",
                                      ),
                                      values: ["used", "new"],
                                      itemBuilder: (String value) =>
                                          DirectSelectItem(
                                            value: value,
                                            itemBuilder: (context, value) => Text(
                                              "${value.substring(0, 1).toUpperCase()}${value.substring(1)}",
                                            ),
                                          ),
                                      onItemSelectedListener:
                                          (value, _index, _) {
                                        condition = value;
                                      },
                                      onUserTappedListener: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Drag up or down to choose options",
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Icon(Icons.unfold_more)
                                ],
                              ),
                            ),
                            FormLabel("Genre Tags"),
                            MultiSelectBottomSheetField<String>(
                              items: [
                                MultiSelectItem("used", "Used"),
                                MultiSelectItem("new", "New")
                              ],
                              onConfirm: (List<String> values) {},
                              listType: MultiSelectListType.CHIP,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffE9E9E9),
                              ),
                              title: Text("Genre"),
                              buttonText: Text(
                                "Select Genre",
                              ),
                              buttonIcon: Icon(
                                Icons.arrow_downward,
                                color: Colors.grey[600],
                              ),
                              chipDisplay: MultiSelectChipDisplay(
                                chipColor: Theme.of(context).primaryColor,
                                textStyle: TextStyle(color: Colors.black),
                                items: [],
                              ),
                            ),
                            FormLabel("Upload Book Cover"),
                            bookCoverPath == null
                                ? Container(
                              height: 200,
                              child: Material(
                                color: Color(0xffE9E9E9),
                                child: InkWell(
                                  onTap: () async{
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
                                        setState(() {
                                          bookCoverPath=_ImageFile.path;
                                        });
                                      });
                                    }else{
                                      print("not wrking or null return");
                                    }
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt),
                                        Text(
                                            "Take a snapshot of your book")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : InkWell(
                                  onTap: () async{

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
                                          setState(() {
                                            bookCoverPath=_ImageFile.path;
                                          });
                                        });
                                      }else{
                                        print("not wrking or null return");
                                      }

                                  },
                                  child: Container(
                                    height: 400,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.file(
                              new File(bookCoverPath),
                            ),
                                  ),
                                ),
                            FormLabel('ISBN'),
                            TextFormField(
                              controller: isbnController,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Color(0xffE9E9E9),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                hintText: 'Scan Barcode code or type manually',
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    Icons.camera_alt,
                                  ),
                                  onTap: () async {
                                    String barcodeScanRes =
                                    await FlutterBarcodeScanner.scanBarcode(
                                      "#ffbd00",
                                      "Cancel",
                                      true,
                                      ScanMode.BARCODE,
                                    );
                                    if (barcodeScanRes != "-1") {
                                      setState(() {
                                        isbnBarcode = barcodeScanRes;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child:
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormLabel("MRP"),
                                          TextFormField(
                                            onChanged: (value){
                                              MRP=double.parse(value);
                                            },
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              fillColor: Color(0xffE9E9E9),
                                              contentPadding:
                                              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              hintText: "MRP price",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child:
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormLabel("Quoted Deposit"),
                                          TextFormField(
                                            onChanged: (value){
                                              quotedprice=double.parse(value);
                                            },
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              fillColor: Color(0xffE9E9E9),
                                              contentPadding:
                                              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              hintText: ">30%",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            FormLabel("Rent Duration (Months)"),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffE9E9E9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DirectSelectList<int>(
                                      defaultItemIndex:
                                      [1, 2, 3, 4].indexOf(
                                        age != null ? int.parse(age) : 1,
                                      ),
                                      values: [1, 2, 3, 4],
                                      itemBuilder: (int value) =>
                                          DirectSelectItem(
                                            value: value,
                                            itemBuilder: (context, value) => Text(
                                              value != -1
                                                  ? value.toString()
                                                  : "More",
                                            ),
                                          ),
                                      onItemSelectedListener:
                                          (value, _index, context) {
                                        age = value.toString();
                                        leaseduration=int.parse(age);
                                        print(int.parse(age));
                                      },
                                      onUserTappedListener: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Drag up or down to choose options"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Icon(Icons.unfold_more)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Location & Payment",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            selectedAddress == null
                                ? Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColor,
                                            width: 2),
                                        borderRadius:
                                        BorderRadius.circular(40)),
                                    child: IconButton(
                                      onPressed: () async {
                                        await updateAddress();
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Theme.of(context)
                                            .primaryColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Add delivery Address",
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ): Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                    BorderRadius.circular(40),
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(selectedAddress),
                                    subtitle: Text(
                                      addresses[selectedAddress],
                                      style: TextStyle(
                                        //overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    await updateAddress();
                                  },
                                  child: Text("Edit"),
                                )
                              ],
                            ),
                            FormLabel("UPI Id"),
                            selectedUpiId == null
                                ? Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColor,
                                          width: 2),
                                      borderRadius:
                                      BorderRadius.circular(40)),
                                  child: IconButton(
                                    onPressed: () async {
                                      await updateUpi();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color:
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Add UPI Id",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                    BorderRadius.circular(40),
                                  ),
                                  child: Icon(
                                    Icons.credit_card,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(selectedUpiId),
                                    subtitle: Text(
                                      upis[selectedUpiId],
                                      style: TextStyle(
                                        //overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    await updateUpi();
                                  },
                                  child: Text("Edit"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 16,
                      offset: Offset(0, 10),
                      color: Colors.black),
                ], color: Colors.white),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.maxFinite,
                child: Center(
                  child: ElevatedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFFFFBD06),
                        ),
                        shadowColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void getSellerDetails(String uid) {
    _firestore.collection("Users").doc(uid.trim()).get().then((value) {
      setState(() {
        addresses=value.get("Addresses").cast<String, String>();
        Seller_fullname=value.get("FullName");
      });
    });
  }
  void getQuotedParameters() {
    _firestore.collection("Admin").doc("Quoted_Parameters").get().then((value) {
      setState(() {
        rentprice=double.parse(value.get("Quoted_Rent_Percent").toString());
        commission_fee=double.parse(value.get("SellerShare_Cut_Percent").toString());
        quality=double.parse(value.get("Image_Quality").toString()).toInt();
        for(var i in value.get("Genretags")){
          options.add(i.toString());
        }
      });
    });
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 100,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  Future updateUpi() async {
    String result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Choose an upi id"),
          children: upis.keys
              .map(
                (key) => InkWell(
              child: ListTile(
                title: Text(key),
                subtitle: Text(upis[key]),
              ),
              onTap: () {
                Navigator.pop(
                  context,
                  key,
                );
              },
            ),
          )
              .toList(),
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedUpiId = result;
      });
    }
  }

  Future updateAddress() async {
    String result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Choose an address"),
          children: addresses.keys
              .map(
                (key) => InkWell(
              child: ListTile(
                title: Text(key),
                subtitle: Text(addresses[key]),
              ),
              onTap: () {
                Navigator.pop(
                  context,
                  key,
                );
              },
            ),
          )
              .toList(),
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedAddress = result;
      });
    }
  }
}

class FormElement extends StatelessWidget {
  final String label;
  final String placeholder;
  final String Function(String value) validator;

  const FormElement({
    Key key,
    @required this.label,
    @required this.placeholder,
    @required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormLabel(this.label),
          TextFormField(
            style: TextStyle(
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xffE9E9E9),
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              hintText: this.placeholder,
            ),
            validator: (value) => this.validator(value),
          ),
        ],
      ),
    );
  }
}

class FormLabel extends StatelessWidget {
  final String label;
  const FormLabel(this.label, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Text(
        this.label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
