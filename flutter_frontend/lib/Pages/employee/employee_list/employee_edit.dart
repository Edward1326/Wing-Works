import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditEmployeeScreen extends StatefulWidget {
  final Map<String, dynamic> employee;

  EditEmployeeScreen({required this.employee});

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;

  String? _selectedRole;
  String? _pin;
  bool _isActive = true;
  bool _isSaving = false;

  List<String> _roles = [];

  @override
  void initState() {
    super.initState();

    _usernameController =
        TextEditingController(text: widget.employee['username']);
    _emailController = TextEditingController(text: widget.employee['email']);
    _contactController =
        TextEditingController(text: widget.employee['contact']);
    _selectedRole = widget.employee['role'];
    _pin = widget.employee['pin'];
    _isActive = (widget.employee['status'] ?? 'active') == 'active';

    // Split full name into first and last
    final nameParts = (widget.employee['name'] ?? '').split(' ');
    _firstNameController =
        TextEditingController(text: nameParts.isNotEmpty ? nameParts[0] : '');
    _lastNameController = TextEditingController(
      text: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
    );

    fetchRoles();
  }

  Future<void> fetchRoles() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/roles/list/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          _roles = data.map<String>((r) => r['role_name'] as String).toList();
        });
      }
    } catch (e) {
      print('Error fetching roles: $e');
    }
  }

  Future<void> updateEmployee() async {
    setState(() => _isSaving = true);

    final employeeId = widget.employee['id'];
    if (employeeId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Missing employee ID')));
      return;
    }

    final url =
        Uri.parse('http://10.0.2.2:8000/api/employees/edit/$employeeId/');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _usernameController.text,
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'email_address': _emailController.text,
        'contact_number': _contactController.text,
        'employee_role': _selectedRole,
        'status': _isActive ? 'active' : 'inactive',
      }),
    );

    setState(() => _isSaving = false);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Employee updated successfully')));
      Navigator.pop(context);
    } else {
      print('Update failed: ${response.body}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update employee')));
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Edit Employee', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : updateEmployee,
            child: Text('Save',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            buildStatusSection(),
            buildEditableDetail('Username', _usernameController),
            buildEditableDetail('First Name', _firstNameController),
            buildEditableDetail('Last Name', _lastNameController),
            buildEditableDetail('Email', _emailController),
            buildEditableDetail('Contact Number', _contactController),
            buildDropdownRole(),
            SizedBox(height: 16),
            Text('PIN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.lock, color: Colors.grey),
                SizedBox(width: 8),
                ...?_pin?.split('').map((digit) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(digit,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio(
              value: true,
              groupValue: _isActive,
              onChanged: (bool? value) => setState(() => _isActive = value!),
              fillColor: MaterialStateProperty.all(Colors.black),
            ),
            Text('Active', style: TextStyle(color: Colors.black)),
            SizedBox(width: 16),
            Radio(
              value: false,
              groupValue: _isActive,
              onChanged: (bool? value) => setState(() => _isActive = value!),
              fillColor: MaterialStateProperty.all(Colors.black),
            ),
            Text('Inactive', style: TextStyle(color: Colors.black)),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildEditableDetail(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildDropdownRole() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Role',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: _selectedRole,
          items: _roles
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
          onChanged: (value) => setState(() => _selectedRole = value),
          decoration: InputDecoration(border: UnderlineInputBorder()),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
