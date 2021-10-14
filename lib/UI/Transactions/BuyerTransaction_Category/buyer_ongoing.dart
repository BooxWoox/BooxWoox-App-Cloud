import 'package:flutter/material.dart';

import '../transaction_cards.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TabBar(
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                unselectedLabelStyle: TextStyle(fontSize: 12),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
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
          SliverFillRemaining(
            child: TabBarView(
                children: [
                  BOalltransactions(),
                  BOselfpickup(),
                  BOdelivery(),
                ],
                controller: _tabController,
              ),
          ),
        ],
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
      body: ListView(
        children: [
          ReceivedNotReturn(),
          BookNotReceived(),
          ReturnInitiated(),
        ],
      ),
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
      body: ListView(
        children: [
          ReceivedNotReturn(),
          BookNotReceived(),
          ReturnInitiated(),
        ],
      ),
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
      body: ListView(
        children: [
          ReceivedNotReturn(),
          BookNotReceived(),
          ReturnInitiated(),
        ],
      ),
    );
  }
}