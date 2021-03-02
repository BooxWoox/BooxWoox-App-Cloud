import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore=FirebaseFirestore.instance;

class maindisplaypage extends StatefulWidget {
  static String id='maindisplaypage_Screen';
  @override
  _maindisplaypageState createState() => _maindisplaypageState();
}

class _maindisplaypageState extends State<maindisplaypage> {
  List<String> Homepage_Cat=[];
  @override
  void initState() {
    
    //initiaise to get list of homepage categories from database

    setState(() {
      home_cat_get();
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
    return SafeArea(
      child: Column(
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
          Text(Homepage_Cat[0]),
        ],
      ),
    );
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
      print(e.message);
    }

    print(Homepage_Cat);
  }
}
