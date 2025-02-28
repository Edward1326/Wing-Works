import 'package:flutter/material.dart';

class PendingDetailsScreen extends StatelessWidget {
  final String customerName;
  final String eventName;
  final String bookingDate;
  final String customerEmail;
  final String contactNumber;
  final int numberOfAttendees;
  final String location;

  PendingDetailsScreen({
    required this.customerName,
    required this.eventName,
    required this.bookingDate,
    required this.customerEmail,
    required this.contactNumber,
    required this.numberOfAttendees,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE4E1),
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Booking Details', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Scrollable booking details inside the card
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(
                          Icons.person, 'Customer Name', customerName),
                      _buildInfoCard(Icons.event, 'Event Name', eventName),
                      _buildInfoCard(
                          Icons.calendar_today, 'Booking Date', bookingDate),
                      _buildInfoCard(
                          Icons.email, 'Customer Email', customerEmail),
                      _buildInfoCard(
                          Icons.phone, 'Contact Number', contactNumber),
                      _buildInfoCard(Icons.people, 'Number of Attendees',
                          numberOfAttendees.toString()),
                      _buildInfoCard(Icons.location_on, 'Location', location),
                      SizedBox(
                          height:
                              10), // Small spacing at the bottom of the card
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Buttons fixed at the bottom
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('Reject', Colors.red, Icons.close),
                _buildActionButton('Accept', Colors.green, Icons.check),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, IconData icon) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
