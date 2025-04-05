import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_frontend/pages/employee/employee_role/role_create.dart';
import 'package:flutter_frontend/pages/employee/employee_role/role_view.dart';

class RoleListScreen extends StatefulWidget {
  @override
  _RoleListScreenState createState() => _RoleListScreenState();
}

class _RoleListScreenState extends State<RoleListScreen> {
  List<Map<String, dynamic>> roles = []; // role_name, employee_count, status
  bool isLoading = true;
  String filterStatus = 'active'; // default to 'active'

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/roles/list/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          roles = data
              .map<Map<String, dynamic>>((role) => {
                    'id': role['id'],
                    'role_name': role['role_name'],
                    'employee_count': role['employee_count'] ?? 0,
                    'status': role['status'] ?? 'active',
                  })
              .toList();
          isLoading = false;
        });
      } else {
        print("Failed to fetch roles: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching roles: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRoles =
        roles.where((role) => role['status'] == filterStatus).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Role List', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onSelected: (value) {
              setState(() => filterStatus = value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'active', child: Text('Active Roles')),
              PopupMenuItem(value: 'inactive', child: Text('Inactive Roles')),
            ],
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
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
                      ...filteredRoles.map((role) {
                        final roleName = role['role_name'];
                        final employeeCount = role['employee_count'];
                        final roleId = role['id'];

                        return TableRow(
                          children: [
                            tableCell(roleName, onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewRoleScreen(roleId: roleId),
                                ),
                              );
                            }),
                            tableCell(employeeCount.toString()),
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
