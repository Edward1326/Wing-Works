import 'package:flutter/material.dart';
import 'dart:math' as math;

/// ReqPOScreen - Request Purchase Order Screen
///
/// This screen allows users to:
/// - View ingredient stock information
/// - Add ingredients to a purchase order
/// - Adjust quantities and view totals
/// - Generate a purchase order document
///
/// The UI implements:
/// - Main view with ingredient stock info
/// - Sliding panel for order details
/// - Purchase order preview with download option
class ReqPOScreen extends StatefulWidget {
  const ReqPOScreen({super.key});

  @override
  _ReqPOScreenState createState() => _ReqPOScreenState();
}

class _ReqPOScreenState extends State<ReqPOScreen>
    with SingleTickerProviderStateMixin {
  // Animation controller for the sliding panel
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isPanelVisible = false;

  // Sample data for ingredients
  // ADJUSTABLE: Replace with actual data from your database
  final List<Map<String, dynamic>> _ingredients = [
    {
      'name': 'Chicken',
      'stock': 100.0,
      'expiry_date': '01/01/25',
      'min_stock': 100.0,
      'unit': 'g',
      'price_per_unit': 10.0,
    },
    {
      'name': 'Beef',
      'stock': 200.0,
      'expiry_date': '02/15/25',
      'min_stock': 150.0,
      'unit': 'g',
      'price_per_unit': 15.0,
    },
    {
      'name': 'Rice',
      'stock': 5000.0,
      'expiry_date': '06/30/25',
      'min_stock': 1000.0,
      'unit': 'g',
      'price_per_unit': 0.5,
    },
    {
      'name': 'Oil',
      'stock': 2000.0,
      'expiry_date': '12/31/25',
      'min_stock': 500.0,
      'unit': 'ml',
      'price_per_unit': 0.2,
    },
  ];

  // Track selected ingredients for the purchase order
  // ADJUSTABLE: Modify data structure to include more details if needed
  List<Map<String, dynamic>> _selectedIngredients = [];

  // Track if we're showing the purchase order view
  bool _showPurchaseOrder = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for the sliding panel
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Create animation for sliding panel
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Toggles the order details panel visibility
  void _togglePanel() {
    setState(() {
      _isPanelVisible = !_isPanelVisible;
      if (_isPanelVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  /// Add an ingredient to the order
  /// ADJUSTABLE: Modify to include additional fields or validation
  void _addIngredient(Map<String, dynamic> ingredient) {
    // Check if ingredient already exists in the order
    int existingIndex = _selectedIngredients
        .indexWhere((item) => item['name'] == ingredient['name']);

    setState(() {
      if (existingIndex != -1) {
        // Already in order, show panel
        _togglePanel();
      } else {
        // Add to order with initial quantity
        _selectedIngredients.add({
          'name': ingredient['name'],
          'quantity': 300.0, // Default quantity
          'unit': ingredient['unit'],
          'price_per_unit': ingredient['price_per_unit'],
        });

        // Show the panel
        if (!_isPanelVisible) {
          _togglePanel();
        }
      }
    });
  }

  /// Remove an ingredient from the order
  void _removeIngredient(int index) {
    setState(() {
      _selectedIngredients.removeAt(index);
    });
  }

  /// Adjust the quantity of an ingredient in the order
  void _adjustQuantity(int index, double change) {
    setState(() {
      double newQty = _selectedIngredients[index]['quantity'] + change;
      // Ensure quantity doesn't go below zero
      _selectedIngredients[index]['quantity'] = math.max(0, newQty);
    });
  }

  /// Clear all items from the order
  void _clearOrder() {
    setState(() {
      _selectedIngredients.clear();
    });
  }

  /// Generate purchase order and show preview
  void _generatePO() {
    if (_selectedIngredients.isEmpty) {
      // Show warning if no ingredients selected
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please add ingredients to the order')));
      return;
    }

    setState(() {
      _showPurchaseOrder = true;
    });
  }

  /// Close the purchase order view
  void _closePurchaseOrder() {
    setState(() {
      _showPurchaseOrder = false;
    });
  }

  /// Calculate the total price for an item
  double _calculateItemTotal(Map<String, dynamic> item) {
    return item['quantity'] * item['price_per_unit'];
  }

  /// Calculate the total amount for all items
  double _calculateTotal() {
    double total = 0;
    for (var item in _selectedIngredients) {
      total += _calculateItemTotal(item);
    }
    return total;
  }

  /// Simulate downloading the purchase order as PDF
  /// ADJUSTABLE: Replace with actual PDF generation and download logic
  void _downloadPurchaseOrder() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Purchase Order downloaded')));

    // In a real app, you would use a package like pdf or printing
    // to generate and download a PDF file
    // Example:
    // final pdf = await generatePurchaseOrderPdf(_selectedIngredients);
    // await Printing.sharePdf(bytes: pdf.save(), filename: 'purchase_order.pdf');
  }

  @override
  Widget build(BuildContext context) {
    // If purchase order view is active, show it
    if (_showPurchaseOrder) {
      return _buildPurchaseOrderView();
    }

    return Scaffold(
      // Main app bar with title and menu button
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 67, 54, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Request Purchase Order',
            style: TextStyle(color: Colors.white)),
        actions: [
          // Toggle button for order details panel
          IconButton(
            icon: Icon(_isPanelVisible ? Icons.close : Icons.menu,
                color: Colors.white),
            onPressed: _togglePanel,
          ),
        ],
      ),
      // Main body with stack for layering the sliding panel
      body: Stack(
        children: [
          // Main content - Ingredients list
          Container(
            color: Color(0xFFFFE8E0),
            child: _ingredients.isEmpty
                ? Center(child: Text('No ingredients available'))
                : ListView.builder(
                    itemCount: _ingredients.length,
                    itemBuilder: (context, index) {
                      var ingredient = _ingredients[index];
                      return InkWell(
                        onTap: () => _addIngredient(ingredient),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ingredient['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Stock column
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Stock',
                                          style: TextStyle(fontSize: 12)),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          '${ingredient['stock']}${ingredient['unit']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Expiry column
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Expiry Date',
                                          style: TextStyle(fontSize: 12)),
                                      Text(ingredient['expiry_date']),
                                    ],
                                  ),
                                  // Min stock column
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Minimum Stock Level',
                                          style: TextStyle(fontSize: 12)),
                                      Text(
                                          '${ingredient['min_stock']}${ingredient['unit']}'),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(height: 24),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Order details sliding panel
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Transform.translate(
                  offset: Offset(
                      MediaQuery.of(context).size.width *
                          0.85 *
                          (1 - _animation.value),
                      0),
                  child: child,
                ),
              );
            },
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Order details header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: _togglePanel,
                        ),
                      ],
                    ),
                  ),
                  // Table header
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Selected Ingredients',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Quantity',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Action',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Order items
                  Expanded(
                    child: _selectedIngredients.isEmpty
                        ? Center(child: Text('No items added'))
                        : ListView.builder(
                            itemCount: _selectedIngredients.length,
                            itemBuilder: (context, index) {
                              var item = _selectedIngredients[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8.0),
                                child: Row(
                                  children: [
                                    // Ingredient name
                                    Expanded(
                                      flex: 2,
                                      child: Text(item['name']),
                                    ),
                                    // Quantity with +/- buttons
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () =>
                                                _adjustQuantity(index, -100),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.remove,
                                                  color: Colors.white,
                                                  size: 16),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text('${item['quantity'].toInt()}'),
                                          SizedBox(width: 8),
                                          InkWell(
                                            onTap: () =>
                                                _adjustQuantity(index, 100),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.add,
                                                  color: Colors.white,
                                                  size: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Price
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '₱ ${_calculateItemTotal(item).toStringAsFixed(2)}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    // Remove button
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () =>
                                            _removeIngredient(index),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                        ),
                                        child: Text(
                                          'Remove',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _clearOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 32),
                          ),
                          child: Text('Clear',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: _generatePO,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 32),
                          ),
                          child: Text('Generate PO',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the purchase order preview screen
  /// ADJUSTABLE: Modify layout and styling to match your requirements
  Widget _buildPurchaseOrderView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 151, 27, 18),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: _closePurchaseOrder,
        ),
        title: Text('PURCHASE ORDER', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: Colors.white),
            onPressed: _downloadPurchaseOrder,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Supplier and date
            Text(
              'Supplier: Magnolia',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Order details header
            Text(
              'Order Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Table header
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Ingredients',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Quantity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Price per unit(₱)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Total (₱)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Divider(),

            // Order items
            ..._selectedIngredients.map((item) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(item['name']),
                        ),
                        Expanded(
                          child: Text(
                            '${item['quantity'].toInt()}${item['unit']}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${item['price_per_unit'].toStringAsFixed(2)}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${_calculateItemTotal(item).toStringAsFixed(2)}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                  ],
                )),

            // Total
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Total Amount(₱)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${_calculateTotal().toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),

            // Signature line
            SizedBox(height: 64),
            Divider(),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Authorized Signature',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
