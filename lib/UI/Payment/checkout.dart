import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Checkout extends StatefulWidget {

  static String id = 'checkout';

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  String dropdownMonths;
  String dropdownCity;
  String dropdownMedium;

  List<String> months = [
    'One', 'Two', 'Free', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve',
  ];

  List<String> city = [
    'One', 'Two', 'Free', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve',
  ];

  List<String> medium = [
    'One', 'Two', 'Free', 'Four', 'Five',
  ];

  String deposit = '90.00';
  String rent = '09.00';
  String delivery = '02.00';
  String convenience = '04.00';

  String total = '105.00';

  List<Container> addresses = [
    
  ];

  // AlertDialog addAddress = AlertDialog(
  //   content: SingleChildScrollView(
  //     child: ListBody(
  //       children: [
  //         Row(
  //           children: [
  //             Icon(Icons.location_pin, color: Color(0xFFFFCC00),),
  //           ],
  //         ),

  //         SizedBox(
  //           height: 20,
  //         ),

  //         Text('Select from past addresses', style: TextStyle(color: Colors.grey[300], fontSize: 12),),

  //         SizedBox(
  //           height: 20,
  //         ),

  //         Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               TextButton(
  //               onPressed: (){},
  //               child: Text('Address 1'),
  //             ),
  //             Icon(Icons.cancel),
  //             ],
  //           ),
  //         ),  

  //         SizedBox(
  //           height: 10,
  //         ),

  //         Container(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 TextButton(
  //                 onPressed: (){},
  //                 child: Text('Address 2'),
  //               ),
  //               Icon(Icons.cancel),
  //               ],
  //           ),
  //         ),

  //         SizedBox(
  //           height: 25,
  //         ),

  //         Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey[800],),

  //         SizedBox(
  //           height: 25,
  //         ),
  //       ],
  //     ),
  //   ),
  //   actions: [
  //     ElevatedButton(
  //       onPressed: (){},
  //       child: Text('Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
  //       style: ElevatedButton.styleFrom(
  //         elevation: 0,
  //         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
  //         primary: Colors.grey[300],
  //       ),
  //     ),

  //     ElevatedButton(
  //       onPressed: (){},
  //       child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
  //       style: ElevatedButton.styleFrom(
  //         elevation: 0,
  //         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
  //         primary: Color(0xFFFFCC00),
  //       ),
  //     ),
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFCC00),
        title: Text('Checkout', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Borrowing period (months)', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),

                    SizedBox(
                      height: 7,
                    ),

                    Container(
                      color: Colors.grey[300],
                      child: DropdownButton<String>(
                        hint: Text('Select number of months'),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        underline: SizedBox(),
                        value: dropdownMonths,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownMonths = newValue;
                          });
                        },
                        items: months
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    Text('Select your city', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),

                    SizedBox(
                      height: 7,
                    ),

                    Container(
                      color: Colors.grey[300],
                      child: DropdownButton<String>(
                        hint: Text('Select number of months'),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        underline: SizedBox(),
                        value: dropdownCity,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownCity = newValue;
                          });
                        },
                        items: city
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFFFCC00)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: (){},
                            elevation: 0,
                            child: Icon(Icons.add, color: Color(0xFFFFCC00),),
                          ),
                        ),

                        SizedBox(
                          width: 10,
                        ),

                        Text('Add book drop address', style: TextStyle(color: Colors.black, fontSize: 18,)),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Text('Select transfer medium', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 2,
                    ),
                    Text('The book is approximately XX km radius from book drop address.', style: TextStyle(color: Colors.red, fontSize: 10,)),

                    SizedBox(
                      height: 7,
                    ),

                    Container(
                      color: Colors.grey[300],
                      child: DropdownButton<String>(
                        hint: Text('Select number of months'),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        underline: SizedBox(),
                        value: dropdownMedium,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownMedium = newValue;
                          });
                        },
                        items: medium
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    Text('Rental Details', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),

                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
      
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        color: Colors.grey[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Deposit amount', style: TextStyle(fontSize: 18),),
                            Text('\$'+deposit, style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 2,
                      ),

                      Text('*refunded to you on sale return on books', style: TextStyle(color: Colors.grey, fontSize: 12,)),

                      SizedBox(
                        height: 7,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        color: Colors.grey[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rent/month', style: TextStyle(fontSize: 18),),
                            Text('\$'+rent, style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 7,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        color: Colors.grey[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery charges', style: TextStyle(fontSize: 18),),
                            Text('\$'+delivery, style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 7,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        color: Colors.grey[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Convenience fees', style: TextStyle(fontSize: 18),),
                            Text('\$'+convenience, style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 2,
                      ),

                      Text('*2% of deposit+rent+delivery charges', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                      SizedBox(
                        height: 2,
                      ),
                      Text('*Bank charges will be applicable', style: TextStyle(color: Colors.grey, fontSize: 12,)),

                      SizedBox(
                        height: 12,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        color: Colors.yellow[400],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                            Text('\$'+total, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        onPressed: (){},
                        child: Text('Proceed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 112, vertical: 12),
                          primary: Color(0xFFFFCC00),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}