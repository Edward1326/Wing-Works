import 'package:flutter/material.dart';

// 🛒 Request Purchase Order Screen - Allows users to request stock orders
class ReqPosScreen extends StatelessWidget {
  const ReqPosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request Purchase Order")),
      body: Center(child: Text("Request Purchase Order Screen")),
    );
  }
}
