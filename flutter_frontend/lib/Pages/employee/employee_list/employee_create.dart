import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateEmployeeScreen extends StatefulWidget {
  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  String? _selectedRole;
  List<String> _roles = [];
  String? _generatedPin;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/roles/list/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _roles = data.map((role) => role['role_name'].toString()).toList();
        });
      } else {
        print("Failed to fetch roles: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load roles")),
        );
      }
    } catch (e) {
      print("Error fetching roles: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading roles")),
      );
    }
  }

  Future<void> _createEmployee() async {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a role")),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final url = Uri.parse('http://10.0.2.2:8000/api/employees/create/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _usernameController.text,
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'email_address': _emailController.text.trim(),
        'contact_number': _contactController.text.trim(),
        'employee_role': _selectedRole,
      }),
    );

    setState(() {
      _isSaving = false;
    });

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      setState(() {
        _generatedPin = data['pin'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Employee created. PIN: ${data['pin']}")),
      );
    } else {
      final error = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create Employee', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _createEmployee,
            child: Text('Save',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('Username', _usernameController),
            _buildTextField('First Name', _firstNameController),
            _buildTextField('Last Name', _lastNameController),
            _buildTextField('Email', _emailController),
            _buildTextField('Contact Number', _contactController),
            _buildDropdownField(),
            SizedBox(height: 20),
            _buildPinDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        TextField(
          controller: controller,
          decoration: InputDecoration(border: UnderlineInputBorder()),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Role', style: TextStyle(fontSize: 16)),
        DropdownButtonFormField<String>(
          value: _selectedRole,
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue;
            });
          },
          items: _roles.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(border: UnderlineInputBorder()),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPinDisplay() {
    String pinDisplay = _generatedPin != null
        ? _generatedPin!.split('').join('  ')
        : "-  -  -  -";
    return Row(
      children: [
        Icon(Icons.lock, size: 32, color: Colors.grey),
        SizedBox(width: 10),
        Text(
          pinDisplay,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
