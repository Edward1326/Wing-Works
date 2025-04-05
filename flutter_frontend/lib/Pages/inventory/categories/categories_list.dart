import 'package:flutter/material.dart';

// 🏷️ Categories Screen - Displays inventory categories
class InvCategoriesScreen extends StatelessWidget {
  const InvCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: Center(child: Text("Categories Screen")),
    );
  }
}
