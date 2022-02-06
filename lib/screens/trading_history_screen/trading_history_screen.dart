import "package:flutter/material.dart";
import 'package:goindiastocks_internship_assignment/enums/bulk_or_block.dart';
import 'package:goindiastocks_internship_assignment/screens/trading_history_screen/purchase_details_tab_view/purchase_details_tab_view.dart';

class TradingHistoryScreen extends StatefulWidget {
  const TradingHistoryScreen({ Key? key }) : super(key: key);

  @override
  _TradingHistoryScreenState createState() => _TradingHistoryScreenState();
}

class _TradingHistoryScreenState extends State<TradingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildBody()));
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const <Widget>[
          TabBar(
            indicatorColor: Colors.orange,
            tabs: <Widget>[
              Tab(text: "Bulk Deal"),
              
              Tab(text: "Block Deal")
            ]
          ),

          Expanded(
            child: TabBarView(
              children: <Widget>[
                PurchaseDetailsTabView(type: BulkOrBlock.bulk),
                
                PurchaseDetailsTabView(type: BulkOrBlock.block)
              ]
            )
          )
        ]
      )
    );
  }
}