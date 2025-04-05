import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/create_order/create_order.dart';
import 'package:flutter_frontend/pages/employee/employee_list/employee_list.dart';
import 'package:flutter_frontend/pages/employee/employee_role/role_list.dart';

class EmployeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Employee', style: TextStyle(color: Colors.white)),
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
              leading: Icon(
                Icons.list,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                'Employee List',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListEmployeeScreen()),
                );
              },
            ),
            Divider(color: Colors.black),
            ListTile(
              leading: Icon(
                Icons.assignment_ind,
                color: Colors.black,
                size: 30,
              ),
              title: Text('Roles', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoleListScreen()),
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
