import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'Book_info.dart';
import '../Models/Book_info_model.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
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
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.grey),
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
                                          child: Image.asset("UIAssets/Homepage/book_cover_dummy.jpg",
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

    );
  }

  void Featured_items_get() async{
    try{
      await _firestore.collection("Homepage_Books").get().then((value){
        for(var i in value.docs){
          print(i.get("BookName"));
          String bkname=i.get("BookName");
          String author=i.get("Author");
          String ImageUrl=i.get("ImageUrl");
          String coll_type=i.get("Collection_type");
          String original_loc=i.get("Book_Collection_identity");
          featured.add(homepage_items_featured(author, bkname, coll_type, ImageUrl, original_loc));
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
