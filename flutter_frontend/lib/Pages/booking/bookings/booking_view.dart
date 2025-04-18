import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/booking/bookings/booking_edit.dart';

class ViewBookingPage extends StatefulWidget {
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

  ViewBookingPage({
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
  _ViewBookingPageState createState() => _ViewBookingPageState();
}

class _ViewBookingPageState extends State<ViewBookingPage> {
  late String customerName;
  late String eventName;
  late String bookingDate;
  late String customerEmail;
  late String contactNumber;
  late int numberOfAttendees;
  late String location;
  late String paymentStatus;
  late String bookingStatus;

  @override
  void initState() {
    super.initState();
    customerName = widget.customerName;
    eventName = widget.eventName;
    bookingDate = widget.bookingDate;
    customerEmail = widget.customerEmail;
    contactNumber = widget.contactNumber;
    numberOfAttendees = widget.numberOfAttendees;
    location = widget.location;
    paymentStatus = getFullPaymentStatus(widget.paymentStatus);
    bookingStatus = getFullBookingStatus(widget.bookingStatus);
  }

  // Maps short statuses to full names
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

  // Convert abbreviated statuses to full names
  String getFullPaymentStatus(String status) {
    return paymentStatusMap[status.toUpperCase()] ?? status;
  }

  String getFullBookingStatus(String status) {
    return bookingStatusMap[status.toUpperCase()] ?? status;
  }

  Future<void> navigateToEditPage() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookingScreen(
          bookingId: widget.bookingId,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        customerName = updatedData['customer_name'];
        eventName = updatedData['event_name'];
        bookingDate = updatedData['booking_date'];
        customerEmail = updatedData['customer_email'];
        contactNumber = updatedData['customer_contact'];
        numberOfAttendees = updatedData['head_count'];
        location = updatedData['location'];
        paymentStatus = getFullPaymentStatus(updatedData['payment_status']);
        bookingStatus = getFullBookingStatus(updatedData['booking_status']);
      });

      Navigator.pop(context, updatedData); // ✅ Send updated data back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE4E1),
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('View Booking', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: navigateToEditPage,
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
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
                _buildInfoCard('Booking ID', widget.bookingId),
                _buildInfoCard('Name', customerName),
                _buildInfoCard('Event Name', eventName),
                _buildInfoCard('Booking Date', bookingDate),
                _buildInfoCard('Customer Email', customerEmail),
                _buildInfoCard('Contact Number', contactNumber),
                _buildInfoCard(
                    'Number of Attendees', numberOfAttendees.toString()),
                _buildInfoCard('Location', location),
                _buildStatusCard('Payment Status', paymentStatus),
                _buildStatusCard('Booking Status', bookingStatus),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String label, String value) {
    Color statusColor;

    if (label == 'Payment Status') {
      switch (value) {
        case 'Fully Paid':
          statusColor = Colors.green;
          break;
        case 'Partially Paid':
          statusColor = Colors.blue;
          break;
        case 'Refunded':
          statusColor = Colors.purple;
          break;
        case 'Pending':
        default:
          statusColor = Colors.grey;
          break;
      }
    } else if (label == 'Booking Status') {
      switch (value) {
        case 'Success':
          statusColor = Colors.green;
          break;
        case 'Cancelled':
          statusColor = Colors.red;
          break;
        case 'Pending':
        default:
          statusColor = Colors.grey;
          break;
      }
    } else {
      statusColor = Colors.grey;
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey[700])),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
