import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoleEditScreen extends StatefulWidget {
  final int roleId;
  final String roleName;
  final Map<String, bool> roleAccess;
  final bool isActive;

  RoleEditScreen({
    required this.roleId,
    required this.roleName,
    required this.roleAccess,
    required this.isActive,
  });

  @override
  _RoleEditScreenState createState() => _RoleEditScreenState();
}

class _RoleEditScreenState extends State<RoleEditScreen> {
  late TextEditingController _roleController;
  late Map<String, bool> _roleAccess;
  late bool _isActive;

  final Map<String, String> labelToBackend = {
    'POS (Create Order)': 'create_order',
    'Ordering System (Order List)': 'orders_list',
    'Inventory Management System': 'inventory',
    'Financial Management System': 'financial',
    'Booking Management System': 'booking',
    'Employee Management System': 'employee',
  };

  @override
  void initState() {
    super.initState();
    _roleController = TextEditingController(text: widget.roleName);
    _roleAccess = Map.from(widget.roleAccess);
    _isActive = widget.isActive; // ✅ Use the value from the view screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Edit Role', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveRole,
            child: Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isActive,
                  onChanged: (bool? value) {
                    setState(() => _isActive = value!);
                  },
                ),
                Text('Active'),
                SizedBox(width: 20),
                Radio(
                  value: false,
                  groupValue: _isActive,
                  onChanged: (bool? value) {
                    setState(() => _isActive = value!);
                  },
                ),
                Text('Inactive'),
              ],
            ),
            SizedBox(height: 10),
            Text('Name of Role', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _roleController,
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),
            SizedBox(height: 20),
            Column(
              children: _roleAccess.keys.map((key) {
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveRole() async {
    String roleName = _roleController.text.trim();
    if (roleName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a role name.')),
      );
      return;
    }

    final selectedPermissions = _roleAccess.entries
        .where((e) => e.value)
        .map((e) => labelToBackend[e.key])
        .where((e) => e != null)
        .toList();

    final url =
        Uri.parse('http://10.0.2.2:8000/api/roles/edit/${widget.roleId}/');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'role_name': roleName,
        'status': _isActive ? 'active' : 'inactive',
        'access_rights': selectedPermissions,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Role updated successfully.')),
      );
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update role.')),
      );
    }
  }
}
