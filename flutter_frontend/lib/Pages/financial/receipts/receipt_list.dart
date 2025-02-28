import 'package:flutter/material.dart';

class ReceiptsScreen extends StatelessWidget {
  final List<Map<String, String>> receipts = [
    {
      "receiptNo": "1-0001",
      "date": "Nov 20, 2025",
      "type": "Sale",
      "status": "Success",
      "total": "₱1000.00",
    },
    {
      "receiptNo": "1-0221",
      "date": "Nov 20, 2025",
      "type": "Booking",
      "status": "Refunded",
      "total": "₱1000.00",
    },
    {
      "receiptNo": "1-2301",
      "date": "Nov 20, 2025",
      "type": "Sale",
      "status": "Success",
      "total": "₱1000.00",
    },
    {
      "receiptNo": "1-9801",
      "date": "Nov 20, 2025",
      "type": "Sale",
      "status": "Success",
      "total": "₱1000.00",
    },
    {
      "receiptNo": "1-9801",
      "date": "Nov 20, 2025",
      "type": "Booking",
      "status": "Success",
      "total": "₱11302.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE4E1),
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text(
          'Receipts',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Column(
            children: [
              /// Header Row (Ensures headers span the entire width)
              Container(
                width: double.infinity,
                color: Color(0xFFB51616),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: Text('Receipt No.', style: headerStyle)),
                    Expanded(child: Text('Date', style: headerStyle)),
                    Expanded(child: Text('Type', style: headerStyle)),
                    Expanded(child: Text('Status', style: headerStyle)),
                    Expanded(child: Text('Total', style: headerStyle)),
                  ],
                ),
              ),

              /// Data Table Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: receipts.map((receipt) {
                      return Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(receipt["receiptNo"]!)),
                            Expanded(child: Text(receipt["date"]!)),
                            Expanded(child: Text(receipt["type"]!)),
                            Expanded(
                              child: Text(
                                receipt["status"]!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(receipt["status"]!),
                                ),
                              ),
                            ),
                            Expanded(child: Text(receipt["total"]!)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Text Style for Headers
  TextStyle get headerStyle => TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  /// Status Color Mapping
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Success':
        return Colors.green;
      case 'Refunded':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
