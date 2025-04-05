import 'package:flutter/material.dart';

class EditIngredientScreen extends StatelessWidget {
  final int ingredientId;

  const EditIngredientScreen({super.key, required this.ingredientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        title: const Text("Edit Ingredient",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text("Edit Ingredient ID: $ingredientId"),
      ),
    );
  }
}
