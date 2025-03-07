import 'package:flutter/material.dart';
import 'menu_item/menu_item_s.dart';
import 'ingredients/ingredients_s.dart';
import 'inv_categories/inv_categories_s.dart';
import 'req_pos/req_pos_s.dart';

class InventoryMainScreen extends StatelessWidget {
  const InventoryMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No new notifications")),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
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
              _buildDrawerItem(
                icon: Icons.add_circle_outline,
                title: 'Create Order',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Create Order screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.receipt_outlined,
                title: 'Orders',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Orders screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.inventory_2_outlined,
                title: 'Inventory',
                onTap: () {
                  Navigator.pop(context);
                  // Already on inventory screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.show_chart,
                title: 'Financial',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Financial screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.local_shipping_outlined,
                title: 'Booking',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Booking screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.people_outline,
                title: 'Employee',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Employee screen
                },
              ),
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
                  onPressed: () {
                    // TODO: Implement logout functionality
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFFFF1F1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInventoryButton(
              icon: Icons.list,
              label: 'Menu Items',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuItemScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _buildInventoryButton(
              icon: Icons.inventory,
              label: 'Ingredients',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IngredientsScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _buildInventoryButton(
              icon: Icons.grid_view,
              label: 'Categories',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InvCategoriesScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _buildInventoryButton(
              icon: Icons.shopping_cart,
              label: 'Request Purchase Order',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReqPosScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildInventoryButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
