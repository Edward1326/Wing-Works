import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/create_order/create_order.dart';
import 'package:flutter_frontend/pages/inventory/categories/categories_list.dart';
import 'package:flutter_frontend/pages/inventory/ingredients/ingredients_list.dart';
import 'package:flutter_frontend/pages/inventory/menu_items/menu_item.dart';
import 'package:flutter_frontend/pages/inventory/request_po/request_po_list.dart';
import 'package:flutter_frontend/pages/inventory/supplier/supplier_list.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        title: const Text(
          "Inventory",
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
      drawer: buildDrawer(context),
      body: Container(
        color: const Color(0xFFFFF1F1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInventoryButton(
                icon: Icons.list,
                label: 'Menu Items',
                onPressed: () => _navigateTo(context, MenuItemScreen())),
            const SizedBox(height: 12),
            _buildInventoryButton(
                icon: Icons.inventory,
                label: 'Ingredients',
                onPressed: () => _navigateTo(context, IngredientsScreen())),
            const SizedBox(height: 12),
            _buildInventoryButton(
                icon: Icons.grid_view,
                label: 'Categories',
                onPressed: () => _navigateTo(context, InvCategoriesScreen())),
            const SizedBox(height: 12),
            _buildInventoryButton(
                icon: Icons.list,
                label: 'Supplier',
                onPressed: () => _navigateTo(context, ListSupplierScreen())),
            _buildInventoryButton(
                icon: Icons.shopping_cart,
                label: 'Request Purchase Order',
                onPressed: () => _navigateTo(context, ReqPosScreen())),
            const SizedBox(height: 12),
          ],
        ),
      ),
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

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
