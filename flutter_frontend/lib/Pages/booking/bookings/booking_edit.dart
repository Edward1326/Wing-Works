import 'package:flutter/material.dart';

class EditBookingScreen extends StatefulWidget {
  final String bookingId;
  final String customerName;
  final String eventName;
  final String bookingDate;
  final String customerEmail;
  final String contactNumber;
  final int numberOfAttendees;
  final String location;
  final String paymentStatus;
  final String bookingStatus;

  EditBookingScreen({
    required this.bookingId,
    required this.customerName,
    required this.eventName,
    required this.bookingDate,
    required this.customerEmail,
    required this.contactNumber,
    required this.numberOfAttendees,
    required this.location,
    required this.paymentStatus,
    required this.bookingStatus,
  });

  @override
  _EditBookingScreenState createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  late TextEditingController nameController;
  late TextEditingController eventController;
  late TextEditingController dateController;
  late TextEditingController emailController;
  late TextEditingController contactController;
  late TextEditingController attendeesController;
  late TextEditingController locationController;
  String selectedPaymentStatus = "Pending";
  String selectedBookingStatus = "Pending";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.customerName);
    eventController = TextEditingController(text: widget.eventName);
    dateController = TextEditingController(text: widget.bookingDate);
    emailController = TextEditingController(text: widget.customerEmail);
    contactController = TextEditingController(text: widget.contactNumber);
    attendeesController =
        TextEditingController(text: widget.numberOfAttendees.toString());
    locationController = TextEditingController(text: widget.location);
    selectedPaymentStatus = widget.paymentStatus;
    selectedBookingStatus = widget.bookingStatus;
  }

  @override
  void dispose() {
    nameController.dispose();
    eventController.dispose();
    dateController.dispose();
    emailController.dispose();
    contactController.dispose();
    attendeesController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE4E1),
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Edit Booking', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print("Updated Booking:");
              print("Name: ${nameController.text}");
              print("Event: ${eventController.text}");
              print("Date: ${dateController.text}");
              print("Email: ${emailController.text}");
              print("Contact: ${contactController.text}");
              print("Attendees: ${attendeesController.text}");
              print("Location: ${locationController.text}");
              print("Payment Status: $selectedPaymentStatus");
              print("Booking Status: $selectedBookingStatus");
              Navigator.pop(context);
            },
            child: Text('Save',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                _buildReadOnlyField('Booking ID', widget.bookingId),
                _buildEditableField('Name', nameController),
                _buildEditableField('Event Name', eventController),
                _buildEditableField('Booking Date', dateController),
                _buildEditableField('Customer Email', emailController),
                _buildEditableField('Contact Number', contactController),
                _buildEditableField('Number of Attendees', attendeesController),
                _buildEditableField('Location', locationController),
                _buildDropdownField(
                    'Payment Status',
                    ['Fully Paid', 'Partially Paid', 'Refunded', 'Pending'],
                    selectedPaymentStatus, (value) {
                  setState(() {
                    selectedPaymentStatus = value!;
                  });
                }),
                _buildDropdownField(
                    'Booking Status',
                    ['Success', 'Cancelled', 'Pending'],
                    selectedBookingStatus, (value) {
                  setState(() {
                    selectedBookingStatus = value!;
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey[700])),
            SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options,
      String selectedValue, ValueChanged<String?> onChanged) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
          value: selectedValue,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
