import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/booking/bookings/booking_add.dart';
import 'package:flutter_frontend/pages/booking/bookings/booking_view.dart';

class BookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Bookings', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            BookingCard(
              customerName: 'John Doe',
              bookingId: 'FA123554',
              submissionDate: '11/24/24',
              bookingDate: '01/01/25',
              paymentStatus: 'Fully Paid',
              bookingStatus: 'Success',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewBookingPage(
                      bookingId: 'FA123554',
                      customerName: 'John Doe',
                      eventName: 'Happy Gathering',
                      bookingDate: '01/01/25',
                      customerEmail: 'john.doe@gmail.com',
                      contactNumber: '09123456789',
                      numberOfAttendees: 50,
                      location: 'Azuela Cove, Davao City',
                      paymentStatus: 'Fully Paid',
                      bookingStatus: 'Success',
                    ),
                  ),
                );
              },
            ),
            BookingCard(
              customerName: 'Jane Smith',
              bookingId: 'FA123555',
              submissionDate: '11/24/24',
              bookingDate: '01/10/25',
              paymentStatus: 'Pending',
              bookingStatus: 'Cancelled',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewBookingPage(
                      bookingId: 'FA123555',
                      customerName: 'Jane Smith',
                      eventName: 'Birthday Bash',
                      bookingDate: '01/10/25',
                      customerEmail: 'jane.smith@gmail.com',
                      contactNumber: '0987654321',
                      numberOfAttendees: 30,
                      location: 'SM Lanang, Davao City',
                      paymentStatus: 'Pending',
                      bookingStatus: 'Cancelled',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookingScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class BookingCard extends StatelessWidget {
  final String customerName;
  final String bookingId;
  final String submissionDate;
  final String bookingDate;
  final String paymentStatus;
  final String bookingStatus;
  final VoidCallback onTap;

  BookingCard({
    required this.customerName,
    required this.bookingId,
    required this.submissionDate,
    required this.bookingDate,
    required this.paymentStatus,
    required this.bookingStatus,
    required this.onTap,
  });

  Color getPaymentColor() {
    switch (paymentStatus) {
      case 'Fully Paid':
        return Colors.green;
      case 'Partially Paid':
        return Colors.blue;
      case 'Refunded':
        return Colors.purple;
      case 'Pending':
      default:
        return Colors.grey;
    }
  }

  Color getStatusColor() {
    switch (bookingStatus) {
      case 'Success':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6),
              Text('Booking ID: $bookingId',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetail('Submission Date', submissionDate),
                      SizedBox(height: 6),
                      _buildDetail('Booking Date', bookingDate),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildLabeledStatus(
                          'Payment Status', paymentStatus, getPaymentColor()),
                      SizedBox(height: 6),
                      _buildLabeledStatus(
                          'Booking Status', bookingStatus, getStatusColor()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.black54)),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(value, style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildLabeledStatus(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
