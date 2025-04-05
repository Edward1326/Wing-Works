import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateSupplierScreen extends StatefulWidget {
  @override
  _CreateSupplierScreenState createState() => _CreateSupplierScreenState();
}

class _CreateSupplierScreenState extends State<CreateSupplierScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();

  Future<void> createSupplier() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/suppliers/create/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'supplier_name': nameController.text,
        'email_address': emailController.text,
        'contact_number': contactController.text,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      print("Failed to create supplier: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Supplier")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                onPressed: createSupplier,
                child: Text("Create"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
