import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'Book_info.dart';
import 'AddBookPage.dart';
import '../Models/Book_info_model.dart';
import 'package:unicorndial/unicorndial.dart';

final _firestore=FirebaseFirestore.instance;

class maindisplaypage extends StatefulWidget {
  static String id='maindisplaypage_Screen';
  @override
  _maindisplaypageState createState() => _maindisplaypageState();
}

class _maindisplaypageState extends State<maindisplaypage> {
  List<String> Homepage_Cat=[];
  List<homepage_items_featured> featured=[];
  @override
  void initState() {
    //initiaise to get list of homepage categories from database
    setState(() {
      home_cat_get();
      Featured_items_get();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var floatingButtons = List<UnicornButton>();
    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Add Books(Rent)",
        currentButton: FloatingActionButton(
          onPressed: () {
            print('add books rent');
            Navigator.pushNamed(context,AddBookPage.id);
          },
          heroTag: "addrentbooks",
          backgroundColor: Colors.deepOrange,
          mini: true,
          child: Icon(Icons.note_add),
        ),
      ),
    );
    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Add Books(Sell)",
        currentButton: FloatingActionButton(
          onPressed: () {
            print('addbooksell');
            Navigator.pushNamed(context,AddBookPage.id);
          },
          heroTag: "addbookssell",
          backgroundColor: Colors.orange,
          mini: true,
          child: Icon(Icons.note_add),
        ),
      ),
    );
    if(Homepage_Cat.isEmpty){
      return Scaffold(
        body: Center(
          child: Text("Fetching Data!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
        ),
      );
    }else
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: UnicornDialer(
          backgroundColor: Colors.transparent,
          parentButtonBackground: Colors.amber,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.playlist_add_sharp),
          childButtons: floatingButtons),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: TextField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search,color: Color(0xff7D7D7D),),
                    fillColor: Color(0xffEBEBEB),
                    hintText: "Search",
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical:4.0,horizontal: 25),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color:  Color(0xff707070)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Color(0xff707070)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:Homepage_Cat.length,
                itemBuilder: (context,index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 18),
                        child: Text(Homepage_Cat[index],
                        style: TextStyle(
                          fontFamily: "LeelawUI",
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      Container(
                        height:220,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:featured.length,
                            itemBuilder: (context,itemIndex){
                              return InkWell(
                                onTap: (){
                                  //goto book info page
                                  Navigator.pushNamed(context,Book_info.id,arguments: maindisp_book_info_model(featured[itemIndex]));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 3,
                                    color:Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 140,
                                            width:150,
                                            child: Image.network(featured[itemIndex].ImageURl,
                                            fit: BoxFit.contain,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: SizedBox(
                                              width:150,
                                              child: Center(child: Text(featured[itemIndex].BookName,
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontFamily: "LeelawUI",

                                              ),))),
                                        )
                                      ],
                                    )
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                }
            ),
          ),
        ],

      ),
    );

  }



  void Featured_items_get() async{
    try{
      await _firestore.collection("Book_Collection").get().then((value){
        for(var i in value.docs){
          print(i.get("BookName"));
          String bkname=i.get("BookName");
          String author=i.get("Author");
          String ImageUrl=i.get("ImageUrl");
          String coll_type=i.get("Homepage_category");
          String original_loc=i.id.toString().trim();
          String owneruid=i.get("OwnerUID");
          String selleraddress=i.get("seller_address");
          String sellerphn=i.get("seller_phoneNumber");
          bool availability=i.get("Availability");
          featured.add(homepage_items_featured(author, bkname, coll_type, ImageUrl,original_loc,owneruid,selleraddress,sellerphn,availability));

        }
        setState(() {
          print(featured);
        });

      });
    }catch(e){
      print(e.message);
    }
  }
  void home_cat_get() async{
    try{
      await _firestore.collection("Homepage_item_list").get().then((value){
        for(var i in value.docs){
          Homepage_Cat.add(i.get("Name"));
        }
        setState(() {

        });
      });
    }catch(e){
      print("yohooooooooooooooooo"+e.message);
    }

    print(Homepage_Cat);
  }
}
