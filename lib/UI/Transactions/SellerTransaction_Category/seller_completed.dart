import 'package:flutter/material.dart';

class SCompleted extends StatefulWidget {

  @override
  _SCompletedState createState() => _SCompletedState();
}

class _SCompletedState extends State<SCompleted> with TickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            // color: Color(0xFFFFCC00),
            child: TabBar(
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
          Expanded(
            child: TabBarView(
              children: [
                SCalltransactions(),
                SCselfpickup(),
                SCdelivery(),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}




class SCalltransactions extends StatefulWidget {

  @override
  _SCalltransactionsState createState() => _SCalltransactionsState();
}

class _SCalltransactionsState extends State<SCalltransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}




class SCselfpickup extends StatefulWidget {

  @override
  _SCselfpickupState createState() => _SCselfpickupState();
}

class _SCselfpickupState extends State<SCselfpickup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}




class SCdelivery extends StatefulWidget {

  @override
  _SCdeliveryState createState() => _SCdeliveryState();
}

class _SCdeliveryState extends State<SCdelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}