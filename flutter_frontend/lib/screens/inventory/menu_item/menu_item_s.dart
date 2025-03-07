import 'package:flutter/material.dart';

class MenuItemScreen extends StatefulWidget {
  const MenuItemScreen({super.key});

  @override
  _MenuItemScreenState createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  String _selectedCategory = 'Category';
  bool _isActive = true;
  final List<String> _categories = ['Category', 'Beverages', 'Food'];

  List<Map<String, dynamic>> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  void _loadMenuItems() {
    setState(() {
      _menuItems = _menuItems.where((item) {
        bool matchesActiveStatus = item['active'] == _isActive;
        bool matchesCategory = _selectedCategory == 'Category' ||
            item['category'] == _selectedCategory;
        return matchesActiveStatus && matchesCategory;
      }).toList();
    });
  }

  void _addMenuItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Create text controllers
        final TextEditingController nameController = TextEditingController();
        final TextEditingController qtyController = TextEditingController();
        String selectedCategory = 'Beverages';
        Color selectedColor = Colors.blue;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Menu Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantity'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: ['Beverages', 'Food']
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        qtyController.text.isNotEmpty) {
                      final newItem = {
                        'id': _menuItems.length + 1,
                        'name': nameController.text,
                        'color': selectedColor,
                        'category': selectedCategory,
                        'qty': int.parse(qtyController.text),
                        'active': true
                      };

                      setState(() {
                        _menuItems.add(newItem);
                        _loadMenuItems();
                      });

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 151, 27, 18),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Text('Menu Items', style: TextStyle(color: Colors.white)),
            SizedBox(width: 10),
            DropdownButton<String>(
              value: _selectedCategory,
              dropdownColor: Colors.white,
              underline: Container(),
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              style: TextStyle(color: Colors.white),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _loadMenuItems();
                });
              },
            ),
          ],
        ),
        actions: [
          // Active/Inactive radio buttons
          Row(
            children: [
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _isActive,
                    onChanged: (bool? value) {
                      setState(() {
                        _isActive = value!;
                        _loadMenuItems();
                      });
                    },
                    fillColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  Text('Active',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: _isActive,
                    onChanged: (bool? value) {
                      setState(() {
                        _isActive = value!;
                        _loadMenuItems();
                      });
                    },
                    fillColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  Text('Inactive',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE8E0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: _menuItems.isEmpty
                      ? Center(child: Text('No items found'))
                      : ListView.builder(
                          itemCount: _menuItems.length,
                          itemBuilder: (context, index) {
                            var item = _menuItems[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: Container(
                                    width: 20,
                                    height: 20,
                                    color: item['color'],
                                  ),
                                  title: Text(item['name']),
                                  subtitle: Text('Qty: ${item['qty']}'),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: _addMenuItem,
                backgroundColor: Colors.green,
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
