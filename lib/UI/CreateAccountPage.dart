import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';

class CreateAccountPage extends StatefulWidget {
  static String id='CreateAccountPage_Screen';
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 10),
                    child: Text('E Mail ID',
                      style: TextStyle(
                          fontSize: 16
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:48.0),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
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
                    padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 10),
                    child: Text('Username',
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:48.0),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
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
                    padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 10),
                    child: Text('Password',
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:48.0),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
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
                    padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 10),
                    child: Text('Confirm Password',
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:48.0),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
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
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
                        child: Container(
                          width: 110,
                          height: 25,
                          child: Center(
                            child: FittedBox(
                              child: Text('Done',style: TextStyle(
                                  fontFamily: 'LeelawUI',
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                        ),
                      ),
                      color: Color(0xFFFFCC00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      onPressed: () {  print("dd");
                      },

                    ),
                  ),
                ],
              ),
            )
          ],

        ),
      ),
    );
  }
}
