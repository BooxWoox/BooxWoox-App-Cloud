import 'package:bookollab/Models/user.dart';
import 'package:bookollab/State/onboarding.dart';
import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/LoginPage.dart';
import 'package:bookollab/UI/widgets/ThemeButton.dart';
import 'package:bookollab/repositories/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _firestore = FirebaseFirestore.instance;

class Onboarding extends StatefulWidget {
  static String id = 'Onboarding_Screen';

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _pageController;
  String userloggedin = null;

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getuserlogininfo();
    _pageController = PageController();
  }

  bool getuserlogininfo() {
    // FirebaseAuth.instance.authStateChanges().listen((User user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //     _firestore.collection("Users").doc(user.uid).get().then((value) {
    //       if (value.get("Username").toString().isNotEmpty) {
    //         setState(() {
    //           Navigator.pushReplacementNamed(context, Homepage.id);
    //         });
    //       }
    //     });
    //   }
    // });
    Hive.box<User>('users').listenable().addListener(() {
      if (Hive.box<User>('users').get('user') != null) {
        setState(() {
          Navigator.pushReplacementNamed(context, Homepage.id);
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: onChangedFunction,
                  controller: _pageController,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child:
                                Image.asset('UIAssets/Onboarding/UI1/UI1.png')),
                        Text(
                          'Monetize your books securely!',
                          style: TextStyle(
                            fontFamily: 'Avenir95Black',
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: Text(
                            'We ensure the safekeeping of your books.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'LeelawUI',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('UIAssets/Onboarding/UI2/lab.png'),
                        Text(
                          'Connect with bibliophiles!',
                          style: TextStyle(
                            fontFamily: 'Avenir95Black',
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 200,
                          height: 150,
                          child: Text(
                            'The next gen platform for the community of book lovers.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'LeelawUI',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('UIAssets/Onboarding/UI3/UI3.png'),
                        Text(
                          'Making Knowledge Affordable',
                          style: TextStyle(
                              fontFamily: 'Avenir95Black',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 200,
                          height: 150,
                          child: Text(
                            'We offer books at a cost that fits your pocket.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'LeelawUI',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: size.height * .15,
            left: size.width * .5 - 25,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Indicator(
                    positionIndex: 0,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 1,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 2,
                    currentIndex: currentIndex,
                  ),
                ],
              ),
            ),
          ),
          currentIndex != 2
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: Center(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => nextFunction()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: 15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ThemeButton(
                              label: 'Signup',
                              onPressed: () {
                                context.read(isLogin).state = false;
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginPage.id,
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ThemeButton(
                              label: 'Login',
                              onPressed: () {
                                context.read(isLogin).state = false;
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginPage.id,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: positionIndex == currentIndex
              ? Theme.of(context).primaryColor
              : Color(0xFFC2C2C2),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
