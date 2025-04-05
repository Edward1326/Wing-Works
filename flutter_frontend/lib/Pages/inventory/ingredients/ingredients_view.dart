import 'package:flutter/material.dart';

class ViewIngredientScreen extends StatelessWidget {
  final String ingredientId;
  final String name;
  final String quantity;
  final String unit;

  const ViewIngredientScreen({
    super.key,
    required this.ingredientId,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        title: const Text("View Ingredient",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text("Viewing Ingredient: $name"),
      ),
    );
  }
}
