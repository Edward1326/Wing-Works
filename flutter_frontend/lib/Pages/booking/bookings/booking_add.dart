import 'package:flutter/material.dart';

class AddBookingScreen extends StatefulWidget {
  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _attendeesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Add Booking', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _saveBooking();
            },
            child: Text('Add',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildTextField('Name', _nameController),
            _buildTextField('Event Name', _eventController),
            _buildDatePicker(context),
            _buildTextField('Customer Email', _emailController),
            _buildTextField('Contact Number', _contactController),
            _buildTextField('Number of Attendees', _attendeesController),
            _buildTextField('Location', _locationController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Booking Date',
            border: UnderlineInputBorder(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}",
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBooking() {
    print('Booking Saved!');
    Navigator.pop(context);
  }
}
