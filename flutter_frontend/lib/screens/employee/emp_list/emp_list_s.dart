import 'package:flutter/material.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          'Employee List Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
