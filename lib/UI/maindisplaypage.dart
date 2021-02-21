import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';

class maindisplaypage extends StatefulWidget {
  static String id='maindisplaypage_Screen';
  @override
  _maindisplaypageState createState() => _maindisplaypageState();
}

class _maindisplaypageState extends State<maindisplaypage> {
  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
