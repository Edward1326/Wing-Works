import 'package:flutter/material.dart';
import 'simple_login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Row(
                children: [
                  const Text(
                    'WingsOnWheels',
                    style: TextStyle(
                      color: Color(0xFFB71C1C),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const NavLink(title: 'Home', isActive: true),
                  const NavLink(title: 'Menu'),
                  const NavLink(title: 'Book Us'),
                  const NavLink(title: 'About'),
                  const NavLink(title: 'Contact'),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SimpleLoginPage(
                                      onLoginTap: () {},
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB71C1C),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Serving Flavor, \nAnytime, Anywhere',
                          style: TextStyle(
                            color: Color(0xFFB71C1C),
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'We bring the flavors you love. Time to make every moment unforgettable with Wings on Wheels.',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey[800],
                            side: BorderSide(color: Colors.grey[300]!),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('Show More'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1565123409695-7b5ef63a2efb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Book Us Now',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Most Picked',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Grid of most picked items
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.5,
                    children: const [
                      FoodCard(
                          name: 'Buffalo Blaze', category: 'chicken wings'),
                      FoodCard(name: 'Cajun Butter', category: 'chicken wings'),
                      FoodCard(name: 'BBQ', category: 'fries'),
                      FoodCard(
                          name: 'Garlic Parmesan', category: 'chicken wings'),
                      FoodCard(name: 'Sour Cream', category: 'fries'),
                      FoodCard(name: 'Sour Cream', category: 'fries'),
                    ],
                  ),
                ],
              ),
            ),

            // Our Menu Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Menu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Grid of menu items (2 rows of 4)
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.8,
                    children: const [
                      MenuCard(
                          name: 'Buffalo-Blaze', category: 'Chicken Wings'),
                      MenuCard(name: 'Cajun-Butter', category: 'Chicken Wings'),
                      MenuCard(name: 'Original', category: 'Chicken Wings'),
                      MenuCard(
                          name: 'Garlic Parmesan', category: 'Chicken Wings'),
                      MenuCard(name: 'Salted Egg', category: 'Chicken Wings'),
                      MenuCard(name: 'BBQ', category: 'Fries'),
                      MenuCard(name: 'Sour Cream', category: 'Fries'),
                      MenuCard(name: 'Cheesy', category: 'Fries'),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left footer
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Wings on Wheels',
                          style: TextStyle(
                            color: Color(0xFFB71C1C),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Flavor-packed holidays, instantly unforgettable with Wings on Wheels!',
                          style: TextStyle(
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right footer
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Join Us!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB71C1C),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Register Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Copyright
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: const Color(0xFFB71C1C),
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Copyright 2024 • All rights reserved • Kadiman Faris',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigation link widget
class NavLink extends StatelessWidget {
  final String title;
  final bool isActive;

  const NavLink({
    super.key,
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFFB71C1C) : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// Food card for Most Picked section
class FoodCard extends StatelessWidget {
  final String name;
  final String category;

  const FoodCard({
    super.key,
    required this.name,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Food image
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://images.unsplash.com/photo-1567620832903-9fc6debc209f',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Darkening overlay
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),

        // Text overlay
        Positioned(
          bottom: 15,
          right: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Menu card for Our Menu section
class MenuCard extends StatelessWidget {
  final String name;
  final String category;

  const MenuCard({
    super.key,
    required this.name,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Food image
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://images.unsplash.com/photo-1567620832903-9fc6debc209f',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 10),

        // Menu item name
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        // Menu item category
        Text(
          category,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
