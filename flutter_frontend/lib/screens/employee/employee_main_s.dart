import 'package:flutter/material.dart';
import 'emp_list/emp_list_s.dart'; // Import Employee List screen
import 'emp_roles/emp_roles_s.dart'; // Import Roles screen

class EmployeeMainScreen extends StatefulWidget {
  const EmployeeMainScreen({Key? key}) : super(key: key);

  @override
  _EmployeeMainScreenState createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Module'),
        backgroundColor: Colors.red, // Matches the mockup
      ),
      
      // 🟫 Side Navigation Drawer (DASHBOARD BUTTONS)
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFFFE8E0), // 🎨 Modify drawer background color
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.red), // 🟥 Modify header color
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white, // ⚪ Modify header text color
                      fontSize: 22, // 📝 Modify text size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // 📂 Dashboard Navigation Items (Main Sections)
              _buildDrawerItem(Icons.inventory, "Inventory", context, PlaceholderScreen("Inventory")),
              _buildDrawerItem(Icons.point_of_sale, "POS", context, PlaceholderScreen("POS")),
              _buildDrawerItem(Icons.shopping_cart, "Ordering", context, PlaceholderScreen("Ordering")),
              _buildDrawerItem(Icons.calendar_today, "Booking", context, PlaceholderScreen("Booking")),
              _buildDrawerItem(Icons.attach_money, "Financial", context, PlaceholderScreen("Financial")),
              _buildDrawerItem(Icons.people, "Employee", context, const EmployeeMainScreen()), // Navigate to Employee Main
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Employee List Button
            ListTile(
              leading: const Icon(Icons.list), // Icon for Employee List
              title: const Text('Employee List'),
              onTap: () {
                // Navigate to Employee List screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmployeeListScreen(),
                  ),
                );
              },
            ),
            const Divider(), // Adds a separator

            // Roles Button
            ListTile(
              leading: const Icon(Icons.apartment), // Icon for Roles
              title: const Text('Roles'),
              onTap: () {
                // Navigate to Roles screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmployeeRolesScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Function to Create a Drawer Item (DASHBOARD NAVIGATION)
  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, Widget screen) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black, size: 24), // 🎨 Modify icon color & size
          title: Text(title, style: const TextStyle(fontSize: 16)), // 📝 Modify text size
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
          },
        ),
        const Divider(height: 1, thickness: 1, color: Colors.black38), // 🔳 Modify separator color
      ],
    );
  }
}

// 📌 Placeholder Screen for Dashboard Navigation (Replace with actual screens later)
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.red),
      body: Center(child: Text('$title Screen')),
    );
  }
}
