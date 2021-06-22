import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/Transactions/AllTransactions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:random_string/random_string.dart';

FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
final _firestore=FirebaseFirestore.instance;
class Mybooks extends StatefulWidget {
  static String id = 'maindisplaypage_Screen';
  const Mybooks({Key key}) : super(key: key);
  @override
  _MybooksState createState() => _MybooksState();
}

class _MybooksState extends State<Mybooks> {
  String userUID=FirebaseAuth.instance.currentUser.uid;
  final SweetSheet _sweetSheet = SweetSheet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.book,color: Colors.white,),
            Text("My Books"),
          ],
        ),
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("Book_Collection")
            .where("OwnerUID",isEqualTo:userUID)
            .snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData)
          {
            return Center(
              child: Text('Loading!'),
            );
          }
          return snapshot.data.docs.length!=0?
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: Container(
                          height: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                ),
                                child: Container(
                                  height: 140,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                    child: Image.network(
                                      snapshot.data.docs[index].get("ImageUrl"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width/2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        strutStyle: StrutStyle(fontSize: 18.0),
                                        text:TextSpan(
                                          text: snapshot.data.docs[index].get("BookName"),
                                          style: TextStyle(color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                        ) ,
                                      ),
                                    ),
                                    Text(snapshot.data.docs[index].get("Author"),
                                      overflow: TextOverflow.ellipsis,),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text("MRP : \u{20B9}${snapshot.data.docs[index].get("MRP")}"),
                                    Text("Quoted Deposit : \u{20B9}${snapshot.data.docs[index].get("QuotedDeposit")}"),
                                    Text("Max Borrow Duration : ${snapshot.data.docs[index].get("LeaseDuration")} months"),
                                    Text("Phn No : ${snapshot.data.docs[index].get("seller_phoneNumber")}"),
                                    Text("UPI : ${snapshot.data.docs[index].get("seller_UPI")}")
                                  ],
                                ),
                              ),
                              snapshot.data.docs[index].get("adminapproval")==1?
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.assignment_turned_in,color: Colors.green,size: 38,),
                                      Text("Approved"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                      onTap: (){
                                        _sweetSheet.show(
                                          context: context,
                                          title: Text("Warning"),
                                          description: Text(
                                              'Your book item will be deleted from the store.'),
                                          color: SweetSheetColor.WARNING,
                                          icon: Icons.delete_forever,
                                          positive: SweetSheetAction(
                                            onPressed: () {
                                              _deleteitemfromdatabase(snapshot.data.docs[index].get("ImageUrl"), snapshot.data.docs[index].get("Book_Collection_ID"));
                                              Navigator.pop(context);
                                              },
                                            title: 'CONTINUE',
                                            color: Colors.white,
                                            icon: Icons.open_in_new,
                                          ),
                                          negative: SweetSheetAction(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            title: 'CANCEL',
                                          ),
                                        );
                                      },
                                          child: Icon(Icons.delete_forever,color: Colors.red,size: 38,)),
                                      Text("Delete"),
                                    ],
                                  ),
                                ],
                              ):
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.update,color: Colors.amberAccent,size: 38,),
                                      Text("Pending"),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      InkWell(
                                          onTap:(){
                                            _sweetSheet.show(
                                              context: context,
                                              title: Text("Warning"),
                                              description: Text(
                                                  'Your book item will be deleted from the store.'),
                                              color: SweetSheetColor.WARNING,
                                              icon: Icons.delete_forever,
                                              positive: SweetSheetAction(
                                                onPressed: () {
                                                 //delete item from database
                                                  _deleteitemfromdatabase(snapshot.data.docs[index].get("ImageUrl"), snapshot.data.docs[index].get("Book_Collection_ID"));
                                                  Navigator.pop(context);
                                                  },
                                                title: 'CONTINUE',
                                                color: Colors.white,
                                                icon: Icons.open_in_new,
                                              ),
                                              negative: SweetSheetAction(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                title: 'CANCEL',
                                              ),
                                            );
                                              },
                                          child: Icon(Icons.delete_forever,color: Colors.red,size: 38,)),
                                      Text("Delete"),
                                    ],
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ):
          Center(child: Text("No Books Rented",
          style: TextStyle(
          fontSize: 18,
          color: Colors.black26
          ),),);
        },
      ),
    );
  }

  _deleteitemfromdatabase (String ImageUrl,String BookCollectionId) async{
    print(ImageUrl);
    try {
      Reference ref = await FirebaseStorage.instance.refFromURL(ImageUrl);
      print(ref);
      await ref.delete().then((value) {
        _firestore.collection("Book_Collection").doc(BookCollectionId).delete().then((value){
            });
      });
    } catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    // _firebaseStorage.ref().child("BookFrontCovers/${ImageUrl}").delete().then((value) {
    //   _firestore.collection("Book_Collection").doc(BookCollectionId).delete().then((value){
    //   });
    // });
  }


}
