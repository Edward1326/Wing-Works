import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PinEntryScreen extends StatefulWidget {
  final String username;
  const PinEntryScreen({super.key, required this.username});

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  String enteredPin = '';
  final String baseUrl = "http://10.0.2.2:8000/api";

  void _onKeyboardButtonPressed(String value) {
    setState(() {
      if (value == '⌫') {
        if (enteredPin.isNotEmpty) {
          enteredPin = enteredPin.substring(0, enteredPin.length - 1);
        }
      } else if (enteredPin.length < 4) {
        enteredPin += value;
        if (enteredPin.length == 4) {
          _submitPin();
        }
      }
    });
  }

  Future<void> _submitPin() async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify-pin/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': widget.username, 'pin': enteredPin}),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200 && data['authenticated'] == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/createOrder',
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid PIN')),
      );
      setState(() {
        enteredPin = '';
      });
    }
  }

  Widget _buildCircularKeyboardButton(String value, {Color? backgroundColor}) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () => _onKeyboardButtonPressed(value),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFFB51616),
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
        ),
        child: Text(value, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB51616),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('WingWork',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            const Text('Management System',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 20),
            const Text('Enter PIN',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < enteredPin.length
                        ? Colors.white
                        : Colors.white30,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['1', '2', '3']
                        .map(_buildCircularKeyboardButton)
                        .toList()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['4', '5', '6']
                        .map(_buildCircularKeyboardButton)
                        .toList()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['7', '8', '9']
                        .map(_buildCircularKeyboardButton)
                        .toList()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 80),
                    _buildCircularKeyboardButton('0'),
                    _buildCircularKeyboardButton('⌫',
                        backgroundColor: Colors.grey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
