import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum UnitType {
  grams,
  milliliters,
  piece
}

class Ingredient {
  final String name;
  final String stock;
  final UnitType unitType;
  final String expiryDate;
  final String minimumStockLevel;
  final bool isStockLow;
  final bool isNearExpiry;
  final bool isActive;
  final bool hasSupplier;
  final String? supplierName;
  final String? contactNumber;
  final String? emailAddress;
  final double? pricePerUnit;

  Ingredient({
    required this.name,
    required this.stock,
    required this.unitType,
    required this.expiryDate,
    required this.minimumStockLevel,
    this.isStockLow = false,
    this.isNearExpiry = false,
    this.isActive = true,
    this.hasSupplier = false,
    this.supplierName,
    this.contactNumber,
    this.emailAddress,
    this.pricePerUnit,
  });
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

  void _loadIngredients() {
    // In a real app, this would come from an API or database
    _allIngredients = [
      Ingredient(
        name: "Chicken",
        stock: "100g",
        unitType: UnitType.grams,
        expiryDate: "01/01/25",
        minimumStockLevel: "100g",
        isStockLow: true,
        hasSupplier: true,
        supplierName: "Magnolia",
        contactNumber: "0927 867 6107",
        emailAddress: "Example@gmail.com",
        pricePerUnit: 10.00,
      ),
      Ingredient(
        name: "Onion",
        stock: "10pcs",
        unitType: UnitType.piece,
        expiryDate: "01/01/25",
        minimumStockLevel: "2pcs",
        hasSupplier: false,
      ),
      Ingredient(
        name: "Soy Sauce",
        stock: "500ml",
        unitType: UnitType.milliliters,
        expiryDate: "01/01/25",
        minimumStockLevel: "100ml",
        isNearExpiry: true,
        hasSupplier: false,
      ),
      // Add more ingredients as needed
    ];

    _filterIngredients();
  }

