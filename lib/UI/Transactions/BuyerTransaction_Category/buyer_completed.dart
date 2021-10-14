import 'package:flutter/material.dart';

class BCompleted extends StatefulWidget {

  @override
  _BCompletedState createState() => _BCompletedState();
}

class _BCompletedState extends State<BCompleted> with TickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
          unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.grey),
          // labelColor:Color(0xFFFFCC00),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.add_shopping_cart_sharp),
                  Text("All transactions"),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.person_pin_rounded),
                  Text("Self-Pick Up"),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.person_pin_rounded),
                  Text("Delivery"),
                ],
              ),
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.transparent
          // indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: Expanded(
        child: TabBarView(
          children: [
            BCalltransactions(),
            BCselfpickup(),
            BCdelivery(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}




class BCalltransactions extends StatefulWidget {

  @override
  _BCalltransactionsState createState() => _BCalltransactionsState();
}

class _BCalltransactionsState extends State<BCalltransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}




class BCselfpickup extends StatefulWidget {

  @override
  _BCselfpickupState createState() => _BCselfpickupState();
}

class _BCselfpickupState extends State<BCselfpickup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}




class BCdelivery extends StatefulWidget {

  @override
  _BCdeliveryState createState() => _BCdeliveryState();
}

class _BCdeliveryState extends State<BCdelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}