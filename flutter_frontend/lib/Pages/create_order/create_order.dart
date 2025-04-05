import 'package:flutter/material.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          "Create Order",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: buildDrawer(context),
      body: const Placeholder(),
    );
  }
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      color: const Color(0xFFB71C1C),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB71C1C),
            ),
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(context, Icons.add_circle_outline, 'Create Order',
              '/createOrder'),
          _buildDrawerItem(
              context, Icons.receipt_outlined, 'Orders', '/orders'),
          _buildDrawerItem(
              context, Icons.inventory_2_outlined, 'Inventory', '/inventory'),
          _buildDrawerItem(
              context, Icons.show_chart, 'Financial', '/financial'),
          _buildDrawerItem(
              context, Icons.local_shipping_outlined, 'Booking', '/booking'),
          _buildDrawerItem(
              context, Icons.people_outline, 'Employee', '/employee'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.logout, color: Colors.black),
              label: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: Color(0xFFB71C1C),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDrawerItem(
    BuildContext context, IconData icon, String title, String route) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    onTap: () {
      Navigator.pushNamed(context, route);
    },
  );
}
