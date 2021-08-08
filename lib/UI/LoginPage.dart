import 'package:bookollab/UI/OTPverify.dart';
import 'package:bookollab/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  static String id = 'Login_Screen';
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 100, bottom: 20),
                child: SvgPicture.asset(
                  "UIAssets/LoginScreen/welcome.svg",
                  width: 250,
                ),
              ),
              Text(
                "Login or Signup",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "+91",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    hintText: "Enter your phone number",
                    fillColor: Color(0xFFE9E9E9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  onPressed: () {
                    try {
                      context
                          .read(authProvider)
                          .state
                          .sendOtpToPhone(phoneController.text);
                      Navigator.pushReplacementNamed(context, OTPverify.id);
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'An unexpected error occured. please try again')));
                    }
                  },
                  child: Text(
                    "Send OTP",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Avenir95Black',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "By continuing you agree to our ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                            child: InkWell(
                              child: Text(
                                "terms & conditions",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {},
                            ),
                          ),
                          TextSpan(text: " and "),
                          WidgetSpan(
                            child: InkWell(
                              child: Text(
                                "privacy policy",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
