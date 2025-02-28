import 'package:flutter/material.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Map<String, String> employee;

  EditEmployeeScreen({required this.employee});

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _roleController;
  late TextEditingController _pinController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.employee['username']);
    _nameController = TextEditingController(text: widget.employee['name']);
    _emailController = TextEditingController(text: widget.employee['email']);
    _contactController =
        TextEditingController(text: widget.employee['contact']);
    _roleController = TextEditingController(text: widget.employee['role']);
    _pinController = TextEditingController(text: widget.employee['pin']);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _roleController.dispose();
    _pinController.dispose();
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
            onPressed: () {
              Navigator.pop(context);
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
            buildStatusSection(),
            buildEditableDetail('Username', _usernameController),
            buildEditableDetail('Name', _nameController),
            buildEditableDetail('Email', _emailController),
            buildEditableDetail('Contact Number', _contactController),
            buildEditableDetail('Role', _roleController),
            SizedBox(height: 16),
            Text('PIN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.lock, color: Colors.grey),
                SizedBox(width: 8),
                ..._pinController.text.split('').map((digit) => Padding(
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
                  fillColor: WidgetStatePropertyAll(Colors.black),
                ),
                Text('Active',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
            SizedBox(width: 16), // Adds spacing between the options
            Row(
              children: [
                Radio(
                  value: false,
                  groupValue: _isActive,
                  onChanged: (bool? value) {
                    setState(() {
                      _isActive = value!;
                    });
                  },
                  fillColor: WidgetStatePropertyAll(Colors.black),
                ),
                Text('Inactive',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16), // Adds spacing before next section
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
}
