import 'package:flutter/material.dart';

import '../transaction_cards.dart';

class SOngoing extends StatefulWidget {

  @override
  _SOngoingState createState() => _SOngoingState();
}

class _SOngoingState extends State<SOngoing> with TickerProviderStateMixin{

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
                  Soalltransactions(),
                  Soselfpickup(),
                  Sodelivery(),
                ],
                controller: _tabController,
              ),
          ),
        ],
      ),
    );
  }
}




class Soalltransactions extends StatefulWidget {

  @override
  _SoalltransactionsState createState() => _SoalltransactionsState();
}

class _SoalltransactionsState extends State<Soalltransactions> {
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




class Soselfpickup extends StatefulWidget {

  @override
  _SoselfpickupState createState() => _SoselfpickupState();
}

class _SoselfpickupState extends State<Soselfpickup> {
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




class Sodelivery extends StatefulWidget {

  @override
  _SodeliveryState createState() => _SodeliveryState();
}

class _SodeliveryState extends State<Sodelivery> {
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