import 'package:flutter/material.dart';
import 'menu_item/menu_item_s.dart'; // Import Menu Items screen
import 'ingredients/ingredients_s.dart'; // Import Ingredients screen
import 'inv_categories/inv_categories_s.dart'; // Import Categories screen
import 'req_po/req_po_s.dart'; // Import Request Purchase Order screen
import 'supplier/inv_supl_s.dart'; // Import Supplier screen

// 🏠 Inventory Main Screen - Users navigate between Inventory functionalities.
class InventoryMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🟥 Top Navigation Bar
      appBar: AppBar(
        backgroundColor: Colors.red, // 🎨 Modify navbar color
        title: Text(
          "Inventory",
          style: TextStyle(color: Colors.white), // 🎨 Modify title text color
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu,
                color: Colors.white), // 🍔 Modify menu icon color
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,
                color: Colors.white), // 🔔 Modify notification icon color
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No new notifications")),
              );
            },
          ),
        ],
      ),

      // 🟫 Side Navigation Drawer (DASHBOARD BUTTONS)
      drawer: Drawer(
        child: Container(
          color: Color(0xFFFFE8E0), // 🎨 Modify drawer background color
          child: Column(
            children: [
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Colors.red), // 🟥 Modify header color
                child: Align(
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
              _buildDrawerItem(Icons.inventory, "Inventory", context,
                  PlaceholderScreen("Inventory")),
              _buildDrawerItem(Icons.point_of_sale, "POS", context,
                  PlaceholderScreen("POS")),
              _buildDrawerItem(Icons.shopping_cart, "Ordering", context,
                  PlaceholderScreen("Ordering")),
              _buildDrawerItem(Icons.calendar_today, "Booking", context,
                  PlaceholderScreen("Booking")),
              _buildDrawerItem(Icons.attach_money, "Financial", context,
                  PlaceholderScreen("Financial")),
              _buildDrawerItem(Icons.people, "Employee", context,
                  PlaceholderScreen("Employee")),
            ],
          ),
        ),
      ),

      // 🎨 Full-Screen Background & Left-Aligned Buttons (INVENTORY NAVIGATION BUTTONS)
      body: SizedBox.expand(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFFFE8E0), // 🎨 Modify background color here
          padding: EdgeInsets.only(
              left: 20, top: 40), // 📏 Modify padding for alignment
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns buttons to the left
            children: [
              _buildNavButton(
                  Icons.list, "Menu Items", context, MenuItemScreen()),
              _buildNavButton(
                  Icons.inventory, "Ingredients", context, IngredientsScreen()),
              _buildNavButton(Icons.grid_view, "Categories", context,
                  InvCategoriesScreen()),
              _buildNavButton(Icons.shopping_cart, "Request Purchase Order",
                  context, ReqPOScreen()),
              _buildNavButton(
                  Icons.shopping_cart, "Supplier", context, SupplierScreen()),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Function to Create a Drawer Item (DASHBOARD NAVIGATION)
  Widget _buildDrawerItem(
      IconData icon, String title, BuildContext context, Widget screen) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon,
              color: Colors.black, size: 24), // 🎨 Modify icon color & size
          title: Text(title,
              style: TextStyle(fontSize: 16)), // 📝 Modify text size
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
        ),
        Divider(
            height: 1,
            thickness: 1,
            color: Colors.black38), // 🔳 Modify separator color
      ],
    );
  }

  // 🔹 Function to Create a Left-Aligned Navigation Button (INVENTORY PAGE BUTTONS)
  Widget _buildNavButton(
      IconData icon, String title, BuildContext context, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0), // 📏 Modify spacing between buttons
      child: SizedBox(
        width: 280, // 📏 Modify button width
        height: 60, // 📏 Modify button height
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // 🎨 Modify button background color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // 🔲 Modify button corner radius
            ),
            elevation: 2, // 🔳 Modify button shadow effect
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // 📏 Aligns button content to the left
            children: [
              Icon(icon,
                  color: Colors.black, size: 28), // 🎨 Modify icon size & color
              SizedBox(width: 15), // 📏 Modify spacing between icon & text
              Text(
                title,
                style: TextStyle(
                  fontSize: 18, // 📝 Modify text size
                  color: Colors.black, // 🎨 Modify text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📝 Temporary Placeholder Screen - Replace when real screens are created
class PlaceholderScreen extends StatelessWidget {
  final String title;
  PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("$title Screen (Coming Soon)")),
    );
  }
}
