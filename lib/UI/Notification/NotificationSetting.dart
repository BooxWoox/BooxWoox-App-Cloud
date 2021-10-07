import 'package:flutter/material.dart';

class NotificationSetting extends StatefulWidget {
  static String id = 'NotificationSetting';

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
        backgroundColor: Color(0xFFFFBD06),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: 0.00),
                child: Column(
                  children: [
                    Text(
                      '     Push Notification',
                      style: TextStyle(fontSize: 18.00),
                    ),
                    Text(
                      '  Tap to enable notifications',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10.00),
                    )
                  ],
                ),
              ),
              trailing: Switch(
                value: isSwitched1,
                onChanged: (value) {
                  setState(() {
                    isSwitched1 = value;
                    print(isSwitched1);
                  });
                },
                activeTrackColor: Colors.grey.shade500,
                activeColor: Colors.orangeAccent,
              ),
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
              leading: Column(
                children: [
                  Text(
                    'Order and Purchase',
                    style: TextStyle(fontSize: 18.00),
                  ),
                  Text(
                    '         Receive notification related to your order',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 10.00),
                  )
                ],
              ),
              trailing: Switch(
                value: isSwitched2,
                onChanged: (value) {
                  setState(() {
                    isSwitched2 = value;
                    print(isSwitched2);
                  });
                },
                activeTrackColor: Colors.grey.shade500,
                activeColor: Colors.orangeAccent,
              ),
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
              leading: Column(
                children: [
                  Text(
                    '   All notifications',
                    style: TextStyle(fontSize: 18.00),
                  ),
                  Text(
                    '         Tap to receive all notifications',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 10.00),
                  )
                ],
              ),
              trailing: Switch(
                value: isSwitched3,
                onChanged: (value) {
                  setState(() {
                    isSwitched3 = value;
                    print(isSwitched3);
                  });
                },
                activeTrackColor: Colors.grey.shade500,
                activeColor: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