  void _filterIngredients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredIngredients = _allIngredients.where((ingredient) {
        final matchesQuery = ingredient.name.toLowerCase().contains(query);
        final matchesStatus = _showActive ? ingredient.isActive : !ingredient.isActive;
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
          _showAddIngredientDialog();
        },
      ),
    );
  }

  Widget _buildIngredientItem(Ingredient ingredient) {
    return GestureDetector(
      onTap: () {
        _showEditIngredientDialog(ingredient);
      },
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
                child: Text(
                  ingredient.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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

  String _getUnitSuffix(UnitType unitType) {
    switch (unitType) {
      case UnitType.grams:
        return 'g';
      case UnitType.milliliters:
        return 'ml';
      case UnitType.piece:
        return unitType == UnitType.piece && int.tryParse(_stockController.text) == 1 
            ? 'pc' 
            : 'pcs';
    }
  }

  // Controllers for add/edit ingredient dialog
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _minimumStockController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _pricePerUnitController = TextEditingController();
  UnitType _selectedUnitType = UnitType.grams;
  bool _hasSupplier = false;
  bool _isActive = true;

  void _resetFormControllers() {
    _nameController.clear();
    _stockController.clear();
    _expiryDateController.clear();
    _minimumStockController.clear();
    _supplierNameController.clear();
    _contactNumberController.clear();
    _emailAddressController.clear();
    _pricePerUnitController.clear();
    _selectedUnitType = UnitType.grams;
    _hasSupplier = false;
    _isActive = true;
  }

  void _showAddIngredientDialog() {
    _resetFormControllers();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Custom AppBar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: const Color(0xFFB71C1C),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              const Text(
                                "Add Ingredient",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              _addNewIngredient();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xFFFFF1F1),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          const Text("Name"),
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              hintText: "Enter ingredient name",
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Unit of measurement
                          const Text("Unit of measurement"),
                          Row(
                            children: [
                              Radio<UnitType>(
                                value: UnitType.grams,
                                groupValue: _selectedUnitType,
                                onChanged: (UnitType? value) {
                                  setState(() => _selectedUnitType = value!);
                                },
                              ),
                              const Text("gram(s)"),
                              Radio<UnitType>(
                                value: UnitType.milliliters,
                                groupValue: _selectedUnitType,
                                onChanged: (UnitType? value) {
                                  setState(() => _selectedUnitType = value!);
                                },
                              ),
                              const Text("milliliter(ml)"),
                              Radio<UnitType>(
                                value: UnitType.piece,
                                groupValue: _selectedUnitType,
                                onChanged: (UnitType? value) {
                                  setState(() => _selectedUnitType = value!);
                                },
                              ),
                              const Text("per piece"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Stock
                          const Text("Stock"),
                          TextField(
                            controller: _stockController,
                            decoration: InputDecoration(
                              hintText: "Enter current stock",
                              border: const UnderlineInputBorder(),
                              suffixText: _selectedUnitType == UnitType.grams
                                  ? "g"
                                  : _selectedUnitType == UnitType.milliliters
                                      ? "ml"
                                      : "pcs",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          
                          // Expiry date
                          const Text("Expiry date"),
                          TextField(
                            controller: _expiryDateController,
                            decoration: const InputDecoration(
                              hintText: "DD/MM/YYYY",
                              border: UnderlineInputBorder(),
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 3650)),
                              );
                              if (picked != null) {
                                setState(() {
                                  _expiryDateController.text = DateFormat('dd/MM/yyyy').format(picked);
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Minimum stock level
                          const Text("Minimum Stock Level"),
                          TextField(
                            controller: _minimumStockController,
                            decoration: InputDecoration(
                              hintText: "Enter minimum stock level",
                              border: const UnderlineInputBorder(),
                              suffixText: _selectedUnitType == UnitType.grams
                                  ? "g"
                                  : _selectedUnitType == UnitType.milliliters
                                      ? "ml"
                                      : "pcs",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          
                          // Has Supplier
                          const Text("Has Supplier"),
                          Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: _hasSupplier,
                                onChanged: (bool? value) {
                                  setState(() => _hasSupplier = value!);
                                },
                              ),
                              const Text("Yes"),
                              Radio<bool>(
                                value: false,
                                groupValue: _hasSupplier,
                                onChanged: (bool? value) {
                                  setState(() => _hasSupplier = value!);
                                },
                              ),
                              const Text("No"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Supplier information (conditionally visible)
                          if (_hasSupplier) ...[
                            const Text("Supplier Name"),
                            TextField(
                              controller: _supplierNameController,
                              decoration: const InputDecoration(
                                hintText: "Enter supplier name",
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            const Text("Contact Number"),
                            TextField(
                              controller: _contactNumberController,
                              decoration: const InputDecoration(
                                hintText: "Enter contact number",
                                border: UnderlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            
                            const Text("Email Address"),
                            TextField(
                              controller: _emailAddressController,
                              decoration: const InputDecoration(
                                hintText: "Enter email address",
                                border: UnderlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            
                            const Text("Price per unit"),
                            TextField(
                              controller: _pricePerUnitController,
                              decoration: const InputDecoration(
                                hintText: "Enter price per unit",
                                border: UnderlineInputBorder(),
                                prefixText: "₱ ",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              contentTextStyle: const TextStyle(color: Colors.black),
            );
          },
        );
      },
    );
  }

  void _showEditIngredientDialog(Ingredient ingredient) {
    // Set initial values
    _nameController.text = ingredient.name;
    _stockController.text = ingredient.stock.replaceAll(RegExp(r'[^0-9]'), '');
    _expiryDateController.text = ingredient.expiryDate;
    _minimumStockController.text = ingredient.minimumStockLevel.replaceAll(RegExp(r'[^0-9]'), '');
    _selectedUnitType = ingredient.unitType;
    _hasSupplier = ingredient.hasSupplier;
    _isActive = ingredient.isActive;
    
    if (ingredient.hasSupplier) {
      _supplierNameController.text = ingredient.supplierName ?? '';
      _contactNumberController.text = ingredient.contactNumber ?? '';
      _emailAddressController.text = ingredient.emailAddress ?? '';
      _pricePerUnitController.text = ingredient.pricePerUnit?.toString() ?? '';
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Custom AppBar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: const Color(0xFFB71C1C),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              const Text(
                                "Edit Ingredient",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              _updateIngredient(ingredient);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xFFFFF1F1),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status
                          const Text("Status"),
                          Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: _isActive,
                                onChanged: (bool? value) {
                                  setState(() => _isActive = value!);
                                },
                              ),
                              const Text("Active"),
                              Radio<bool>(
                                value: false,
                                groupValue: _isActive,
                                onChanged: (bool? value) {
                                  setState(() => _isActive = value!);
                                },
                              ),
                              const Text("Inactive"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Name
                          const Text("Name"),
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              hintText: "Enter ingredient name",
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Unit of measurement
                          const Text("Unit of measurement"),
                          Row(
                            children: [
                              Radio<UnitType>(
                                value: UnitType.grams,
                                groupValue: _selectedUnitType,
                                onChanged: (UnitType? value) {
                                  setState(() => _selectedUnitType = value!);
                                },
                              ),
                              const Text("gram(s)"),
                              Radio<UnitType>(
                                value: UnitType.milliliters,
                                groupValue: _selectedUnitType,
                                onChanged: (UnitType? value) {
                                  setState(() => _selectedUnitType = value!);
                                },
                              ),
                              const Text("milliliter(ml)"),
                              Radio<UnitType>(
                                value: UnitType.piece,
                                groupValue: _selectedUnitType,
                                onChanged: (UnitType? value) {
                                  setState(() => _selectedUnitType = value!);
                                },
                              ),
                              const Text("per piece"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Stock
                          const Text("Stock"),
                          TextField(
                            controller: _stockController,
                            decoration: InputDecoration(
                              hintText: "Enter current stock",
                              border: const UnderlineInputBorder(),
                              suffixText: _selectedUnitType == UnitType.grams
                                  ? "g"
                                  : _selectedUnitType == UnitType.milliliters
                                      ? "ml"
                                      : "pcs",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          
                          // Expiry date
                          const Text("Expiry date"),
                          TextField(
                            controller: _expiryDateController,
                            decoration: const InputDecoration(
                              hintText: "DD/MM/YYYY",
                              border: UnderlineInputBorder(),
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 3650)),
                              );
                              if (picked != null) {
                                setState(() {
                                  _expiryDateController.text = DateFormat('dd/MM/yyyy').format(picked);
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Minimum stock level
                          const Text("Minimum Stock Level"),
                          TextField(
                            controller: _minimumStockController,
                            decoration: InputDecoration(
                              hintText: "Enter minimum stock level",
                              border: const UnderlineInputBorder(),
                              suffixText: _selectedUnitType == UnitType.grams
                                  ? "g"
                                  : _selectedUnitType == UnitType.milliliters
                                      ? "ml"
                                      : "pcs",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          
                          // Has Supplier
                          const Text("Has Supplier"),
                          Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: _hasSupplier,
                                onChanged: (bool? value) {
                                  setState(() => _hasSupplier = value!);
                                },
                              ),
                              const Text("Yes"),
                              Radio<bool>(
                                value: false,
                                groupValue: _hasSupplier,
                                onChanged: (bool? value) {
                                  setState(() => _hasSupplier = value!);
                                },
                              ),
                              const Text("No"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Supplier information (conditionally visible)
                          if (_hasSupplier) ...[
                            const Text("Supplier Name"),
                            TextField(
                              controller: _supplierNameController,
                              decoration: const InputDecoration(
                                hintText: "Enter supplier name",
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            const Text("Contact Number"),
                            TextField(
                              controller: _contactNumberController,
                              decoration: const InputDecoration(
                                hintText: "Enter contact number",
                                border: UnderlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            
                            const Text("Email Address"),
                            TextField(
                              controller: _emailAddressController,
                              decoration: const InputDecoration(
                                hintText: "Enter email address",
                                border: UnderlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            
                            const Text("Price per unit"),
                            TextField(
                              controller: _pricePerUnitController,
                              decoration: const InputDecoration(
                                hintText: "Enter price per unit",
                                border: UnderlineInputBorder(),
                                prefixText: "₱ ",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              contentTextStyle: const TextStyle(color: Colors.black),
            );
          },
        );
      },
    );
  }

  void _addNewIngredient() {
    if (_nameController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _minimumStockController.text.isEmpty) {
      return;
    }

    final stockWithUnit = "${_stockController.text}${_getUnitSuffix(_selectedUnitType)}";
    final minimumStockWithUnit = "${_minimumStockController.text}${_getUnitSuffix(_selectedUnitType)}";

    // Check if stock is low
    double stockValue = double.tryParse(_stockController.text) ?? 0;
    double minStockValue = double.tryParse(_minimumStockController.text) ?? 0;
    bool isStockLow = stockValue <= minStockValue;

    // Check if expiry date is near (within 30 days)
    bool isNearExpiry = false;
    try {
      final parts = _expiryDateController.text.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        final expiryDate = DateTime(year, month, day);
        final today = DateTime.now();
        isNearExpiry = expiryDate.difference(today).inDays <= 30;
      }
    } catch (e) {
      // Date parsing error
      print("Error parsing date: $e");
    }

    final newIngredient = Ingredient(
      name: _nameController.text,
      stock: stockWithUnit,
      unitType: _selectedUnitType,
      expiryDate: _expiryDateController.text,
      minimumStockLevel: minimumStockWithUnit,
      isStockLow: isStockLow,
      isNearExpiry: isNearExpiry,
      hasSupplier: _hasSupplier,
      supplierName: _hasSupplier ? _supplierNameController.text : null,
      contactNumber: _hasSupplier ? _contactNumberController.text : null,
      emailAddress: _hasSupplier ? _emailAddressController.text : null,
      pricePerUnit: _hasSupplier && _pricePerUnitController.text.isNotEmpty 
          ? double.tryParse(_pricePerUnitController.text) 
          : null,
    );

    setState(() {
      _allIngredients.add(newIngredient);
      _filterIngredients();
    });
  }

  void _updateIngredient(Ingredient oldIngredient) {
    if (_nameController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _minimumStockController.text.isEmpty) {
      return;
    }

    final stockWithUnit = "${_stockController.text}${_getUnitSuffix(_selectedUnitType)}";
    final minimumStockWithUnit = "${_minimumStockController.text}${_getUnitSuffix(_selectedUnitType)}";

    // Check if stock is low
    double stockValue = double.tryParse(_stockController.text) ?? 0;
    double minStockValue = double.tryParse(_minimumStockController.text) ?? 0;
    bool isStockLow = stockValue <= minStockValue;

    // Check if expiry date is near (within 30 days)
    bool isNearExpiry = false;
    try {
      final parts = _expiryDateController.text.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        final expiryDate = DateTime(year, month, day);
        final today = DateTime.now();
        isNearExpiry = expiryDate.difference(today).inDays <= 30;
      }
    } catch (e) {
      // Date parsing error
      print("Error parsing date: $e");
    }

    final updatedIngredient = Ingredient(
      name: _nameController.text,
      stock: stockWithUnit,
      unitType: _selectedUnitType,
      expiryDate: _expiryDateController.text,
      minimumStockLevel: minimumStockWithUnit,
      isStockLow: isStockLow,
      isNearExpiry: isNearExpiry,
      isActive: _isActive,
      hasSupplier: _hasSupplier,
      supplierName: _hasSupplier ? _supplierNameController.text : null,
      contactNumber: _hasSupplier ? _contactNumberController.text : null,
      emailAddress: _hasSupplier ? _emailAddressController.text : null,
      pricePerUnit: _hasSupplier && _pricePerUnitController.text.isNotEmpty 
          ? double.tryParse(_pricePerUnitController.text) 
          : null,
    );

    setState(() {
      final index = _allIngredients.indexOf(oldIngredient);
      if (index != -1) {
        _allIngredients[index] = updatedIngredient;
        _filterIngredients();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _stockController.dispose();
    _expiryDateController.dispose();
    _minimumStockController.dispose();
    _supplierNameController.dispose();
    _contactNumberController.dispose();
    _emailAddressController.dispose();
    _pricePerUnitController.dispose();
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