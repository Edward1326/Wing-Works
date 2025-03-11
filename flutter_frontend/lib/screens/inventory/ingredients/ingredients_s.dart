import 'package:flutter/material.dart';

class Ingredient {
  final int? id; // Backend ID for the ingredient
  final String name;
  String stock;
  String expiryDate;
  String minimumStockLevel;
  bool isStockLow;
  bool isNearExpiry;
  bool isActive;

  Ingredient({
    this.id,
    required this.name,
    required this.stock,
    required this.expiryDate,
    required this.minimumStockLevel,
    this.isStockLow = false,
    this.isNearExpiry = false,
    this.isActive = true,
  });

  // Convert from JSON (for receiving from API)
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    // Calculate if stock is low by comparing current stock with minimum stock level
    bool isLow = false;
    if (json['stock'] != null && json['minimum_stock_level'] != null) {
      // This is a simple comparison - you might need more complex logic
      // depending on your units (g, ml, pcs, etc.)
      isLow = json['stock']
              .toString()
              .compareTo(json['minimum_stock_level'].toString()) <=
          0;
    }

    // Calculate if near expiry (for example, if expiry date is within 30 days)
    bool nearExpiry = false;
    if (json['expiry_date'] != null) {
      try {
        final parts = json['expiry_date'].toString().split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse('20${parts[2]}'); // Assuming format DD/MM/YY

          final expiryDate = DateTime(year, month, day);
          final now = DateTime.now();
          final difference = expiryDate.difference(now).inDays;
          nearExpiry =
              difference <= 30; // Mark as near expiry if within 30 days
        }
      } catch (e) {
        print('Error parsing date: $e');
      }
    }

    return Ingredient(
      id: json['id'],
      name: json['name'] ?? '',
      stock: json['stock']?.toString() ?? '',
      expiryDate: json['expiry_date'] ?? '',
      minimumStockLevel: json['minimum_stock_level']?.toString() ?? '',
      isStockLow: isLow,
      isNearExpiry: nearExpiry,
      isActive: json['is_active'] ?? true,
    );
  }

  // Convert to JSON (for sending to API)
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'stock': stock,
      'expiry_date': expiryDate,
      'minimum_stock_level': minimumStockLevel,
      'is_active': isActive,
    };
  }
}

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  bool _showActive = true;
  final TextEditingController _searchController = TextEditingController();
  List<Ingredient> _allIngredients = [];
  List<Ingredient> _filteredIngredients = [];

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    // This would be replaced with actual API call to Django backend
    // For example:
    // final response = await http.get(Uri.parse('https://your-django-api.com/ingredients/'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body);
    //   _allIngredients = data.map((json) => Ingredient.fromJson(json)).toList();
    // }

    // mock data
  }

  void _filterIngredients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredIngredients = _allIngredients.where((ingredient) {
        final matchesQuery = ingredient.name.toLowerCase().contains(query);
        final matchesStatus =
            _showActive ? ingredient.isActive : !ingredient.isActive;
        return matchesQuery && matchesStatus;
      }).toList();
    });
  }

  void _toggleActiveStatus(bool value) {
    setState(() {
      _showActive = value;
      _filterIngredients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        title: const Text(
          "Ingredients",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _IngredientSearchDelegate(
                  allIngredients: _allIngredients,
                  isActiveFilter: _showActive,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFB71C1C),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Active",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Radio<bool>(
                  value: true,
                  groupValue: _showActive,
                  onChanged: (value) => _toggleActiveStatus(true),
                  activeColor: Colors.white,
                ),
                const SizedBox(width: 20),
                const Text(
                  "Inactive",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Radio<bool>(
                  value: false,
                  groupValue: _showActive,
                  onChanged: (value) => _toggleActiveStatus(false),
                  activeColor: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFFFF1F1),
              child: ListView.builder(
                itemCount: _filteredIngredients.length,
                itemBuilder: (context, index) {
                  final ingredient = _filteredIngredients[index];
                  return _buildIngredientItem(ingredient);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // TODO: Add new ingredient functionality
          _showAddIngredientDialog();
        },
      ),
    );
  }

  Widget _buildIngredientItem(Ingredient ingredient) {
    return GestureDetector(
      onTap: () => _showEditIngredientDialog(ingredient),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ingredient.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () => _showEditIngredientDialog(ingredient),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Stock",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ingredient.isStockLow
                                ? Colors.red
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            ingredient.stock,
                            style: TextStyle(
                              fontSize: 16,
                              color: ingredient.isStockLow
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Expiry Date",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ingredient.isNearExpiry
                                ? Colors.red
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            ingredient.expiryDate,
                            style: TextStyle(
                              fontSize: 16,
                              color: ingredient.isNearExpiry
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Minimum Stock Level",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            ingredient.minimumStockLevel,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditIngredientDialog(Ingredient ingredient) {
    final nameController = TextEditingController(text: ingredient.name);
    final stockController = TextEditingController(text: ingredient.stock);
    final expiryDateController =
        TextEditingController(text: ingredient.expiryDate);
    final minimumStockController =
        TextEditingController(text: ingredient.minimumStockLevel);
    bool isActive = ingredient.isActive;

    // Date picker helper function
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      );
      if (picked != null) {
        // Format as dd/mm/yy
        final day = picked.day.toString().padLeft(2, '0');
        final month = picked.month.toString().padLeft(2, '0');
        final year = picked.year.toString().substring(2);
        expiryDateController.text = '$day/$month/$year';
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Edit ${ingredient.name}"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: stockController,
                      decoration: const InputDecoration(
                        labelText: "Stock (e.g., 100g, 5pcs)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: expiryDateController,
                          decoration: const InputDecoration(
                            labelText: "Expiry Date (dd/mm/yy)",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: minimumStockController,
                      decoration: const InputDecoration(
                        labelText: "Minimum Stock Level",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text("Status:"),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Active'),
                          selected: isActive,
                          onSelected: (selected) {
                            setState(() {
                              isActive = selected;
                            });
                          },
                          selectedColor: Colors.green.shade100,
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Inactive'),
                          selected: !isActive,
                          onSelected: (selected) {
                            setState(() {
                              isActive = !selected;
                            });
                          },
                          selectedColor: Colors.red.shade100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        stockController.text.isNotEmpty &&
                        expiryDateController.text.isNotEmpty &&
                        minimumStockController.text.isNotEmpty) {
                      // Update ingredient properties
                      ingredient.stock = stockController.text;
                      ingredient.expiryDate = expiryDateController.text;
                      ingredient.minimumStockLevel =
                          minimumStockController.text;
                      ingredient.isActive = isActive;

                      // Recalculate flags
                      ingredient.isStockLow = _isStockLow(
                          stockController.text, minimumStockController.text);
                      ingredient.isNearExpiry =
                          _isNearExpiry(expiryDateController.text);

                      // In a real app, you would send this to your Django backend
                      // Example:
                      // final response = await http.put(
                      //   Uri.parse('https://your-django-api.com/ingredients/${ingredient.id}/'),
                      //   headers: {'Content-Type': 'application/json'},
                      //   body: json.encode(ingredient.toJson()),
                      // );
                      // if (response.statusCode == 200) {
                      //   // Successfully updated
                      //   setState(() {
                      //     _filterIngredients();
                      //   });
                      // }

                      // For now, just update our UI
                      setState(() {
                        _filterIngredients();
                      });

                      Navigator.of(context).pop();
                    } else {
                      // Show validation error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all fields"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddIngredientDialog() {
    final nameController = TextEditingController();
    final stockController = TextEditingController();
    final expiryDateController =
        TextEditingController(text: '01/01/25'); // Default date
    final minimumStockController = TextEditingController();

    // Date picker helper function
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      );
      if (picked != null) {
        // Format as dd/mm/yy
        final day = picked.day.toString().padLeft(2, '0');
        final month = picked.month.toString().padLeft(2, '0');
        final year = picked.year.toString().substring(2);
        expiryDateController.text = '$day/$month/$year';
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Ingredient"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(
                    labelText: "Stock (e.g., 100g, 5pcs)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: expiryDateController,
                      decoration: const InputDecoration(
                        labelText: "Expiry Date (dd/mm/yy)",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: minimumStockController,
                  decoration: const InputDecoration(
                    labelText: "Minimum Stock Level",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    stockController.text.isNotEmpty &&
                    expiryDateController.text.isNotEmpty &&
                    minimumStockController.text.isNotEmpty) {
                  final newIngredient = Ingredient(
                    name: nameController.text,
                    stock: stockController.text,
                    expiryDate: expiryDateController.text,
                    minimumStockLevel: minimumStockController.text,
                    isStockLow: _isStockLow(
                        stockController.text, minimumStockController.text),
                    isNearExpiry: _isNearExpiry(expiryDateController.text),
                  );

                  // In a real app, you would send this to your Django backend
                  // Example:
                  // final response = await http.post(
                  //   Uri.parse('https://your-django-api.com/ingredients/'),
                  //   headers: {'Content-Type': 'application/json'},
                  //   body: json.encode(newIngredient.toJson()),
                  // );
                  // if (response.statusCode == 201) {
                  //   // Successfully created
                  //   final createdIngredient = Ingredient.fromJson(json.decode(response.body));
                  //   setState(() {
                  //     _allIngredients.add(createdIngredient);
                  //     _filterIngredients();
                  //   });
                  // }

                  // For now, just add to our local list
                  setState(() {
                    _allIngredients.add(newIngredient);
                    _filterIngredients();
                  });

                  Navigator.of(context).pop();
                } else {
                  // Show validation error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Helper method to determine if stock is low
  bool _isStockLow(String stock, String minimumStock) {
    // This is a simple string comparison - in a real app you'd parse quantities
    // and compare them properly based on units
    try {
      // Extract numeric values for comparison
      final stockNum = double.parse(stock.replaceAll(RegExp(r'[^0-9.]'), ''));
      final minStockNum =
          double.parse(minimumStock.replaceAll(RegExp(r'[^0-9.]'), ''));
      return stockNum <= minStockNum;
    } catch (e) {
      // If parsing fails, fall back to string comparison
      return stock.compareTo(minimumStock) <= 0;
    }
  }

  // Helper method to determine if an item is near expiry
  bool _isNearExpiry(String expiryDateStr) {
    try {
      final parts = expiryDateStr.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse('20${parts[2]}'); // Assuming format DD/MM/YY

        final expiryDate = DateTime(year, month, day);
        final now = DateTime.now();
        final difference = expiryDate.difference(now).inDays;
        return difference <= 30; // Mark as near expiry if within 30 days
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
    return false;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _IngredientSearchDelegate extends SearchDelegate<Ingredient?> {
  final List<Ingredient> allIngredients;
  final bool isActiveFilter;

  _IngredientSearchDelegate({
    required this.allIngredients,
    required this.isActiveFilter,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredIngredients = allIngredients
        .where((ingredient) =>
            ingredient.name.toLowerCase().contains(query.toLowerCase()) &&
            ingredient.isActive == isActiveFilter)
        .toList();

    return Container(
      color: const Color(0xFFFFF1F1),
      child: ListView.builder(
        itemCount: filteredIngredients.length,
        itemBuilder: (context, index) {
          final ingredient = filteredIngredients[index];
          return ListTile(
            title: Text(ingredient.name),
            subtitle: Text("Stock: ${ingredient.stock}"),
            onTap: () {
              close(context, ingredient);
            },
          );
        },
      ),
    );
  }
}
