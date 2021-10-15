import 'package:flutter/material.dart';

import '../transaction_cards.dart';

class SFailed extends StatefulWidget {

  @override
  _SFailedState createState() => _SFailedState();
}

class _SFailedState extends State<SFailed> with TickerProviderStateMixin{

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
                indicatorColor: Colors.transparent,
                // indicatorSize: TabBarIndicatorSize.tab,
              ),
          ),
          SliverFillRemaining(
            child: TabBarView(
                children: [
                  SFalltransactions(),
                  SFselfpickup(),
                  SFdelivery(),
                ],
                controller: _tabController,
              ),
          ),
        ],
      ),
    );
  }
}




class SFalltransactions extends StatefulWidget {

  @override
  _SFalltransactionsState createState() => _SFalltransactionsState();
}

class _SFalltransactionsState extends State<SFalltransactions> {
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




class SFselfpickup extends StatefulWidget {

  @override
  _SFselfpickupState createState() => _SFselfpickupState();
}

class _SFselfpickupState extends State<SFselfpickup> {
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




class SFdelivery extends StatefulWidget {

  @override
  _SFdeliveryState createState() => _SFdeliveryState();
}

class _SFdeliveryState extends State<SFdelivery> {
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