import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/employee/employee_main.dart';
import 'package:flutter_frontend/pages/employee/employee_role/role_create.dart';
import 'package:flutter_frontend/pages/employee/employee_role/role_view.dart';

void main() {
  runApp(RoleApp());
}

class RoleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmployeeScreen(),
    );
  }
}

class RoleListScreen extends StatefulWidget {
  @override
  _RoleListScreenState createState() => _RoleListScreenState();
}

class _RoleListScreenState extends State<RoleListScreen> {
  final Map<String, int> roles = {
    'Manager': 1,
    'Cashier': 1,
    'Cook': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Role List', style: TextStyle(color: Colors.white)),
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
              border: TableBorder.all(color: Colors.black),
              columnWidths: {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.white),
                  children: [
                    tableCell('Role', isHeader: true),
                    tableCell('Employees', isHeader: true),
                  ],
                ),
                ...roles.entries.map((entry) {
                  return TableRow(
                    children: [
                      tableCell(entry.key, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewRoleScreen(
                              roleName: entry.key,
                              roleAccess: {
                                'Ordering System and POS': false,
                                'Inventory Management System': false,
                                'Financial Management System': false,
                                'Booking Management System': false,
                                'Employee Management System': false,
                              },
                            ),
                          ),
                        );
                      }),
                      tableCell(entry.value.toString()),
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
            MaterialPageRoute(builder: (context) => CreateRoleScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
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
