import 'package:flutter/material.dart';
import 'package:bookollab/UI/widgets/ThemeButton.dart';

class CheckPayments extends StatefulWidget {
  static String id = 'CheckPayments';
  @override
  _CheckPaymentsState createState() => _CheckPaymentsState();
}

class _CheckPaymentsState extends State<CheckPayments> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
   Future<String> message = arguments['msg'];
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        
        //child: Text(message),
      ),
    );
  }
}
