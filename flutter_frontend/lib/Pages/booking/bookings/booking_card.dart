import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String eventName; // Added event name
  final String customerName;
  final String bookingId;
  final String submissionDate;
  final String bookingDate;
  final String paymentStatus;
  final String bookingStatus;
  final VoidCallback onTap;

  BookingCard({
    required this.eventName,
    required this.customerName,
    required this.bookingId,
    required this.submissionDate,
    required this.bookingDate,
    required this.paymentStatus,
    required this.bookingStatus,
    required this.onTap,
  });

  // Map short statuses to full names (handling lowercase as well)
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
  String getFullPaymentStatus() {
    return paymentStatusMap[paymentStatus.toUpperCase()] ?? paymentStatus;
  }

  String getFullBookingStatus() {
    return bookingStatusMap[bookingStatus.toUpperCase()] ?? bookingStatus;
  }

  // Get color based on payment status
  Color getPaymentColor() {
    switch (getFullPaymentStatus()) {
      case "Fully Paid":
        return Colors.green;
      case "Partially Paid":
        return Colors.blue;
      case "Refunded":
        return Colors.purple;
      case "Pending":
      default:
        return Colors.grey;
    }
  }

  // Get color based on booking status
  Color getStatusColor() {
    switch (getFullBookingStatus()) {
      case "Success":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      case "Pending":
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
              // Event Title (Primary)
              Text(
                eventName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              // Customer Name (Secondary)
              Text(
                "By: $customerName",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
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
                      _buildLabeledStatus('Payment Status',
                          getFullPaymentStatus(), getPaymentColor()),
                      SizedBox(height: 6),
                      _buildLabeledStatus('Booking Status',
                          getFullBookingStatus(), getStatusColor()),
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
