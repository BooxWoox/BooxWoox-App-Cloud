import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
class Onboarding extends StatefulWidget {
  static String id='Onboarding_Screen';

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
    var size =MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width*0.65,
                height: size.height*0.30,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Image.asset('UIAssets/curve2.png')),
              ),
              SafeArea(
                child: Container(
                  width: size.width*0.35,
                    child: FittedBox(
                      fit: BoxFit.contain,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('UIAssets/Onboarding/UI1/bookollab.png'),
                        ))),
              )
            ],
          ),
          Expanded(
            flex: 9,
            child: PageView(
              onPageChanged: onChangedFunction,
              controller: _pageController,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('UIAssets/Onboarding/UI1/UI1.png'),
                    Text('Lend and take!',
                    style:  TextStyle(
                      fontFamily: 'Avenir95Black',
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(
                      height: 5,
                    ),
                    Text('your favourite books and best',
                      style:  TextStyle(
                          fontFamily: 'LeelawUI',
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                    Text('content effortlessly',
                      style:  TextStyle(
                          fontFamily: 'LeelawUI',
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('UIAssets/Onboarding/UI1/UI1.png'),
            Text('Lend and take!',
              style:  TextStyle(
                  fontFamily: 'Avenir95Black',
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(
              height: 5,
            ),
            Text('your favourite books and best',
              style:  TextStyle(
                  fontFamily: 'LeelawUI',
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
            Text('content effortlessly',
              style:  TextStyle(
                  fontFamily: 'LeelawUI',
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),)
          ],
        ),
                Column(
                  mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('UIAssets/Onboarding/UI1/UI1.png'),
          Text('Lend and take!',
            style:  TextStyle(
                fontFamily: 'Avenir95Black',
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(
            height: 5,
          ),
          Text('your favourite books and best',
            style:  TextStyle(
                fontFamily: 'LeelawUI',
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),),
          Text('content effortlessly',
            style:  TextStyle(
                fontFamily: 'LeelawUI',
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),)
        ],
      ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () => previousFunction(),
                        child: Text("Previous")),
                    SizedBox(
                      width: 50,
                    ),
                    InkWell(onTap: () => nextFunction(), child: Text("Next"))
                  ],
                ),
              ),
            ),
          ),
        ],
      )
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
              ? Color(0xFFB67400)
              : Color(0xFFC2C2C2),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}