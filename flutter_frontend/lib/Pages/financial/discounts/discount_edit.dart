import 'package:flutter/material.dart';

class EditDiscountScreen extends StatefulWidget {
  final String name;
  final String value;
  final String type;

  EditDiscountScreen(
      {required this.name, required this.value, required this.type});

  @override
  _EditDiscountScreenState createState() => _EditDiscountScreenState();
}

class _EditDiscountScreenState extends State<EditDiscountScreen> {
  late TextEditingController _nameController;
  late TextEditingController _valueController;
  late String _selectedType;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _valueController = TextEditingController(text: widget.value);
    _selectedType = widget.type;
  }

  Widget buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status', style: TextStyle(fontSize: 16)),
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
                    });
                  },
                  fillColor: MaterialStatePropertyAll(Colors.black),
                ),
                Text('Active',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
            SizedBox(width: 16), // Adds spacing between the options
            Row(
              children: [
                Radio(
                  value: false,
                  groupValue: _isActive,
                  onChanged: (bool? value) {
                    setState(() {
                      _isActive = value!;
                    });
                  },
                  fillColor: MaterialStatePropertyAll(Colors.black),
                ),
                Text('Inactive',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16), // Adds spacing before next section
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Edit Discount', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () {
              // Implement save logic here
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStatusSection(),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ToggleButtons(
                  isSelected: [_selectedType == "%", _selectedType == "∑"],
                  onPressed: (index) {
                    setState(() {
                      _selectedType = index == 0 ? "%" : "∑";
                    });
                  },
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('%', style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('∑', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
