import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_frontend/pages/employee/employee_role/role_edit.dart';

class ViewRoleScreen extends StatefulWidget {
  final int roleId;

  ViewRoleScreen({required this.roleId});

  @override
  _ViewRoleScreenState createState() => _ViewRoleScreenState();
}

class _ViewRoleScreenState extends State<ViewRoleScreen> {
  String roleName = '';
  bool isActive = true;
  bool isLoading = true;

  Map<String, bool> roleAccess = {
    'create_order': false,
    'orders_list': false,
    'inventory': false,
    'financial': false,
    'booking': false,
    'employee': false,
  };

  final Map<String, String> backendToLabel = {
    'create_order': 'POS (Create Order)',
    'orders_list': 'Ordering System (Order List)',
    'inventory': 'Inventory Management System',
    'financial': 'Financial Management System',
    'booking': 'Booking Management System',
    'employee': 'Employee Management System',
  };

  @override
  void initState() {
    super.initState();
    fetchRoleData();
  }

  Future<void> fetchRoleData() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/roles/${widget.roleId}/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List accessRights = data['access_rights'];

        setState(() {
          roleName = data['role_name'];
          isActive =
              data['status'].toString().toLowerCase() == 'active'; // ✅ Fix here
          roleAccess.updateAll((key, value) => false);
          for (var right in accessRights) {
            if (roleAccess.containsKey(right)) {
              roleAccess[right] = true;
            }
          }
          isLoading = false;
        });
      } else {
        print('Failed to load role: ${response.body}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('View Role', style: TextStyle(color: Colors.white)),
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
                  builder: (context) => RoleEditScreen(
                    roleId: widget.roleId,
                    roleName: roleName,
                    isActive: isActive,
                    roleAccess: {
                      for (var entry in roleAccess.entries)
                        backendToLabel[entry.key]!: entry.value,
                    },
                  ),
                ),
              );
            },
            child: Text('Edit', style: TextStyle(color: Colors.white)),
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
                  Text('Name of Role', style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      roleName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: roleAccess.entries.map((entry) {
                      return IgnorePointer(
                        child: SwitchListTile(
                          title: Text(
                            backendToLabel[entry.key] ?? entry.key,
                            style: TextStyle(
                              color: entry.value
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                          ),
                          value: entry.value,
                          onChanged: (_) {},
                          activeColor: Color(0xFFB51616),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
      ),
    );
  }
}
