import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/employee/employee_list/employee_create.dart';
import 'package:flutter_frontend/pages/employee/employee_main.dart';
import 'package:flutter_frontend/pages/employee/employee_list/employee_view.dart';

void main() {
  runApp(EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmployeeScreen(),
    );
  }
}

class ListEmployeeScreen extends StatefulWidget {
  @override
  _ListEmployeeScreenState createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  bool _isActive = true;

  final List<Map<String, String>> employees = [
    {
      'username': 'jc1234',
      'name': 'Jeff Cruz',
      'email': 'JeffCruz@gmail.com',
      'contact': '09587345344',
      'role': 'Manager',
      'pin': '1234'
    },
    {
      'username': 'ejj189',
      'name': 'Efren James',
      'email': 'Jfffe23@gmail.com',
      'contact': '09587753414',
      'role': 'Cashier',
      'pin': '5678'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Employee List', style: TextStyle(color: Colors.white)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.all(color: Colors.white),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(3),
                4: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.white),
                  children: [
                    tableCell('Username', isHeader: true),
                    tableCell('Name', isHeader: true),
                    tableCell('Email', isHeader: true),
                    tableCell('Contact Number', isHeader: true),
                    tableCell('Role', isHeader: true),
                  ],
                ),
                ...employees.map((employee) {
                  return TableRow(
                    children: [
                      tableCell(employee['username']!,
                          onTap: () => _viewEmployee(context, employee)),
                      tableCell(employee['name']!,
                          onTap: () => _viewEmployee(context, employee)),
                      tableCell(employee['email']!,
                          onTap: () => _viewEmployee(context, employee)),
                      tableCell(employee['contact']!,
                          onTap: () => _viewEmployee(context, employee)),
                      tableCell(employee['role']!,
                          onTap: () => _viewEmployee(context, employee)),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEmployeeScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _viewEmployee(BuildContext context, Map<String, String> employee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewEmployeeScreen(employee: employee),
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
