import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/employee/employee_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmployeeScreen(),
    );
  }
}

class CreateEmployeeScreen extends StatefulWidget {
  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Create Employee', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Save',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Username', _usernameController),
            _buildTextField('Name', _nameController),
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
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
          ),
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
          items: ['Admin', 'Staff', 'Manager']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPinDisplay() {
    return Row(
      children: [
        Icon(Icons.lock, size: 32, color: Colors.grey),
        SizedBox(width: 10),
        Text(
          '5  3  4  9',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }
}
