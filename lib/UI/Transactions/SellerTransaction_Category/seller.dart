import 'package:bookollab/UI/Transactions/SellerTransaction_Category/seller_completed.dart';
import 'package:bookollab/UI/Transactions/SellerTransaction_Category/seller_failed.dart';
import 'package:bookollab/UI/Transactions/SellerTransaction_Category/seller_ongoing.dart';
import 'package:flutter/material.dart';

class Seller extends StatefulWidget {

  @override
  _SellerState createState() => _SellerState();
}

class _SellerState extends State<Seller> with TickerProviderStateMixin{

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
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              unselectedLabelStyle: TextStyle(fontSize: 16),
              labelColor:Color(0xFFFFCC00),
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
          Expanded(
            child: TabBarView(
              children: [
                SOngoing(),
                SCompleted(),
                SFailed(),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}