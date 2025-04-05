import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateRoleScreen extends StatefulWidget {
  @override
  _CreateRoleScreenState createState() => _CreateRoleScreenState();
}

class _CreateRoleScreenState extends State<CreateRoleScreen> {
  final TextEditingController _roleController = TextEditingController();

  Map<String, bool> _roleAccess = {
    'POS (Create Order)': false,
    'Ordering System (Order List)': false,
    'Inventory Management System': false,
    'Financial Management System': false,
    'Booking Management System': false,
    'Employee Management System': false,
  };

  final Map<String, String> _featureNameMap = {
    'POS (Create Order)': 'create_order',
    'Ordering System (Order List)': 'orders_list',
    'Inventory Management System': 'inventory',
    'Financial Management System': 'financial',
    'Booking Management System': 'booking',
    'Employee Management System': 'employee',
  };

  Future<void> _saveRole() async {
    String roleName = _roleController.text.trim();

    if (roleName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a role name.')),
      );
      return;
    }

    // Collect backend keys (feature names) instead of IDs
    List<String> selectedAccessRights = [];
    _roleAccess.forEach((label, value) {
      if (value) {
        String? backendKey = _featureNameMap[label];
        if (backendKey != null) {
          selectedAccessRights.add(backendKey);
        }
      }
    });

    String apiUrl = "http://10.0.2.2:8000/api/roles/create/";

    Map<String, dynamic> roleData = {
      "role_name": roleName,
      "access_rights": selectedAccessRights,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(roleData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Role Created Successfully!")),
        );
        Navigator.pop(context);
      } else {
        print("Failed to create role: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to Create Role")),
        );
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Connecting to Server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Create Role', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: _saveRole,
            child: Text('Add',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _roleController,
                decoration: InputDecoration(
                  labelText: 'Role Name',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Divider(height: 24),
            Text('Access Rights',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ..._roleAccess.keys.map((key) {
              return SwitchListTile(
                title: Text(key),
                value: _roleAccess[key]!,
                activeColor: Color(0xFFB51616),
                onChanged: (value) {
                  setState(() {
                    _roleAccess[key] = value;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
