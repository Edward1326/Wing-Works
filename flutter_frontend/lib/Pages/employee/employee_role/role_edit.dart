import 'package:flutter/material.dart';

class RoleEditScreen extends StatefulWidget {
  final String roleName;
  final Map<String, bool> roleAccess;

  RoleEditScreen({required this.roleName, required this.roleAccess});

  @override
  _RoleEditScreenState createState() => _RoleEditScreenState();
}

class _RoleEditScreenState extends State<RoleEditScreen> {
  late TextEditingController _roleController;
  late Map<String, bool> _roleAccess;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _roleController = TextEditingController(text: widget.roleName);
    _roleAccess = Map.from(widget.roleAccess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Edit Role', style: TextStyle(color: Colors.white)),
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
                    setState(() {
                      _isActive = value!;
                    });
                  },
                ),
                Text('Active'),
                SizedBox(width: 20),
                Radio(
                  value: false,
                  groupValue: _isActive,
                  onChanged: (bool? value) {
                    setState(() {
                      _isActive = value!;
                    });
                  },
                ),
                Text('Inactive'),
              ],
            ),
            SizedBox(height: 10),
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
      print('Updated Role Name: $roleName');
      print('Updated Access Permissions: $_roleAccess');
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a role name.')),
      );
    }
  }
}
