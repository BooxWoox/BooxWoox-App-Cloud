import 'dart:io';

import 'package:bookollab/State/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';
import 'package:logger/logger.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddNewBook extends StatefulWidget {
  static String id = "add_new_book";
  const AddNewBook({Key key}) : super(key: key);

  @override
  _AddNewBookState createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  String bookName = "",
      author = "",
      condition,
      bkdesc = "",
      pickupAddress = "",
      sellerUPI = "",
      sellerPhone = "",
      sellerFullname = "";
  double mrp = 0;
  double quotedprice = 0;
  int leaseduration = 1;
  double rentprice = 0;
  double commissionFee = 10; //By default
  // list of string options
  List<String> options = [];
  List<String> tags = [];
  int quality = 100;
  File _imageFile;

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
    // getQuotedParameters();
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
                                  onChanged: (value) {
                                    bookName = value;
                                  },
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: (val) {
                                    if (val == null || val == '') {
                                      return 'Please enter a valid book name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Color(0xffE9E9E9),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
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
                                  onChanged: (value) {
                                    author = value;
                                  },
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: (val) {
                                    if (val == null || val == '') {
                                      return 'Please enter a valid author name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Color(0xffE9E9E9),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    hintText: "Author name here",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FormLabel("Condition"),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Color(0xffE9E9E9),
                                filled: true,
                              ),
                              items: ["Used", "New"]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e.toLowerCase(),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  condition = val;
                                });
                              },
                              validator: (val) {
                                if (val == null || val == '') {
                                  return 'Please select a book condition';
                                }
                                return null;
                              },
                              isExpanded: true,
                              hint: Text('Condition'),
                              value: condition,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          FormLabel("Genre Tags"),
                          Consumer(
                            builder: (context, watch, child) {
                              final genres = watch(allGenres);
                              return genres.when(
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (err, stack) => Text('Error: $err'),
                                data: (genres) =>
                                    MultiSelectBottomSheetField<String>(
                                  items: genres
                                      .map((e) => MultiSelectItem(e, e))
                                      .toList(),
                                  onConfirm: (List<String> values) {
                                    setState(() {
                                      tags = values;
                                    });
                                  },
                                  initialValue: tags,
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
                                    chipColor: Color(0xFFFFBD06),
                                    textStyle: TextStyle(color: Colors.black),
                                    items: [],
                                  ),
                                  selectedColor: Color(0xFFFFBD06),
                                  selectedItemsTextStyle:
                                      TextStyle(color: Colors.black),
                                  validator: (val) {
                                    Logger().i(val);
                                    if (val == null || val == []) {
                                      return 'Please select atleast one genre';
                                    }
                                    return null;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  
                                ),
                              );
                            },
                          ),
                          FormLabel("Upload Book Cover"),
                          bookCoverPath == null
                              ? Container(
                                  height: 200,
                                  child: Material(
                                    color: Color(0xffE9E9E9),
                                    child: InkWell(
                                      onTap: () async {
                                        List<Media> res =
                                            await ImagesPicker.openCamera(
                                          maxSize: 1,
                                          quality: 0.0001,
                                          cropOpt: CropOption(
                                            aspectRatio: CropAspectRatio.custom,
                                            cropType: CropType.rect,
                                          ),
                                          pickType: PickType.image,
                                        );
                                        if (res != null) {
                                          final dir = await path_provider
                                              .getTemporaryDirectory();
                                          final targetPath =
                                              dir.absolute.path + "/temp.jpg";
                                          testCompressAndGetFile(
                                                  File(res[0].path), targetPath)
                                              .then((value) {
                                            _imageFile = value;
                                            setState(() {
                                              bookCoverPath = _imageFile.path;
                                            });
                                          });
                                        } else {
                                          print("not wrking or null return");
                                        }
                                      },
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_alt),
                                            Text("Take a snapshot of your book")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    List<Media> res =
                                        await ImagesPicker.openCamera(
                                      maxSize: 1,
                                      quality: 0.0001,
                                      cropOpt: CropOption(
                                        aspectRatio: CropAspectRatio.custom,
                                        cropType: CropType.rect,
                                      ),
                                      pickType: PickType.image,
                                    );
                                    if (res != null) {
                                      final dir = await path_provider
                                          .getTemporaryDirectory();
                                      final targetPath =
                                          dir.absolute.path + "/temp.jpg";
                                      testCompressAndGetFile(
                                              File(res[0].path), targetPath)
                                          .then((value) {
                                        _imageFile = value;
                                        setState(() {
                                          bookCoverPath = _imageFile.path;
                                        });
                                      });
                                    } else {
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
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FormLabel("MRP"),
                                        TextFormField(
                                          onChanged: (value) {
                                            mrp = double.parse(value);
                                          },
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Color(0xffE9E9E9),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15),
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
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FormLabel("Quoted Deposit"),
                                        TextFormField(
                                          onChanged: (value) {
                                            quotedprice = double.parse(value);
                                          },
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Color(0xffE9E9E9),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15),
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
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<int>(
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Color(0xffE9E9E9),
                                filled: true,
                              ),
                              items: [1, 2, 3, 4, -1]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: e != -1
                                          ? Text(e.toString())
                                          : Text('More'),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  leaseduration = val;
                                });
                              },
                              isExpanded: true,
                              hint: Text('Condition'),
                              value: leaseduration,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Colors.grey[600],
                              ),
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                )
                              : Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(40),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          color: Theme.of(context).primaryColor,
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
                                        borderRadius: BorderRadius.circular(40),
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
                    blurRadius: 16, offset: Offset(0, 10), color: Colors.black),
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
                  onPressed: () {
                    _formKey.currentState.validate();
                  },
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
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void getSellerDetails(String uid) {
  //   _firestore.collection("Users").doc(uid.trim()).get().then((value) {
  //     setState(() {
  //       addresses = value.get("Addresses").cast<String, String>();
  //       Seller_fullname = value.get("FullName");
  //     });
  //   });
  // }

  // void getQuotedParameters() {
  //   _firestore.collection("Admin").doc("Quoted_Parameters").get().then((value) {
  //     setState(() {
  //       rentprice = double.parse(value.get("Quoted_Rent_Percent").toString());
  //       commission_fee =
  //           double.parse(value.get("SellerShare_Cut_Percent").toString());
  //       quality = double.parse(value.get("Image_Quality").toString()).toInt();
  //       for (var i in value.get("Genretags")) {
  //         options.add(i.toString());
  //       }
  //     });
  //   });
  // }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
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
