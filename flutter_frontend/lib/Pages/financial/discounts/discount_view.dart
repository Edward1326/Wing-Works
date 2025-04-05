import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/financial/discounts/discount_edit.dart';

class ViewDiscountScreen extends StatelessWidget {
  final String name;
  final String value;
  final String type;

  ViewDiscountScreen(
      {required this.name, required this.value, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('View Discount', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDiscountScreen(
                    name: name,
                    value: value,
                    type: type,
                  ),
                ),
              );
            },
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: name),
              decoration: InputDecoration(
                labelText: 'Name',
                border: UnderlineInputBorder(),
              ),
              readOnly: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: TextEditingController(text: value),
              decoration: InputDecoration(
                labelText: 'Value',
                border: UnderlineInputBorder(),
              ),
              readOnly: true,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ToggleButtons(
                  isSelected: [type == "%", type == "∑"],
                  onPressed: null,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('%', style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('∑', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
