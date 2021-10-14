import 'package:flutter/material.dart';

class Legals extends StatefulWidget {
  static String id = 'Legals';
  @override
  _LegalsState createState() => _LegalsState();
}

class _LegalsState extends State<Legals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBD06),
        title: Text('Legals'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text('Terms and service'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.00),
            child: Divider(
              height: 20,
              thickness: 2,
            ),
          ),
          ListTile(
            leading: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.00),
            child: Divider(
              height: 20,
              thickness: 2,
            ),
          ),
          ListTile(
            leading: Text('Cancellation Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.00),
            child: Divider(
              height: 20,
              thickness: 2,
            ),
          ),
          ListTile(
            leading: Text('Sharing policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
