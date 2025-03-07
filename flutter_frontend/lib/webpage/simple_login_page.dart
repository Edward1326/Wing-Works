import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class SimpleLoginPage extends StatelessWidget {
  final VoidCallback onLoginTap;

  const SimpleLoginPage({
    super.key,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFB71C1C),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'WingWork',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Management System',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),

              // Username field
              SizedBox(
                width: 400,
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login button
              SizedBox(
                width: 400,
                child: OutlinedButton(
                  onPressed: () {
                    // If username is entered, go directly to dashboard
                    if (usernameController.text.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DashboardPage(username: usernameController.text),
                        ),
                      );
                    } else {
                      // Otherwise go to login form
                      onLoginTap();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Added Register link
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  // Navigate to Create Account page
                  Navigator.pushNamed(context, '/create-account');
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
