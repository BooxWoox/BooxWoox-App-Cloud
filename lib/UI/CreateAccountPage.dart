import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'LoginPage.dart';
import 'package:webviewx/webviewx.dart';

final _firestore=FirebaseFirestore.instance;
class CreateAccountPage extends StatefulWidget {
  static String id='CreateAccountPage_Screen';
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final SweetSheet _sweetSheet = SweetSheet();
  bool checkValueBox=false;
  bool checkValuePrivacy=false;
  String _verificationCode="";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String phoneNumber = ""; //enter your 10 digit number
  int minNumber = 1000;
  int maxNumber = 9999;

  String countryCode ="+91";

  String otp_typed="";
  String email_typed="";
  String username_typed="";
  String fullname_typed="";
  String phonenumber_typed="";
  String password_typed="";
  String confirmpassword_typed="";

  bool _initialized = false;
  bool _error = false;

  WebViewXController webviewController;

  _showSnackBar(@required String message, @required Color colors) {
    if (scaffoldKey != null) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: colors,
          content: new Text(message),
          duration: new Duration(seconds: 4),
        ),
      );
    }
  }
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(

        title: Text("Create Account"),
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
                      onChanged: (value){
                        email_typed=value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                    child: Text('Phone Number (+91)',
                      style: TextStyle(
                          fontSize: 16
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:48.0),
                    child: TextField(
                      onChanged: (value){
                        phoneNumber=value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                    child: Text('Full Name',
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:48.0),
                    child: TextField(
                      onChanged: (value){
                        fullname_typed=value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
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
                      onChanged: (value){
                        username_typed=value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
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
                      obscureText: true,
                      onChanged: (value){
                        password_typed=value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                      obscureText: true,
                      onChanged: (value){
                        confirmpassword_typed=value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: checkValueBox,
                        onChanged: (value) {
                          setState(() {
                            checkValueBox=value;
                          });

                      },
                      ),
                      Text("I accept all "),
                      GestureDetector(
                        onTap: (){

                          showDialog(
                            context: context,
                            builder: (context){
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: WebViewX(
                                          initialContent: 'https://booxwoox.netlify.app/tnc.html',
                                          initialSourceType: SourceType.URL,
                                          onWebViewCreated: (controller) => webviewController = controller,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 20,
                                          child: Icon(Icons.close_sharp,color: Colors.white,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          );

                         // launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                        },
                          child: Text("Terms & conditions",
                          style: TextStyle(
                            color: Colors.amber
                          ),))
                      
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: checkValuePrivacy,
                        onChanged: (value) {
                          setState(() {
                            checkValuePrivacy=value;
                          });

                        },
                      ),
                      Text("I accept all "),
                      GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: WebViewX(
                                              initialContent: 'https://booxwoox.netlify.app/privacypolicy.html',
                                              initialSourceType: SourceType.URL,
                                              onWebViewCreated: (controller) => webviewController = controller,
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          InkWell(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 20,
                                              child: Icon(Icons.close_sharp,color: Colors.white,),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );

                            // launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                          },
                          child: Text("Privacy Policies       ",
                            style: TextStyle(
                                color: Colors.amber
                            ),))

                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                      onPressed: () {
                        if(check_parameters(username_typed, phoneNumber, email_typed, password_typed, confirmpassword_typed,fullname_typed,checkValueBox)){
                          _firestore.collection("Users").where("Phone_Number",isEqualTo: phoneNumber).get().then((value) {
                            if(value.docs.isEmpty){
                              _firestore.collection("Users").where("Email_Id",isEqualTo: email_typed).get().then((value) {
                                if(value.docs.isEmpty){
                                  _verifyPhone(pd);
                                  //show bottomsheet with otp verification
                                  showModalBottomSheet(context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0)),
                                      ),
                                      builder: (BuildContext context){
                                        return Padding(
                                          padding: MediaQuery.of(context).viewInsets,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(18.0),
                                                child: Text(
                                                  "Please enter the OTP sent\non your phone number.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: "Avenir95Black",
                                                      fontSize: 18.0, color: Color(0xffADACAC)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:8),
                                                child: PinCodeTextField(
                                                  appContext: context,
                                                  length: 6,
                                                  onChanged: (value){
                                                    print(value);
                                                    otp_typed=value;
                                                  },
                                                  pinTheme: PinTheme(
                                                      shape:PinCodeFieldShape.circle,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom:20.0),
                                                child: RaisedButton(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
                                                    child: Container(
                                                      width: 150,
                                                      height: 25,
                                                      child: Center(
                                                        child: FittedBox(
                                                          child: Text('verify',style: TextStyle(
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
                                                    //send api call to verify otp
                                                    print("otp verify button");
                                                    print(otp_typed);
                                                    pd.show(max: 100, msg: 'Please Wait...');
                                                    AuthCredential credential = EmailAuthProvider.credential(email: email_typed, password: password_typed);
                                                    try {
                                                      await FirebaseAuth.instance
                                                          .signInWithCredential(PhoneAuthProvider.credential(
                                                          verificationId: _verificationCode, smsCode: otp_typed))
                                                          .then((value) async {
                                                        if (value.user != null) {
                                                          print("Hola");
                                                          print(value.user.uid);
                                                          setvaluesofuser_database(value.user.uid, username_typed, phoneNumber, email_typed, fullname_typed,credential,value,pd);
                                                        }
                                                      });
                                                    } catch (e) {
                                                      FocusScope.of(context).unfocus();
                                                      _sweetheartDialog(e.toString());
                                                      print("error");
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                  print("phone: $phoneNumber+countrycode:$countryCode");
                                }else{
                                  _sweetheartDialog("Email Id already linked with other account");
                                }
                              });
                            }else{
                              _sweetheartDialog("Phone Number already Exists");
                            }
                          });

                        }
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
  _verifyPhone(ProgressDialog pd) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneNumber.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          pd.show(max: 100, msg: 'Please Wait...');
          try{
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                AuthCredential credential = EmailAuthProvider.credential(email: email_typed, password: password_typed);
                setvaluesofuser_database(value.user.uid, username_typed, phoneNumber, email_typed, fullname_typed,credential,value,pd);
                print("success");
              }
            });
          }catch(e){
            pd.close();
            _sweetheartDialog(e.toString());
          }

        },
        verificationFailed: (FirebaseAuthException e) {
          _sweetheartDialog("Verification Failed+${e.message}");
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
            print("Sent +$verficationID");
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }
  setvaluesofuser_database(String uid,String username,String Phone,String email, String fullname_typed,
      AuthCredential credential, UserCredential userValue, ProgressDialog pd) async{
    try{
      userValue.user.linkWithCredential(credential).then((user) {
        _firestore.collection('Users').doc(uid).set({
          'Username': username.trim(),
          'Phone_Number':Phone.trim(),
          'Email_Id':email.trim(),
          'Profile_ImageURL':"",
          'Ratings':'5',
          'FullName':fullname_typed.trim(),
          'Add2':"2",
        }).then((value) {
          pd.close();
          print("Registration Successful");
          FirebaseAuth.instance.signOut().then((value){
            Navigator.pushReplacementNamed(context, LoginPage.id);
            _onBasicWaitingAlertPressed(context,"Yo Hoo! Successfully Created");
          });

        });
      }).then((value) {
        _firestore.collection('Users').doc(uid).set({
          'Username': username.trim(),
          'Phone_Number':Phone.trim(),
          'Email_Id':email.trim(),
          'Profile_ImageURL':"",
          'Ratings':'5',
          'FullName':fullname_typed.trim(),
          'Add2':"2",
        }).then((value) {
          pd.close();
          print("Registration Successful");
          FirebaseAuth.instance.signOut().then((value){
            Navigator.pushReplacementNamed(context, LoginPage.id);
            _onBasicWaitingAlertPressed(context,"Yo Hoo! Successfully Created");
          });
        });
      });
    }
    catch(e){
      pd.close();
      _showSnackBar(e.message,Colors.red[600]);
    }

  }
  bool check_parameters(String username,String Phone,String email,String pass,String comf_pass, String fullname_typed,bool termsCheckBox){
    if(!email.trim().contains('@')){
      _sweetheartDialog("Invalid Email Format");
      return false;
    }
    if(fullname_typed.trim().isEmpty||fullname_typed.trim().length==0){

      _sweetheartDialog("Fullname field is not valid or empty");
      return false;
    }
    if(username.trim().isEmpty||username.trim().length==0){
      _sweetheartDialog("Username is not valid or empty");
      return false;
    }
    if(Phone.isEmpty||Phone.trim().length==0){
      return false;
    }
    if(pass!=comf_pass){
      _sweetheartDialog("Passwords do not match");
      return false;
    }
    if(pass.length<6){
      _sweetheartDialog("Minimum length of Password is 6 characters");
      return false;
    }

    if(termsCheckBox==false||termsCheckBox==null){
      _sweetheartDialog("Please accept the terms and conditions");
      return false;
    }
    if(checkValuePrivacy==false||checkValuePrivacy==null){
      _sweetheartDialog("Please accept the Privacy Policies");
      return false;
    }
    return true;
  }
  _onBasicWaitingAlertPressed(context,String descrip) async {
    await Alert(
      type: AlertType.success,
      context: context,
      title: "Hola",
      desc: descrip,
    ).show();

    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }
  _onBasicErrorPressed(context,String descrip) async {
    await Alert(
      type: AlertType.error,
      context: context,
      title: "OOPS!",
      desc: descrip,
    ).show();

    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }

  _sweetheartDialog(String content){
    _sweetSheet.show(
      context: context,
      title: Text("Error"),
      description: Text(
          content),
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
}
