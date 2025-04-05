import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/employee/employee_list/employee_edit.dart';

class ViewEmployeeScreen extends StatelessWidget {
  final Map<String, dynamic> employee;

  ViewEmployeeScreen({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('View Employee', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEmployeeScreen(employee: employee),
                ),
              );
            },
            child: Text('Edit',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetail('Username', employee['username'] ?? ''),
            buildDetail('Name', employee['name'] ?? ''),
            buildDetail('Email', employee['email'] ?? ''),
            buildDetail('Contact Number', employee['contact'] ?? ''),
            buildDetail('Role', employee['role'] ?? ''),
            SizedBox(height: 16),
            Text('PIN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.lock, color: Colors.grey),
                SizedBox(width: 8),
                ...employee['pin']?.toString().split('').map((digit) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(digit,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        )) ??
                    [],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: value,
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
