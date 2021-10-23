import 'package:bookollab/State/location.dart';
import 'package:bookollab/State/payment.dart';
import 'package:bookollab/UI/widgets/ThemeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/local.dart';
import 'package:location/location.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:math';

class Checkout extends StatefulWidget {
  static String id = 'checkout';

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> { 
  int month;
  String dropdownCity;
  String dropdownMedium;
  String address;

  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
    void dispose(){
      super.dispose();
      _razorpay.clear(); // Removes all listeners
    }

  Map<String, int> months = {
    '1 week': 7,
    '2 weeks': 14,
    '3 weeks': 21,
    '1 month': 30,
    '2 months': 60,
    '3 months': 90,
    '4 months': 120,
  };

  double userLongitude;
  double userLatitude;
  double bookLongitude = 72.8777;
  double bookLatitude = 19.0760;

  Address useradd;
  Future<Address> getAddress(Coordinates coordinates) async{
    final uA = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    useradd = uA.first;

    return useradd;
  }

  double dist = 0;
  double distance(double userLong, double userLat, double bookLong, double bookLat){
    userLong = userLong/57.29577951;
    userLat = userLat/57.29577951;
    bookLong = bookLong/57.29577951;
    bookLat = bookLat/57.29577951;

    double dist = 1.609344*(3963.0*(acos((sin(userLat)*sin(bookLat))+(cos(userLat)*cos(bookLat)*cos(bookLong-userLong)))));

    return dist;
  }

  String display = '';

  List<String> city = ['Ahmedabad'];

  List<String> medium = ['Self Pickup & Self-Return', 'Home Delivery'];

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  void setPaymentValues() {
    double deposit = ModalRoute.of(context).settings.arguments as double;
    context.read(paymentProvider.notifier).setValues(deposit, month,
        dropdownMedium != null ? dropdownMedium == 'Home Delivery' : null);
  }

  List<Container> addresses = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read(paymentProvider.notifier).reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFCC00),
          title: Text(
            'Checkout',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
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
                      Text(
                        'Borrowing period (months)',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffe9e9e9),
                        ),
                        padding: EdgeInsets.all(10),
                        child: DropdownButton<int>(
                          hint: Text('Select number of months'),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          underline: SizedBox(),
                          value: month,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (int newValue) {
                            setState(() {
                              month = newValue;
                            });
                            setPaymentValues();
                          },
                          items: months.entries
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.key),
                                    value: e.value,
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Select your city',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffe9e9e9),
                        ),
                        padding: EdgeInsets.all(10),
                        child: DropdownButton<String>(
                          hint: Text('Select city'),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          underline: SizedBox(),
                          value: dropdownCity,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
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
                              border: Border.all(
                                  color: address == null
                                      ? Color(0xFFFFCC00)
                                      : Colors.blue),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FloatingActionButton(
                              backgroundColor:
                                  address == null ? Colors.white : Colors.blue,
                              onPressed: () async {
                                final controller = TextEditingController(text: address);
                                await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: Text('Enter Address'),
                                    insetPadding: EdgeInsets.all(10),
                                    contentPadding: EdgeInsets.all(10),
                                    children: [
                                      TextField(
                                        controller: controller,
                                        minLines: 3,
                                        maxLines: 7,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Address'),
                                      ),

                                      ElevatedButton(
                                        child: Text(
                                          'Your current location',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 60, vertical: 10),
                                          primary: Colors.grey[300],
                                        ),
                                        onPressed: () async{
                                          try {
                                            final location = await context.read(locationProvider.future);
                                            LocationData userLocation = await location.getLocation();

                                            Coordinates userCoordinates = Coordinates(userLocation.latitude, userLocation.longitude);

                                            useradd = await getAddress(userCoordinates);

                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(e),
                                              ),
                                            );
                                          }

                                          // dist = distance(userLongitude, userLatitude, bookLongitude, bookLatitude);

                                          setState(() {
                                            controller.text = useradd.addressLine;
                                            if (controller.text != "" && controller.text != null) {
                                              address = controller.text;
                                              // display = 'The book is approximately $dist km radius from the book drop address';
                                              // print(useradd.addressLine);
                                            }
                                            Navigator.of(context).pop();
                                          });
                                          
                                        },
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ThemeButton(
                                          label: 'Submit',
                                          onPressed: () async{                                            
                                            // print(dist);
                                            if (controller.text != "" &&
                                              controller.text != null) {
                                              setState(() {
                                                address = controller.text;
                                              });
                                              Navigator.of(context).pop();
                                            }
                                            else{
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds: 1), () {
                                                  Navigator.of(context).pop(true);
                                                  });
                                                  return AlertDialog(
                                                    title: Text('Please add an address', style: TextStyle(color: Colors.black, fontSize: 12),),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                                if (controller.text != "" &&
                                    controller.text != null) {
                                  setState(() {
                                    address = controller.text;
                                  });
                                }
                              },
                              elevation: 0,
                              child: Icon(
                                address == null ? Icons.add : Icons.edit,
                                color: address == null
                                    ? Color(0xFFFFCC00)
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              address == null ? 'Add book drop address' : address,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Select transfer medium',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Text(display, style: TextStyle(color: Colors.red, fontSize: 10),),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffe9e9e9),
                        ),
                        padding: EdgeInsets.all(10),
                        child: DropdownButton<String>(
                          hint: Text('Select transfer medium'),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          underline: SizedBox(),
                          value: dropdownMedium,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownMedium = newValue;
                            });
                            setPaymentValues();
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
                      Text(
                        'Rental Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  Consumer(builder: (context, watch, child) {
                    final paymentValues = watch(paymentProvider);
                    if (paymentValues == null) {
                      return Center(
                        child: Text("Choose above values to continue"),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            color: Color(0xffe9e9e9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Deposit amount',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '₹ ${paymentValues.deposit}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text('*refunded to you on sale return on books',
                              style: TextStyle(
                                color: Color(0xff7d7d7d),
                                fontSize: 12,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            color: Color(0xffe9e9e9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rent/month',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '₹ ${paymentValues.rent}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            color: Color(0xffe9e9e9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery charges',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '₹ ${paymentValues.deliveryCharge}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            color: Color(0xffe9e9e9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Convenience fees',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '₹ ${paymentValues.convenienceFee}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text('*5% of deposit+rent+delivery charges',
                              style: TextStyle(
                                color: Color(0xff7d7d7d),
                                fontSize: 12,
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text('*Bank charges will be applicable',
                              style: TextStyle(
                                color: Color(0xff7d7d7d),
                                fontSize: 12,
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            color: Color(0xFFFFD791),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹ ${paymentValues.total}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ThemeButton(
                            label: 'Proceed',
                            onPressed: () {
                              if (address == null || address == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please enter your address"),
                                  ),
                                );
                                return;
                              } else if (dropdownCity == null ||
                                  dropdownCity == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please choose your city"),
                                  ),
                                );
                                return;
                              }
                              var options = {
                                'key': '<YOUR_KEY_HERE>',
                                'amount': paymentValues.total,
                                'name': 'BooxWoox',
                                'description': 'Payment for book-borrowingt',
                                'prefill': {}
                              };
                              _razorpay.open(options);
                            },
                            width: double.maxFinite,
                          )
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
