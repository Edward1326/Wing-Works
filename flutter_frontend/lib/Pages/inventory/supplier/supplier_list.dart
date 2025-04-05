import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'supplier_create.dart';
import 'supplier_view.dart';

class ListSupplierScreen extends StatefulWidget {
  @override
  _ListSupplierScreenState createState() => _ListSupplierScreenState();
}

class _ListSupplierScreenState extends State<ListSupplierScreen> {
  bool _isActive = true;
  List<Map<String, dynamic>> suppliers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/api/suppliers/list/'); // Change to your supplier endpoint

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          suppliers = data.map<Map<String, dynamic>>((s) {
            return {
              'id': s['id'],
              'name': s['supplier_name'] ?? '',
              'email': s['email_address'] ?? '',
              'contact': s['contact_number'] ?? '',
            };
          }).toList();

          _isLoading = false;
        });
      } else {
        print("Failed to fetch suppliers: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredSuppliers = suppliers; // Add filter logic if needed

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Supplier List', style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isActive,
                  onChanged: (bool? value) {
                    setState(() => _isActive = value!);
                  },
                  fillColor: MaterialStateProperty.all(Colors.white),
                ),
                Text('Active', style: TextStyle(color: Colors.white)),
                Radio(
                  value: false,
                  groupValue: _isActive,
                  onChanged: (bool? value) {
                    setState(() => _isActive = value!);
                  },
                  fillColor: MaterialStateProperty.all(Colors.white),
                ),
                Text('Inactive', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : suppliers.isEmpty
                ? Center(child: Text('No suppliers found'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.white),
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.white),
                            children: [
                              tableCell('Name', isHeader: true),
                              tableCell('Email', isHeader: true),
                              tableCell('Contact', isHeader: true),
                            ],
                          ),
                          ...filteredSuppliers.map((supplier) {
                            return TableRow(
                              children: [
                                tableCell(supplier['name'],
                                    onTap: () =>
                                        _viewSupplier(context, supplier)),
                                tableCell(supplier['email'],
                                    onTap: () =>
                                        _viewSupplier(context, supplier)),
                                tableCell(supplier['contact'],
                                    onTap: () =>
                                        _viewSupplier(context, supplier)),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateSupplierScreen()),
          );
          fetchSuppliers(); // Refresh list
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _viewSupplier(BuildContext context, Map<String, dynamic> supplier) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewSupplierScreen(supplier: supplier),
      ),
    );
  }

  Widget tableCell(String text, {bool isHeader = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
