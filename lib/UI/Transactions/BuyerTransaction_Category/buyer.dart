import 'package:bookollab/UI/Transactions/BuyerTransaction_Category/buyer_completed.dart';
import 'package:bookollab/UI/Transactions/BuyerTransaction_Category/buyer_failed.dart';
import 'package:bookollab/UI/Transactions/BuyerTransaction_Category/buyer_ongoing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Buyer extends StatefulWidget {
  @override
  _BuyerState createState() => _BuyerState();
}

class _BuyerState extends State<Buyer> with TickerProviderStateMixin {
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
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                labelColor: Color(0xFFFFCC00),
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.add_shopping_cart_sharp),
                        Text("Ongoing"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.person_pin_rounded),
                        Text("Completed"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.person_pin_rounded),
                        Text("Failed"),
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
                  BOngoing(),
                  BCompleted(),
                  BFailed(),
                ],
                controller: _tabController,
              ),
          ),
        ],
      ),
    );
  }
}