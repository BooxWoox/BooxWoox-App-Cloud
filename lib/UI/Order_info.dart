import 'package:flutter/material.dart';

class OrderInfo extends StatefulWidget {

  static String id = 'OrderInfo';

  @override
  _OrderInfoState createState() => _OrderInfoState();
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



class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFBD06),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stackssss(),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Column(
                  children: [
                    boxxxx(
                      height: 131.0,
                      childc: Container(
                        margin: EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
                        padding: EdgeInsets.only(left: 30.0),
                        // alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              'Timeline',
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
                              'Order Details',
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
              )
            ],
          ),
        ),
      );
  }
}




class Stackssss extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 175.0,
          decoration: BoxDecoration(
            color: Color(0xffFFBD06),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0,175.0,0.0,0.0),
          child: Container(
            height: 340.0,
            decoration: BoxDecoration(
              color: Color(0xffFFBD06),
            ),
            child: Container(
              height: 340.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(50.0,15.0, 50.0,15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Container(
                      height: 120.0,
                    ),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
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
            ),
          ),
        ),
        Positioned(
          top: 30.0,
          left: MediaQuery.of(context).size.width *0.25,
          child: Container(
            height: 250.0,
            width: MediaQuery.of(context).size.width *0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66000000),
                    offset: Offset(0, 5), //(x,y)
                    blurRadius: 20.0,
                    spreadRadius: 1,
                  )
                ]
            ),
            child: Image.asset('images/prescient.jpg'),
          ),
        ),
      ],
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