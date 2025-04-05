import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'employee_create.dart';
import 'employee_view.dart';

class ListEmployeeScreen extends StatefulWidget {
  @override
  _ListEmployeeScreenState createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  bool _isActive = true;
  List<Map<String, dynamic>> employees = [];
  List<Map<String, dynamic>> filteredEmployees = [];
  bool _isLoading = true;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/employees/list/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          employees = data.map<Map<String, dynamic>>((e) {
            return {
              'id': e['id'],
              'username': e['username'],
              'name': '${e['first_name']} ${e['last_name']}',
              'email': e['email_address'],
              'contact': e['contact_number'],
              'role': e['employee_role'],
              'pin': e['pin'],
              'status': e['status'],
            };
          }).toList();

          filteredEmployees = List.from(employees);
          _isLoading = false;
        });
      } else {
        print("Failed to fetch employees: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void searchEmployees(String query) {
    final searchLower = query.toLowerCase();
    setState(() {
      filteredEmployees = employees.where((e) {
        return (e['name'].toLowerCase().contains(searchLower) ||
            e['username'].toLowerCase().contains(searchLower));
      }).toList();
    });
  }

  void clearSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      filteredEmployees = List.from(employees);
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusFilteredEmployees = filteredEmployees
        .where((employee) =>
            employee['status'] == (_isActive ? 'active' : 'inactive'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search employees...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: searchEmployees,
              )
            : Row(
                children: [
                  Text('Employee List', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: _isActive,
                        onChanged: (bool? value) {
                          setState(() => _isActive = value!);
                        },
                        fillColor: MaterialStateProperty.all(Colors.white),
                      ),
                      Text('Active',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                      Radio(
                        value: false,
                        groupValue: _isActive,
                        onChanged: (bool? value) {
                          setState(() => _isActive = value!);
                        },
                        fillColor: MaterialStateProperty.all(Colors.white),
                      ),
                      Text('Inactive',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                    ],
                  ),
                ],
              ),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: clearSearch,
                )
              : IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : statusFilteredEmployees.isEmpty
                ? Center(child: Text('No employees found'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.white),
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(4),
                          3: FlexColumnWidth(3),
                          4: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.white),
                            children: [
                              tableCell('Username', isHeader: true),
                              tableCell('Name', isHeader: true),
                              tableCell('Email', isHeader: true),
                              tableCell('Contact', isHeader: true),
                              tableCell('Role', isHeader: true),
                            ],
                          ),
                          ...statusFilteredEmployees.map((employee) {
                            return TableRow(
                              children: [
                                tableCell(employee['username'],
                                    onTap: () =>
                                        _viewEmployee(context, employee)),
                                tableCell(employee['name'],
                                    onTap: () =>
                                        _viewEmployee(context, employee)),
                                tableCell(employee['email'],
                                    onTap: () =>
                                        _viewEmployee(context, employee)),
                                tableCell(employee['contact'],
                                    onTap: () =>
                                        _viewEmployee(context, employee)),
                                tableCell(employee['role'],
                                    onTap: () =>
                                        _viewEmployee(context, employee)),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEmployeeScreen()),
          );
          fetchEmployees(); // Refresh list after creating new
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _viewEmployee(BuildContext context, Map<String, dynamic> employee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewEmployeeScreen(employee: employee),
      ),
    );
  }

  Widget tableCell(String text, {bool isHeader = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
