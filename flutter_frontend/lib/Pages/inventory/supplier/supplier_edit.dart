import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditSupplierScreen extends StatefulWidget {
  final Map<String, dynamic> supplier;

  EditSupplierScreen({required this.supplier});

  @override
  _EditSupplierScreenState createState() => _EditSupplierScreenState();
}

class _EditSupplierScreenState extends State<EditSupplierScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController contactController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.supplier['name']);
    emailController = TextEditingController(text: widget.supplier['email']);
    contactController = TextEditingController(text: widget.supplier['contact']);
  }

  Future<void> updateSupplier() async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/api/suppliers/edit/${widget.supplier['id']}/');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'supplier_name': nameController.text,
        'email_address': emailController.text,
        'contact_number': contactController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context); // Go back to the view screen
    } else {
      print("Failed to update supplier: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Supplier")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Supplier Name"),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email Address"),
            ),
            TextFormField(
              controller: contactController,
              decoration: InputDecoration(labelText: "Contact Number"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateSupplier,
              child: Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}
