import 'package:flutter/material.dart';
import '../inventory_main_s.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _showPinInput = false;

  void _handleNumberPress(String number) {
    if (_pinController.text.length < 4) {
      setState(() {
        _pinController.text += number;
      });

      // Check if PIN is complete (4 digits)
      if (_pinController.text.length == 4) {
        // TODO: Add your PIN verification logic here
        // For now, just navigate to inventory screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const InventoryMainScreen()),
        );
      }
    }
  }

  void _handleBackspace() {
    if (_pinController.text.isNotEmpty) {
      setState(() {
        _pinController.text = _pinController.text.substring(
          0,
          _pinController.text.length - 1,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side - Username Login
          Expanded(
            child: Container(
              color: const Color(0xFFB71C1C),
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'WingWork\nManagement System',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_usernameController.text.isNotEmpty) {
                        setState(() {
                          _showPinInput = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFFB71C1C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right side - PIN Input
          if (_showPinInput)
            Expanded(
              child: Container(
                color: const Color(0xFFB71C1C),
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'WingWork\nManagement System',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Enter PIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index < _pinController.text.length
                                ? Colors.white
                                : Colors.white38,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Number pad
                    ...List.generate(
                      3,
                      (row) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (col) => _buildNumberButton(
                              (row * 3 + col + 1).toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Last row with 0 and backspace
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNumberButton('0'),
                        IconButton(
                          onPressed: _handleBackspace,
                          icon: const Icon(
                            Icons.backspace_outlined,
                            color: Colors.white,
                          ),
                          iconSize: 32,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () => _handleNumberPress(number),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 24),
        ),
        child: Text(number),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
