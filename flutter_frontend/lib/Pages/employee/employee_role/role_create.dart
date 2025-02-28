import 'package:flutter/material.dart';

class CreateRoleScreen extends StatefulWidget {
  @override
  _CreateRoleScreenState createState() => _CreateRoleScreenState();
}

class _CreateRoleScreenState extends State<CreateRoleScreen> {
  TextEditingController _roleController = TextEditingController();
  Map<String, bool> _roleAccess = {
    'Ordering System and POS': false,
    'Inventory Management System': false,
    'Financial Management System': false,
    'Booking Management System': false,
    'Employee Management System': false,
  };

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
            onPressed: () {
              _saveRole();
            },
            child: Text('Save',
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
            Text('Name of Role', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _roleController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
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

  void _saveRole() {
    String roleName = _roleController.text;
    if (roleName.isNotEmpty) {
      print('Role Name: $roleName');
      print('Access Permissions: $_roleAccess');
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a role name.')),
      );
    }
  }
}
