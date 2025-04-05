import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/financial/discounts/discount_create.dart';
import 'package:flutter_frontend/pages/financial/discounts/discount_view.dart';

class DiscountListScreen extends StatefulWidget {
  @override
  _DiscountListScreenState createState() => _DiscountListScreenState();
}

class _DiscountListScreenState extends State<DiscountListScreen> {
  bool _isActive = true;
  final List<Map<String, String>> discounts = [
    {'name': 'Senior Citizen', 'value': '20%', 'type': '%'},
    {'name': 'Student Discount', 'value': '15%', 'type': '%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Discounts', style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: _isActive,
                      onChanged: (bool? value) {
                        setState(() {
                          _isActive = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.all(Colors.white),
                    ),
                    Text('Active',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: _isActive,
                      onChanged: (bool? value) {
                        setState(() {
                          _isActive = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.all(Colors.white),
                    ),
                    Text('Inactive',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                // Implement search functionality
              },
            ),
          ),
        ],
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
          children: discounts.map((discount) {
            return Column(
              children: [
                ListTile(
                  title:
                      Text(discount['name']!, style: TextStyle(fontSize: 20)),
                  trailing:
                      Text(discount['value']!, style: TextStyle(fontSize: 20)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewDiscountScreen(
                          name: discount['name']!,
                          value: discount['value']!,
                          type: discount['type']!,
                        ),
                      ),
                    );
                  },
                ),
                Divider(color: Colors.black),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateDiscountScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
