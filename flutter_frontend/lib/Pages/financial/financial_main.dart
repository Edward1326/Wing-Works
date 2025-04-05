import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/create_order/create_order.dart';
import 'package:flutter_frontend/pages/financial/discounts/discount_list.dart';
import 'package:flutter_frontend/pages/financial/receipts/receipt_list.dart';
import 'package:flutter_frontend/pages/financial/sales_summary/sales_summary_main.dart';

class FinancialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Financial', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: buildDrawer(context),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.black, size: 30),
              title: Text('Sales Summary', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesSummaryScreen()),
                );
              },
            ),
            Divider(color: Colors.black),
            ListTile(
              leading: Icon(Icons.receipt, color: Colors.black, size: 30),
              title: Text('Receipts', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceiptsScreen()),
                );
              },
            ),
            Divider(color: Colors.black),
            ListTile(
              leading: Icon(Icons.local_offer, color: Colors.black, size: 30),
              title: Text('Discounts', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiscountListScreen()),
                );
              },
            ),
            Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
