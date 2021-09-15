import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'widgetbox.dart';
// import 'tags.dart';

class Bookindividualview extends StatefulWidget {

  @override
  _BookindividualviewState createState() => _BookindividualviewState();
}

TextStyle textstyleinactive = TextStyle(
  fontFamily: 'Poppins',
  color: Colors.black,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

TextStyle textstyleactive = TextStyle(
  fontFamily: 'Poppins',
  color: Color(0xffFFBD06),
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

BoxDecoration boxdinactive = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  color: Color(0xffFFBD06),
);

BoxDecoration boxdactive = BoxDecoration(
  color: Color(0xffffffff),
  border: Border.all(
    color: Color(0xffFFBD06),
  ),
  borderRadius: BorderRadius.circular(10.0),
);

TextStyle t1 = textstyleinactive ;
TextStyle t2 = textstyleinactive ;
BoxDecoration b1 = boxdinactive ;
BoxDecoration b2 = boxdinactive ;

class _BookindividualviewState extends State<Bookindividualview> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFBD06),
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.25,
                            decoration: BoxDecoration(
                              color: Color(0xffFFBD06),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFFBD06),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.75 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(50.0,15.0, 50.0,15.0),
                                    color: Color(0xffffffff),
                                    height: 200.0,
                                    // alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          'Prescient - D.S. Murphy',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 27.0,
                                          ),
                                        ),
                                        Text(
                                          'Owner name',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          textBaseline: TextBaseline.alphabetic,
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          children: [
                                            Text(
                                              'Rs. 9.00',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 27.0,
                                              ),
                                            ),
                                            Text(
                                              '/month',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100.0,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.solidStar,
                                              color: Color(0xffFFBD06),
                                            ),
                                            Text(
                                              '4/5',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Deposit - Rs. 90.00',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  boxxxx(
                                    height: 115,
                                    childc: Container(
                                      margin: EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
                                      padding: EdgeInsets.only(left: 30.0),
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Tags',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Tagg(name: 'Politics'),
                                                Tagg(name: 'Politics'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  boxxxx(
                                    height: 131,
                                    childc: Container(
                                      margin: EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
                                      padding: EdgeInsets.only(left: 30.0),
                                      // alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Highlights',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(

                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  boxxxx(
                                    height: 131.0,
                                    childc: Container(
                                      margin: EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
                                      padding: EdgeInsets.only(left: 30.0),
                                      // alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Description',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(

                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  boxxxx(
                                    height: 348.0,
                                    childc: Container(
                                      margin: EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
                                      padding: EdgeInsets.only(left: 30.0),
                                      // alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Reviews',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 30.0,
                        left: MediaQuery.of(context).size.width *0.3,
                        child: Container(
                          height: 250.0,
                          width: 190.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            //       boxShadow: [
                            //       BoxShadow(
                            //       color: Color(0xffE5E5E5),
                            //   offset: Offset(0, 5), //(x,y)
                            //   blurRadius: 15.0,
                            //   spreadRadius: 10,
                            // )
                            //   ]
                          ),
                          child: Image.asset('images/prescient.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 83.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffE5E5E5),
                      offset: Offset(0, 5), //(x,y)
                      blurRadius: 15.0,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            t1 = textstyleactive ;
                            b1 = boxdactive ;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(30.0, 15.0, 15.0, 15.0),
                          decoration: b1,
                          child: Center(
                            child: Text(
                              'Add to wishlist',
                              style: t1 ,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            t2 = textstyleactive ;
                            b2 = boxdactive ;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15.0, 15.0, 30.0, 15.0),
                          decoration: b2,
                          child: Center(
                            child: Text(
                              'Borrow now',
                              style: t2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






class boxxxx extends StatelessWidget {

  boxxxx({@required this.childc, @required this.height});

  final double height ;
  final Widget childc ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.0,15.0, 25.0,15.0),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Color(0xffE5E5E5),
            offset: Offset(0, 5), //(x,y)
            blurRadius: 15.0,
            spreadRadius: 10,
          )
        ],
      ),
      child: childc ,
    );
  }
}


class Tagg extends StatelessWidget {

  Tagg({@required this.name});

  final String name ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      decoration: BoxDecoration(
        color: Color(0xffFFBD06),
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 35.0,
      width: 90.0,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}