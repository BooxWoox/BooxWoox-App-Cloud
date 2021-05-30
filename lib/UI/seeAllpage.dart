import 'package:bookollab/UI/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'dart:io';
import 'package:images_picker/images_picker.dart';
import 'maindisplaypage.dart';

import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:bookollab/UI/Homepage.dart';
import '../Models/maindisp_book_info_model.dart';
import '../Models/homepage_items_featured.dart';
import 'package:getwidget/getwidget.dart';
import 'package:bookollab/UI/Book_info.dart';


final _firestore=FirebaseFirestore.instance;
FirebaseStorage _firebaseStorage=FirebaseStorage.instance;

class seeAllpage extends StatefulWidget {
  static String id = 'seeAllpage_Screen';
  @override
  _seeAllpageState createState() => _seeAllpageState();
}

class _seeAllpageState extends State<seeAllpage> {
  double _quotedrentpercent = 0;
  bool getAdminparams=false;
  List TotalBookName = [];
  List TotalBookCollID=[];
  @override
  void initState() {
    // TODO: implement initState
    admin_params_get().then((value) {
      setState(() {
        getAdminparams=value;
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: (){
          Navigator.pushReplacementNamed(context, Homepage.id);
        },),
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
        title: Text("All Books"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("Book_Collection")
              .where("adminapproval",isEqualTo:1)
              .snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData && !getAdminparams)
            {
              return Center(
                child: Text('Loading!'),
              );
            }
            for(int i=0;i<snapshot.data.size;i++){
              TotalBookName.add(snapshot.data.docs[i].get("BookName"));
              TotalBookCollID.add(snapshot.data.docs[i].get("Book_Collection_ID"));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GFSearchBar(
                    searchList: TotalBookName,
                    searchQueryBuilder: (query, list) {
                      return list
                          .where((item) =>
                          item.toLowerCase().contains(query.toLowerCase()))
                          .toList();
                    },
                    overlaySearchListItemBuilder: (item) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                    onItemSelected: (item) {

                      int index=TotalBookName.indexOf(item);
                      _firestore.collection("Book_Collection").doc(TotalBookCollID[index]).get().then((value) {
                        String bkname = value.get("BookName");
                        String author = value.get("Author");
                        String ImageUrl = value.get("ImageUrl");
                        String coll_type = value.get("Homepage_category");
                        String original_loc = value.id.toString().trim();
                        String owneruid = value.get("OwnerUID");
                        String selleraddress = value.get("seller_address");
                        String sellerphn = value.get("seller_phoneNumber");
                        bool availability = value.get("Availability");
                        String sellerFullname=value.get("SellerFullName");
                        Navigator.pushNamed(context, Book_info.id,
                            arguments: maindisp_book_info_model(
                                homepage_items_featured(
                                    author,
                                    bkname,
                                    coll_type,
                                    ImageUrl,
                                    original_loc,
                                    owneruid,
                                    selleraddress,
                                    sellerphn,
                                    availability,
                                    sellerFullname)));
                      });
                    },
                  ),
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          //goto book info
                          String bkname = snapshot.data.docs[index].get("BookName");
                          String author = snapshot.data.docs[index].get("Author");
                          String ImageUrl = snapshot.data.docs[index].get("ImageUrl");
                          String coll_type = snapshot.data.docs[index].get("Homepage_category");
                          String original_loc = snapshot.data.docs[index].id.toString().trim();
                          String owneruid = snapshot.data.docs[index].get("OwnerUID");
                          String selleraddress = snapshot.data.docs[index].get("seller_address");
                          String sellerphn = snapshot.data.docs[index].get("seller_phoneNumber");
                          bool availability = snapshot.data.docs[index].get("Availability");
                          String sellerFullname=snapshot.data.docs[index].get("SellerFullName");

                          Navigator.pushNamed(context, Book_info.id,
                              arguments: maindisp_book_info_model(
                                  homepage_items_featured(
                                      author,
                                      bkname,
                                      coll_type,
                                      ImageUrl,
                                      original_loc,
                                      owneruid,
                                      selleraddress,
                                      sellerphn,
                                      availability,
                                      sellerFullname)));
                        },
                        child: Container(
                          height: 200,
                          child: Row(
                            children: [
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                child: Container(
                                  height: 160,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.data.docs[index].get("ImageUrl"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 18.0),
                                child: VerticalDivider(
                                  width: 10,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data.docs[index].get("BookName")}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Author/Publication: ${snapshot.data.docs[index].get("Author")}"),
                                    snapshot.data.docs[index].get("Availability")?
                                    InputChip(
                                      avatar: Icon(Icons.check),
                                      label: Text(
                                        'Available',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      selectedColor: Colors.green,
                                      selected: true,
                                    )
                                        : InputChip(
                                      avatar: Icon(Icons.clear),
                                      label: Text(
                                        'Out of stock',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      selectedColor: Colors.red,
                                      selected: true,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\u{20B9}${_quotedrentpercent * snapshot.data.docs[index].get("QuotedDeposit") / 100} ',
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '\u{20B9}${snapshot.data.docs[index].get("MRP")}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              decoration: TextDecoration.lineThrough),
                                        ),
                                        Text(
                                          ' /month*',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
  Future<bool> admin_params_get() async {
    try {
      await _firestore
          .collection("Admin")
          .doc("Quoted_Parameters")
          .get()
          .then((value) {
        _quotedrentpercent =
            double.parse(value["Quoted_Rent_Percent"].toString());
        // _deliverycharges = double.parse(value["Delivery_Charges"].toString());
        // _commissionpercent =
        //     double.parse(value["commission_percent"].toString());
        // _bankcharges = double.parse(value["Bank_charges"].toString());
        // _sellershare_cut_percent =
        //     double.parse(value["SellerShare_Cut_Percent"].toString());
        // print(_deliverycharges);
        return true;
      });
    } catch (e) {
      print("yohooooooooooooooooo2" + e);
    }
    return false;
  }
}
