import 'package:flutter/material.dart';
import 'screens/inventory/inventory_main_s.dart'; // Import Inventory screen
import 'screens/employee/employee_main_s.dart'; // Import Employee screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Navbar
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 Button to Navigate to Inventory
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InventoryMainScreen()),
                );
              },
              child: const Text("Inventory"),
            ),
            const SizedBox(height: 16), // Add spacing between buttons

            // 🔹 Button to Navigate to Employee Module
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeMainScreen()),
                );
              },
              child: const Text("Employee"),
            ),
          ],
        ),
      ),
    );
  }
}
