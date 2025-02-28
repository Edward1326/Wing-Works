import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/financial/discounts/discount_list.dart';
import 'package:flutter_frontend/pages/financial/receipts/receipt_list.dart';
import 'package:flutter_frontend/pages/financial/sales_summary/sales_summary_main.dart';

void main() {
  runApp(FinancialApp());
}

class FinancialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FinancialScreen(),
    );
  }
}

class FinancialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Financial', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFB51616),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.list, color: Colors.white),
                title:
                    Text('Create Order', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind, color: Colors.white),
                title: Text('Orders', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.inventory, color: Colors.white),
                title: Text('Inventory', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.white),
                title: Text('Financial', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.white),
                title: Text('Booking', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.people, color: Colors.white),
                title: Text('Employee', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
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
