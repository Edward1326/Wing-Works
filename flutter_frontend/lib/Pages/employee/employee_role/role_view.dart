import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/employee/employee_role/role_edit.dart';

class ViewRoleScreen extends StatelessWidget {
  final String roleName;
  final Map<String, bool> roleAccess;

  ViewRoleScreen({required this.roleName, required this.roleAccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('View Role', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoleEditScreen(
                    roleName: roleName,
                    roleAccess: roleAccess,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name of Role', style: TextStyle(fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                roleName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: roleAccess.keys.map((key) {
                return SwitchListTile(
                  title: Text(key),
                  value: roleAccess[key]!,
                  activeColor: Color(0xFFB51616),
                  onChanged: null, // Disabled switch
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
