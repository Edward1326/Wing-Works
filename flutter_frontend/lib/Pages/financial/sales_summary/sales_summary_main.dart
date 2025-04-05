import 'package:flutter/material.dart';

class SalesSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Sales Summary', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.bar_chart, color: Colors.black, size: 30),
              title:
                  Text('Overall Sales Summary', style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            Divider(color: Colors.black),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.black, size: 30),
              title: Text('Standard Sales Summary',
                  style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            Divider(color: Colors.black),
            ListTile(
              leading: Icon(Icons.event, color: Colors.black, size: 30),
              title:
                  Text('Event Sales Summary', style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
