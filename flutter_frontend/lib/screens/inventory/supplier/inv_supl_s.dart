import 'package:flutter/material.dart';

/// SupplierScreen - Supplier Management Screen
///
/// This screen allows users to:
/// - View a list of suppliers with filtering (active/inactive)
/// - Create new suppliers
/// - View and edit supplier details
///
/// The screen follows the same pattern as inv_categories_s.dart and menu_item_s.dart
/// with a floating form for creating/editing suppliers.
class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  // Controls whether to show active or inactive suppliers
  bool _isActive = true;

  // Sample data for suppliers
  // ADJUSTABLE: Replace with actual data from your database
  List<Map<String, dynamic>> _suppliers = [
    {
      'id': 1,
      'name': 'Magnolia',
      'company': 'San Miguel Corporation',
      'email': 'magnolia@sanmiguel.com',
      'contact': '09123456789',
      'active': true,
    },
    {
      'id': 2,
      'name': 'Fresh Farms',
      'company': 'Fresh Farms Inc.',
      'email': 'info@freshfarms.com',
      'contact': '09187654321',
      'active': true,
    },
    {
      'id': 3,
      'name': 'Metro Meat',
      'company': 'Metro Meat Supply Co.',
      'email': 'orders@metromeat.com',
      'contact': '09765432109',
      'active': false,
    },
  ];

  // Filtered list of suppliers based on active/inactive selection
  List<Map<String, dynamic>> _filteredSuppliers = [];

  // Track which supplier is being viewed/edited (null if creating a new one)
  Map<String, dynamic>? _currentSupplier;

  // Control the visibility of the form overlay
  bool _showForm = false;

  // Form mode: 'create', 'view', or 'edit'
  String _formMode = 'create';

  // Form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filterSuppliers();
  }

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  /// Filters the suppliers based on the active/inactive toggle
  void _filterSuppliers() {
    setState(() {
      _filteredSuppliers = _suppliers
          .where((supplier) => supplier['active'] == _isActive)
          .toList();
    });
  }

  /// Shows the form to create a new supplier
  void _createSupplier() {
    _clearForm();
    setState(() {
      _currentSupplier = null;
      _formMode = 'create';
      _showForm = true;
    });
  }

  /// Shows the form to view a supplier's details
  void _viewSupplier(Map<String, dynamic> supplier) {
    _populateForm(supplier);
    setState(() {
      _currentSupplier = supplier;
      _formMode = 'view';
      _showForm = true;
    });
  }

  /// Shows the form to edit a supplier
  void _editSupplier() {
    setState(() {
      _formMode = 'edit';
    });
  }

  /// Clears the form fields
  void _clearForm() {
    _nameController.clear();
    _companyController.clear();
    _emailController.clear();
    _contactController.clear();
  }

  /// Populates the form with supplier data
  void _populateForm(Map<String, dynamic> supplier) {
    _nameController.text = supplier['name'];
    _companyController.text = supplier['company'];
    _emailController.text = supplier['email'];
    _contactController.text = supplier['contact'];
  }

  /// Saves the supplier data from the form
  void _saveSupplier() {
    // Basic validation
    if (_nameController.text.isEmpty || _companyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() {
      if (_formMode == 'create') {
        // Add new supplier
        _suppliers.add({
          'id': _suppliers.isNotEmpty
              ? _suppliers.map((s) => s['id']).reduce((a, b) => a > b ? a : b) +
                  1
              : 1,
          'name': _nameController.text,
          'company': _companyController.text,
          'email': _emailController.text,
          'contact': _contactController.text,
          'active': true,
        });
      } else if (_formMode == 'edit' && _currentSupplier != null) {
        // Update existing supplier
        final index =
            _suppliers.indexWhere((s) => s['id'] == _currentSupplier!['id']);
        if (index != -1) {
          _suppliers[index]['name'] = _nameController.text;
          _suppliers[index]['company'] = _companyController.text;
          _suppliers[index]['email'] = _emailController.text;
          _suppliers[index]['contact'] = _contactController.text;
        }
      }

      // Update the filtered list
      _filterSuppliers();

      // If we were editing, switch to view mode
      if (_formMode == 'edit') {
        _formMode = 'view';
      } else {
        // Otherwise close the form
        _showForm = false;
      }
    });
  }

  /// Closes the form
  void _closeForm() {
    setState(() {
      _showForm = false;
    });
  }

  /// Toggles the active status of a supplier
  void _toggleSupplierStatus(Map<String, dynamic> supplier, bool active) {
    setState(() {
      final index = _suppliers.indexWhere((s) => s['id'] == supplier['id']);
      if (index != -1) {
        _suppliers[index]['active'] = active;

        // If we're viewing this supplier, update the current reference
        if (_currentSupplier != null &&
            _currentSupplier!['id'] == supplier['id']) {
          _currentSupplier = _suppliers[index];
        }
      }

      // Update the filtered list
      _filterSuppliers();
    });
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
        title: Text('Supplier', style: TextStyle(color: Colors.white)),
        actions: [
          // Active/Inactive radio buttons
          Row(
            children: [
              Radio(
                value: true,
                groupValue: _isActive,
                onChanged: (bool? value) {
                  setState(() {
                    _isActive = value!;
                    _filterSuppliers();
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.white),
              ),
              Text('Active',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              Radio(
                value: false,
                groupValue: _isActive,
                onChanged: (bool? value) {
                  setState(() {
                    _isActive = value!;
                    _filterSuppliers();
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.white),
              ),
              Text('Inactive',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
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
      body: Stack(
        children: [
          // Main content - Supplier List
          Container(
            color: Color(0xFFFFE8E0),
            child: Column(
              children: [
                // Drawer menu for navigation
                if (!_showForm) _buildDrawerMenu(),

                // List of suppliers
                Expanded(
                  child: _filteredSuppliers.isEmpty
                      ? Center(child: Text('No suppliers found'))
                      : ListView.builder(
                          itemCount: _filteredSuppliers.length,
                          itemBuilder: (context, index) {
                            var supplier = _filteredSuppliers[index];
                            return InkWell(
                              onTap: () => _viewSupplier(supplier),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            supplier['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(supplier['company']),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(supplier['email']),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(supplier['contact']),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),

          // Floating action button for adding a new supplier
          if (!_showForm)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: _createSupplier,
                backgroundColor: Colors.green,
                child: Icon(Icons.add),
              ),
            ),

          // Form overlay for create/view/edit
          if (_showForm)
            Container(
              color: Color(0xFFFFE8E0),
              child: Column(
                children: [
                  // Form header
                  AppBar(
                    backgroundColor: const Color.fromARGB(255, 151, 27, 18),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: _closeForm,
                    ),
                    title: Text(
                      _formMode == 'create'
                          ? 'Create Supplier'
                          : _formMode == 'view'
                              ? 'View Supplier'
                              : 'Edit Supplier',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      if (_formMode == 'view')
                        TextButton(
                          onPressed: _editSupplier,
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      if (_formMode == 'create' || _formMode == 'edit')
                        TextButton(
                          onPressed: _saveSupplier,
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),

                  // Form content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status (only for edit/view mode)
                          if (_formMode != 'create' &&
                              _currentSupplier != null) ...[
                            Text('Status'),
                            Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue:
                                      _currentSupplier!['active'] as bool,
                                  onChanged: _formMode == 'edit'
                                      ? (bool? value) => _toggleSupplierStatus(
                                          _currentSupplier!, value!)
                                      : null,
                                ),
                                Text('Active'),
                                SizedBox(width: 16),
                                Radio<bool>(
                                  value: false,
                                  groupValue:
                                      _currentSupplier!['active'] as bool,
                                  onChanged: _formMode == 'edit'
                                      ? (bool? value) => _toggleSupplierStatus(
                                          _currentSupplier!, value!)
                                      : null,
                                ),
                                Text('Inactive'),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],

                          // Supplier Name
                          Text('Supplier Name'),
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter supplier name',
                            ),
                            enabled: _formMode != 'view',
                          ),
                          SizedBox(height: 16),

                          // Company
                          Text('Company'),
                          TextField(
                            controller: _companyController,
                            decoration: InputDecoration(
                              hintText: 'Enter company name',
                            ),
                            enabled: _formMode != 'view',
                          ),
                          SizedBox(height: 16),

                          // Email
                          Text('Email'),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter email address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            enabled: _formMode != 'view',
                          ),
                          SizedBox(height: 16),

                          // Contact Number
                          Text('Contact Number'),
                          TextField(
                            controller: _contactController,
                            decoration: InputDecoration(
                              hintText: 'Enter contact number',
                            ),
                            keyboardType: TextInputType.phone,
                            enabled: _formMode != 'view',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the drawer menu for navigation
  Widget _buildDrawerMenu() {
    return Container(
      color: Color(0xFFFFE8E0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Supplier List'),
            onTap: () {
              // Already on this screen
            },
          ),
          Divider(height: 1),
          // Additional menu items could be added here
        ],
      ),
    );
  }
}

/// ADDITIONAL DOCUMENTATION
/// 
/// Data Structure:
/// The supplier data structure includes these fields:
/// - id: Unique identifier for the supplier
/// - name: Supplier name
/// - company: Company name
/// - email: Email address
/// - contact: Contact number
/// - active: Boolean indicating if the supplier is active
/// 
/// Form Modes:
/// - create: Creating a new supplier
/// - view: Viewing supplier details
/// - edit: Editing supplier details
/// 
/// API Integration Points:
/// To connect this UI to a backend:
/// 1. Replace _suppliers initialization with API call in initState
/// 2. Add API calls in the _saveSupplier method
/// 3. Add API calls for toggling supplier status
/// 
/// Screen Navigation:
/// This screen expects to be pushed onto a navigation stack and uses
/// Navigator.pop() to return to the previous screen.
/// 
/// Future Enhancements:
/// - Add delete functionality
/// - Add search functionality
/// - Add sorting options
/// - Add pagination for large numbers of suppliers
/// - Add data validation for email and phone formats