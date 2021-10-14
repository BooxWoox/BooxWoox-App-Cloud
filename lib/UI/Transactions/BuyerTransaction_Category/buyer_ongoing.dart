import 'package:flutter/material.dart';

class BOngoing extends StatefulWidget {

  @override
  _BOngoingState createState() => _BOngoingState();
}

class _BOngoingState extends State<BOngoing> with TickerProviderStateMixin{

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
            BOalltransactions(),
            BOselfpickup(),
            BOdelivery(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}




class BOalltransactions extends StatefulWidget {

  @override
  _BOalltransactionsState createState() => _BOalltransactionsState();
}

class _BOalltransactionsState extends State<BOalltransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}




class BOselfpickup extends StatefulWidget {

  @override
  _BOselfpickupState createState() => _BOselfpickupState();
}

class _BOselfpickupState extends State<BOselfpickup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}




class BOdelivery extends StatefulWidget {

  @override
  _BOdeliveryState createState() => _BOdeliveryState();
}

class _BOdeliveryState extends State<BOdelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}