import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/booking/pending_approval/pending_details.dart';

class PendingListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE4E1), // Light background color
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Pending Bookings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            BookingCard(
              customerName: 'John Doe',
              submissionDate: '11/24/24',
              bookingDate: '01/01/25',
              status: 'Pending',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PendingDetailsScreen(
                      customerName: 'John Doe',
                      eventName: 'Happy Gathering',
                      bookingDate: '01/01/25',
                      customerEmail: 'john.doe@gmail.com',
                      contactNumber: '09123456789',
                      numberOfAttendees: 50,
                      location: 'Azuela Cove, Davao City',
                    ),
                  ),
                );
              },
            ),
            BookingCard(
              customerName: 'Jane Smith',
              submissionDate: '11/24/24',
              bookingDate: '01/10/25',
              status: 'Pending',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PendingDetailsScreen(
                      customerName: 'Jane Smith',
                      eventName: 'Birthday Bash',
                      bookingDate: '01/10/25',
                      customerEmail: 'jane.smith@gmail.com',
                      contactNumber: '0987654321',
                      numberOfAttendees: 30,
                      location: 'SM Lanang, Davao City',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String customerName;
  final String submissionDate;
  final String bookingDate;
  final String status;
  final VoidCallback onTap;

  BookingCard({
    required this.customerName,
    required this.submissionDate,
    required this.bookingDate,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    customerName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  _buildStatusChip(status),
                ],
              ),
              SizedBox(height: 10),
              _buildDetailRow(
                  Icons.calendar_today, 'Booking Date:', bookingDate),
              SizedBox(height: 6),
              _buildDetailRow(Icons.schedule, 'Submitted On:', submissionDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        SizedBox(width: 6),
        Text(
          label,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;

    switch (status) {
      case 'Pending':
        chipColor = Colors.orange;
        break;
      case 'Approved':
        chipColor = Colors.green;
        break;
      case 'Rejected':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
