import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'BuyerTransaction_Category/buyer.dart';
import 'SellerTransaction_Category/seller.dart';

class TheTransactions extends StatefulWidget {

  static String id = 'The_Transactions';

  @override
  _TheTransactionsState createState() => _TheTransactionsState();
}

class _TheTransactionsState extends State<TheTransactions> with TickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The transactions', style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFFFFCC00),
        bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_shopping_cart_sharp),
                      Text("Buyer"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_pin_rounded),
                      Text("Seller"),
                    ],
                  ),
                ),
              ],
              controller: _tabController,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
      ),
      body: Column(
        children: [
          Expanded(
                child: TabBarView(
                  children: [
                    Buyer(),
                    Seller(),
                  ],
                  controller: _tabController,
                ),
              ),
        ],
      ),
    );
  }
}