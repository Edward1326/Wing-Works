import 'package:flutter/material.dart';

class EmployeeRolesScreen extends StatelessWidget {
  const EmployeeRolesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles'),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          'Roles Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
