import 'package:flutter/material.dart';

class FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  const FormField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
            ),
          ),
        ],
      ),
    );
  }
}
