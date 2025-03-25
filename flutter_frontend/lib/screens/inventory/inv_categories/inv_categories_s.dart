import 'package:flutter/material.dart';

/// InvCategoriesScreen - Inventory Categories Screen
///
/// This screen displays a list of inventory categories with filtering options.
/// Users can create new categories, edit existing ones, and filter by status.
///
/// The screen implements:
/// - Active/Inactive filtering in the app bar
/// - Category listing with item counts
/// - Create new category via floating action button
/// - Edit existing category by tapping on it
///
/// Future enhancement areas:
/// - Connect to backend API for persistent storage
/// - Add search functionality
/// - Add sorting options
/// - Implement delete functionality
class InvCategoriesScreen extends StatefulWidget {
  const InvCategoriesScreen({super.key});

  @override
  _InvCategoriesScreenState createState() => _InvCategoriesScreenState();
}

class _InvCategoriesScreenState extends State<InvCategoriesScreen> {
  // Controls whether to show active or inactive categories
  // ADJUSTABLE: Change default value to false to show inactive categories initially
  bool _isActive = true;

  // ADJUSTABLE: Mock data for categories
  // This data can be replaced with API calls to fetch real data
  // Each category has: id, name, type (Event/Standard), active status, and item count
  List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'Food', 'type': 'Event', 'active': true, 'items': 2},
    {
      'id': 2,
      'name': 'Beverage',
      'type': 'Standard',
      'active': true,
      'items': 2
    },
    {'id': 3, 'name': 'Add on', 'type': 'Standard', 'active': true, 'items': 2},
    {'id': 4, 'name': 'Booking', 'type': 'Event', 'active': true, 'items': 2},
    {
      'id': 5,
      'name': 'Archived',
      'type': 'Standard',
      'active': false,
      'items': 0
    }
  ];

  // Stores the filtered list of categories based on active/inactive selection
  // This is derived from _categories and updated by _filterCategories()
  List<Map<String, dynamic>> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filterCategories(); // Initialize filtered categories on screen load
  }

  /// Filters the categories based on the active/inactive toggle
  ///
  /// This method updates _filteredCategories to contain only active or inactive
  /// categories based on the current value of _isActive.
  /// ADJUSTABLE: Modify the filter logic here to add more complex filtering
  void _filterCategories() {
    setState(() {
      _filteredCategories = _categories
          .where((category) => category['active'] == _isActive)
          .toList();

      // ADJUSTABLE: Uncomment to add sorting by name
      // _filteredCategories.sort((a, b) => a['name'].compareTo(b['name']));
    });
  }

  /// Shows the dialog to create a new category
  ///
  /// This method prepares the dialog with empty data and
  /// the isNew flag set to true.
  /// ADJUSTABLE: Change the default values for new categories here
  void _createCategory() {
    _showCategoryDialog(
      title: 'Create Category',
      category: {'name': '', 'type': 'Event', 'active': true, 'items': 0},
      isNew: true,
    );
  }

  /// Shows the dialog to edit an existing category
  ///
  /// This method prepares the dialog with the selected category's data
  /// and the isNew flag set to false.
  /// ADJUSTABLE: Customize the edit behavior by modifying this method
  void _editCategory(Map<String, dynamic> category) {
    _showCategoryDialog(
      title: 'Edit Category',
      category: Map<String, dynamic>.from(
          category), // Create a copy to avoid modifying original directly
      isNew: false,
    );
  }

  /// Shows the category creation/editing dialog
  ///
  /// This is a shared method used by both create and edit operations.
  /// It displays a dialog with form fields for category properties.
  ///
  /// Parameters:
  /// - title: Dialog title ('Create Category' or 'Edit Category')
  /// - category: The category data to populate the form with (or empty for create)
  /// - isNew: Whether this is a new category (true) or editing existing (false)
  ///
  /// ADJUSTABLE: Modify this method to add new fields or validation
  void _showCategoryDialog({
    required String title,
    required Map<String, dynamic> category,
    required bool isNew,
  }) {
    // Initialize form field controllers with current values
    final TextEditingController nameController =
        TextEditingController(text: category['name']);
    String selectedType = category['type']; // 'Event' or 'Standard'
    bool isActive = category['active']; // true or false

    // ADJUSTABLE: Add additional controllers for new fields here

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isNew) ...[
                    Text('Status'),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isActive,
                          onChanged: (bool? value) {
                            setDialogState(() {
                              isActive = value!;
                            });
                          },
                        ),
                        Text('Active'),
                        SizedBox(width: 16),
                        Radio(
                          value: false,
                          groupValue: isActive,
                          onChanged: (bool? value) {
                            setDialogState(() {
                              isActive = value!;
                            });
                          },
                        ),
                        Text('Inactive'),
                        // ADJUSTABLE: Add more status options here if needed
                      ],
                    ),
                  ],
                  SizedBox(height: 16),
                  Text('Name'),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter category name',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Type'),
                  Row(
                    children: [
                      Radio(
                        value: 'Event',
                        groupValue: selectedType,
                        onChanged: (String? value) {
                          setDialogState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      Text('Event'),
                      SizedBox(width: 16),
                      Radio(
                        value: 'Standard',
                        groupValue: selectedType,
                        onChanged: (String? value) {
                          setDialogState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      Text('Standard'),
                      // ADJUSTABLE: Add more type options here if needed
                    ],
                  ),
                  // ADJUSTABLE: Add more form fields here as needed
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  // Save button handler - adds or updates a category
                  onPressed: () {
                    final String name = nameController.text.trim();

                    // Basic validation - require a name
                    // ADJUSTABLE: Add more validation logic here
                    if (name.isNotEmpty) {
                      setState(() {
                        if (isNew) {
                          // Add new category
                          // ADJUSTABLE: Modify the category object structure here to add new fields
                          _categories.add({
                            'id': _categories.length + 1, // Auto-increment ID
                            'name': name,
                            'type': selectedType,
                            'active': true, // New categories are always active
                            'items': 0, // New categories start with 0 items
                          });

                          // ADJUSTABLE: Add API call here to save to backend
                          // Example: await apiService.createCategory(newCategory);
                        } else {
                          // Update existing category
                          final index = _categories
                              .indexWhere((c) => c['id'] == category['id']);
                          if (index != -1) {
                            // ADJUSTABLE: Update any additional fields here
                            _categories[index]['name'] = name;
                            _categories[index]['type'] = selectedType;
                            _categories[index]['active'] = isActive;

                            // ADJUSTABLE: Add API call here to update in backend
                            // Example: await apiService.updateCategory(updatedCategory);
                          }
                        }
                        // Refresh the filtered list after changes
                        _filterCategories();
                      });
                      Navigator.of(context).pop();
                    }
                    // ADJUSTABLE: Add error handling for validation failures
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Builds the UI for the categories screen
  ///
  /// The screen has three main parts:
  /// 1. App bar with active/inactive toggle and search
  /// 2. Body containing the list of categories
  /// 3. Floating action button to create new categories
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ADJUSTABLE: App bar configuration
      appBar: AppBar(
        // ADJUSTABLE: Change app bar color here
        backgroundColor: const Color.fromRGBO(244, 67, 54, 1), // Red color
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Categories', style: TextStyle(color: Colors.white)),
        actions: [
          // Active/Inactive radio buttons
          // ADJUSTABLE: Modify or remove this filter if needed
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
                        _filterCategories();
                      });
                    },
                    fillColor: MaterialStateProperty.all(Colors.white),
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
                        _filterCategories();
                      });
                    },
                    fillColor: MaterialStateProperty.all(Colors.white),
                  ),
                  Text('Inactive',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ],
          ),
          // Search button
          // ADJUSTABLE: Implement search functionality or remove this button
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Implement search
              // Example implementation could filter categories by name
              // showSearch(context: context, delegate: CategorySearchDelegate(_categories));
            },
          ),
          // ADJUSTABLE: Add more action buttons here if needed
        ],
      ),
      // Main body of the screen
      // ADJUSTABLE: Change background color here
      body: Container(
        color: Color(0xFFFFE8E0), // Light pink background
        child: Stack(
          children: [
            // Empty state or list of categories
            _filteredCategories.isEmpty
                ? Center(child: Text('No categories found'))
                : ListView.builder(
                    itemCount: _filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = _filteredCategories[index];
                      // ADJUSTABLE: Modify the category item layout here
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0, bottom: 0),
                        child: GestureDetector(
                          onTap: () => _editCategory(category),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category name
                              Text(
                                category['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Item count
                              Text(
                                'Items: ${category['items']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              // ADJUSTABLE: Add more category properties here
                              // Example: Text('Type: ${category['type']}', style: ...)
                              Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            // Floating action button for adding new categories
            // ADJUSTABLE: Modify FAB position, color, or icon
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: _createCategory,
                backgroundColor: Colors.green, // ADJUSTABLE: Change FAB color
                child: Icon(Icons.add),
                // ADJUSTABLE: Add tooltip or extended FAB with label
                // tooltip: 'Add New Category',
              ),
            ),
            // ADJUSTABLE: Add more floating elements, such as filter chips or banners
          ],
        ),
      ),
      // ADJUSTABLE: Add bottom navigation bar here if needed
      // bottomNavigationBar: BottomNavigationBar(...),
    );
  }
}

/// ADDITIONAL DOCUMENTATION
/// 
/// Data Structure:
/// The category data structure includes these fields:
/// - id: Unique identifier for the category
/// - name: Display name of the category
/// - type: Can be 'Event' or 'Standard'
/// - active: Boolean indicating if the category is active
/// - items: Count of items in this category
/// 
/// To add new fields to categories:
/// 1. Add the field to the mock data in _categories
/// 2. Add UI elements in the _showCategoryDialog method
/// 3. Update the save logic to handle the new field
/// 
/// API Integration Points:
/// To connect this UI to a backend:
/// 1. Replace _categories initialization with API call in initState
/// 2. Add API calls in _createCategory and _editCategory methods
/// 3. Implement proper error handling and loading states
/// 
/// Screen Navigation:
/// This screen expects to be pushed onto a navigation stack and uses
/// Navigator.pop() to return to the previous screen.
/// 
/// Future Enhancement Ideas:
/// - Add delete functionality with confirmation dialog
/// - Add category reordering with drag and drop
/// - Add bulk operations for multiple categories
/// - Add category color coding or icons
/// - Implement pagination for large numbers of categories