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
        backgroundColor: const Color.fromARGB(255, 151, 27, 18),
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No new notifications")),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFFFE8E0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 151, 27, 18),
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
                icon: Icons.inventory_2,
                title: 'Inventory',
                onTap: () {
                  Navigator.pop(context);
                  // Already on inventory screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.point_of_sale,
                title: 'POS',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to POS screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.shopping_cart,
                title: 'Ordering',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Ordering screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.calendar_today,
                title: 'Booking',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Booking screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.attach_money,
                title: 'Financial',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Financial screen
                },
              ),
              _buildDrawerItem(
                icon: Icons.people,
                title: 'Employee',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Employee screen
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFFFE8E0),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInventoryButton(
              icon: Icons.list,
              label: 'Menu Items',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuItemScreen()),
              ),
            ),
            SizedBox(height: 12),
            _buildInventoryButton(
              icon: Icons.inventory,
              label: 'Ingredients',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IngredientsScreen()),
              ),
            ),
            SizedBox(height: 12),
            _buildInventoryButton(
              icon: Icons.grid_view,
              label: 'Categories',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvCategoriesScreen()),
              ),
            ),
            SizedBox(height: 12),
            _buildInventoryButton(
              icon: Icons.shopping_cart,
              label: 'Request Purchase Order',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReqPosScreen()),
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
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      tileColor: Colors.transparent,
      textColor: Colors.black,
      iconColor: Colors.black,
    );
  }

  Widget _buildInventoryButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
