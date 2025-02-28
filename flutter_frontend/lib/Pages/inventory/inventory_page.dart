import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InventoryScreen(),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Color(0xFFB51616),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFB51616),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFFFE5E5), // Light pink background color
        child: ListView(
          children: const [
            InventoryTile(
              icon: Icons.list,
              title: 'Menu Items',
            ),
            InventoryTile(
              icon: Icons.kitchen,
              title: 'Ingredients',
            ),
            InventoryTile(
              icon: Icons.category,
              title: 'Categories',
            ),
            InventoryTile(
              icon: Icons.local_offer,
              title: 'Request Purchase Order',
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const InventoryTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24.0, color: Colors.black),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
