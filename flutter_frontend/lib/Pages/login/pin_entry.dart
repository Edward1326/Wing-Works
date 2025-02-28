import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WingWork PIN Entry',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const PinEntryScreen(),
    );
  }
}

class PinEntryScreen extends StatefulWidget {
  const PinEntryScreen({super.key});

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  String enteredPin = '';

  void _onKeyboardButtonPressed(String value) {
    setState(() {
      if (value == '⌫') {
        if (enteredPin.isNotEmpty) {
          enteredPin = enteredPin.substring(0, enteredPin.length - 1);
        }
      } else if (enteredPin.length < 4) {
        enteredPin += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB51616),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'WingWork',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Management System',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter PIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
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
                  children: [
                    _buildCircularKeyboardButton('1'),
                    _buildCircularKeyboardButton('2'),
                    _buildCircularKeyboardButton('3'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircularKeyboardButton('4'),
                    _buildCircularKeyboardButton('5'),
                    _buildCircularKeyboardButton('6'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircularKeyboardButton('7'),
                    _buildCircularKeyboardButton('8'),
                    _buildCircularKeyboardButton('9'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 80), // Adjust as needed
                    _buildCircularKeyboardButton('0'), // Adjust as needed
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

  Widget _buildCircularKeyboardButton(String value, {Color? backgroundColor}) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () => _onKeyboardButtonPressed(value),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB51616),
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
