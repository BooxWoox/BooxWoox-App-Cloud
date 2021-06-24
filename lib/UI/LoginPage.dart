import 'package:bookollab/UI/CreateAccountPage.dart';
import 'package:bookollab/UI/Homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'Utils/rounded_button.dart';
final _firestore=FirebaseFirestore.instance;
class LoginPage extends StatefulWidget {
  static String id='Login_Screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SweetSheet _sweetSheet = SweetSheet();
  String email_typed="";
  final resetemail = TextEditingController();
  String pass_typed="";
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);
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
              padding: const EdgeInsets.all(26.0),
              child: CircleAvatar(
                child: CircleAvatar(
                    child: Image.asset('UIAssets/LoginScreen/DummyProfile.png'),
                  radius: 55,
                  backgroundColor: Colors.white,
                ),
                backgroundColor: Colors.black12,
                radius: 66,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 10),
                  child: Text('Email',
                  style: TextStyle(
                    fontSize: 16
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:48.0),
                  child: TextField(
                    onChanged: (value){
                      email_typed=value;
                    },
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
                    onChanged: (value){
                      pass_typed=value;
                    },
                    obscureText: true,
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:48.0,vertical: 20),
                      child: InkWell(
                        onTap: (){

                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {

                              return SingleChildScrollView(
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding:  EdgeInsets.only(
                                              bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: TextFormField(
                                              controller: resetemail,
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 15, bottom: 11, top: 11, right: 15),
                                                labelText: 'Enter your registered Email Id',
                                                prefixIcon: Icon(Icons.email),
                                                labelStyle: TextStyle(
                                                  color: Color(0xFFB2BCC8),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:18.0,right: 18,top: 0,bottom: 10),
                                          child: RoundedButton(
                                            title: "Send Reset Link",
                                            colour: Color(0xFFFFCC00),
                                            onPressed: (){
                                              setState((){
                                                if(resetemail.text.isEmpty){
                                                  _sweetSheet.show(
                                                    context: context,
                                                    title: Text("Forgot Password"),
                                                    description: Text(
                                                        'All fields are mandatory'),
                                                    color: SweetSheetColor.WARNING,
                                                    icon: Icons.error,
                                                    positive: SweetSheetAction(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      title: 'OK',
                                                      color: Colors.white,
                                                    ),
                                                  );

                                                }
                                                else{
                                                  //backend starts
                                                  firebasepasswordreset(resetemail.text,_auth);

                                                }


                                              });

                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                        },
                        child: Text(
                          "Forgot Password?"
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: RaisedButton(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
                      child: Container(
                        width: 110,
                        height: 25,
                        child: Center(
                          child: FittedBox(
                            child: Text('Login',style: TextStyle(
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
                    onPressed: () async{

                      if(check(email_typed, pass_typed)){
                        //login server starts calling API
                        pd.show(max: 100, msg: 'Signing In...');
                        try{
                          var user=await _auth.signInWithEmailAndPassword(email: email_typed.trim().toLowerCase(), password: pass_typed).then((value){
                            print("Successfully Logged in as ${value.user.uid}");
                            pd.close();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.pushReplacementNamed(context, Homepage.id);
                          });
                          ;

                        }catch(e){
                          pd.close();
                          _sweetSheet.show(
                            context: context,
                            title: Text("Unable to Sign In"),
                            description: Text(
                                '${e.message}'),
                            color: SweetSheetColor.WARNING,
                            icon: Icons.error,
                            positive: SweetSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: 'OK',
                              color: Colors.white,
                            ),
                          );
                          print("Error in log in"+e.toString());
                        }
                      }else{
                        pd.close();
                      }

                    },

                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: RaisedButton(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
                      child: Container(
                        width: 110,
                        height: 25,
                        child: Center(
                          child: FittedBox(
                            child: Text('Create Account',style: TextStyle(
                                fontFamily: 'LeelawUI',
                                fontSize: 16,
                                color: Color(0xFFFFCC00),
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    onPressed: () async{
                          //Goto create account page
                      Navigator.pushNamed(context, CreateAccountPage.id);
                    },

                  ),
                ),

              ],
            )
          ],

        ),
      ),
    );

  }
  bool check(String useremail,String userpass){
    if(useremail==null||userpass==null||useremail.isEmpty||userpass.isEmpty||useremail.trim().length==0||userpass.trim().length==0||userpass==""||useremail==""){

      _sweetSheet.show(
        context: context,
        title: Text("Unable to Sign In"),
        description: Text(
            'All fields are mandatory'),
        color: SweetSheetColor.WARNING,
        icon: Icons.error,
        positive: SweetSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          title: 'OK',
          color: Colors.white,
        ),
      );
      return false;
    }
    return true;
  }
  //firebae password reset
  Future<String> firebasepasswordreset(@required String email,FirebaseAuth _auth) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      print("password reset link has been sent to: "+email);
      _sweetSheet.show(
        context: context,
        title: Text("Forgot Password"),
        description: Text(
            'Password reset link has been sent to the registered Email Id.'),
        color: SweetSheetColor.SUCCESS,
        icon: Icons.send_to_mobile,
        positive: SweetSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          title: 'OK',
          color: Colors.white,
        ),
      );
      return "ResetLinkSent";
    }
    catch(e)
    {
      _sweetSheet.show(
        context: context,
        title: Text("Error"),
        description: Text(
            e.message),
        color: SweetSheetColor.WARNING,
        icon: Icons.error,
        positive: SweetSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          title: 'OK',
          color: Colors.white,
        ),
      );
      return e.message;

    }


  }
}
