import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditBookingScreen extends StatefulWidget {
  final String bookingId;

  EditBookingScreen({required this.bookingId});

  @override
  _EditBookingScreenState createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController customerNameController = TextEditingController();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController bookingDateController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController numberOfAttendeesController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String selectedPaymentStatus = "Pending";
  String selectedBookingStatus = "Pending";
  bool isLoading = true;
  bool isUpdating = false;

  static const Map<String, String> paymentStatusMap = {
    "P": "Pending",
    "F": "Fully Paid",
    "A": "Partially Paid",
    "R": "Refunded",
  };

  static const Map<String, String> bookingStatusMap = {
    "S": "Success",
    "C": "Cancelled",
    "P": "Pending",
  };

  @override
  void initState() {
    super.initState();
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    String apiUrl = "http://10.0.2.2:8000/api/bookings/${widget.bookingId}/";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          customerNameController.text = data['customer_name'] ?? "";
          eventNameController.text = data['event_name'] ?? "";
          bookingDateController.text = data['booking_date'] ?? "";
          customerEmailController.text = data['customer_email'] ?? "";
          contactNumberController.text = data['customer_contact'] ?? "";
          numberOfAttendeesController.text =
              data['head_count']?.toString() ?? "";
          locationController.text = data['location'] ?? "";
          selectedPaymentStatus = getFullPaymentStatus(data['payment_status']);
          print("DEBUG: Mapped Payment Status → $selectedPaymentStatus");
          print(
              "DEBUG: Available keys in map → ${paymentStatusMap.keys.toList()}");
          selectedBookingStatus = getFullBookingStatus(data['booking_status']);
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching booking: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  String getFullPaymentStatus(String status) {
    return paymentStatusMap[status.toUpperCase()] ?? "Pending";
  }

  String getFullBookingStatus(String status) {
    return bookingStatusMap[status.toUpperCase()] ?? "Pending";
  }

  Future<void> updateBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isUpdating = true;
    });

    String apiUrl =
        "http://10.0.2.2:8000/api/bookings/update/${widget.bookingId}/";

    final Map<String, dynamic> requestData = {
      "customer_name": customerNameController.text.trim(),
      "event_name": eventNameController.text.trim(),
      "booking_date": bookingDateController.text.trim(),
      "customer_email": customerEmailController.text.trim(),
      "customer_contact": contactNumberController.text.trim(),
      "head_count": int.tryParse(numberOfAttendeesController.text.trim()) ?? 0,
      "location": locationController.text.trim(),
      "payment_status": paymentStatusMap.entries
          .firstWhere((entry) => entry.value == selectedPaymentStatus,
              orElse: () => MapEntry("P", "Pending")) // Default to "P"
          .key,
      "booking_status": bookingStatusMap.entries
          .firstWhere((entry) => entry.value == selectedBookingStatus,
              orElse: () => MapEntry("P", "Pending")) // Default to "P"
          .key,
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, requestData);
      } else {
        print(
            "Error updating booking: ${response.statusCode} - ${response.body}");
      }
    } catch (error) {
      print("Error updating booking: $error");
    }

    setState(() {
      isUpdating = false;
    });
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: isUpdating ? null : updateBooking,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        _buildTextField(
                            "Customer Name", customerNameController),
                        _buildTextField("Event Name", eventNameController),
                        _buildTextField(
                            "Booking Date (YYYY-MM-DD)", bookingDateController),
                        _buildTextField(
                            "Customer Email", customerEmailController),
                        _buildTextField(
                            "Contact Number", contactNumberController),
                        _buildTextField(
                            "Number of Attendees", numberOfAttendeesController,
                            isNumber: true),
                        _buildTextField("Location", locationController),
                        SizedBox(height: 16),
                        Text("Payment Status:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        _buildDropdown(paymentStatusMap.values.toList(),
                            selectedPaymentStatus, (value) {
                          setState(() {
                            selectedPaymentStatus = value!;
                          });
                        }),
                        SizedBox(height: 16),
                        Text("Booking Status:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        _buildDropdown(bookingStatusMap.values.toList(),
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
            ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) =>
            value!.isEmpty ? "This field cannot be empty" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items, String value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}
