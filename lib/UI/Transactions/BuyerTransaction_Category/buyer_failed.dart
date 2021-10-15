import 'package:flutter/material.dart';

import '../transaction_cards.dart';

class BFailed extends StatefulWidget {

  @override
  _BFailedState createState() => _BFailedState();
}

class _BFailedState extends State<BFailed> with TickerProviderStateMixin{

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
                  BFalltransactions(),
                  BFselfpickup(),
                  BFdelivery(),
                ],
                controller: _tabController,
              ),
          ),
        ],
      ),
    );
  }
}




class BFalltransactions extends StatefulWidget {

  @override
  _BFalltransactionsState createState() => _BFalltransactionsState();
}

class _BFalltransactionsState extends State<BFalltransactions> {
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




class BFselfpickup extends StatefulWidget {

  @override
  _BFselfpickupState createState() => _BFselfpickupState();
}

class _BFselfpickupState extends State<BFselfpickup> {
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




class BFdelivery extends StatefulWidget {

  @override
  _BFdeliveryState createState() => _BFdeliveryState();
}

class _BFdeliveryState extends State<BFdelivery> {
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