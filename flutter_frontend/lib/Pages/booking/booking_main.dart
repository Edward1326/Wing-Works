import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/booking/bookings/booking_list.dart';
import 'package:flutter_frontend/pages/booking/pending_approval/pending_list.dart';
import 'package:flutter_frontend/pages/create_order/create_order.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: Text('Booking', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No new notifications")),
              );
            },
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: Container(
        color: Color(0xFFFFE4E1),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green, size: 30),
              title: Text(' Bookings', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingsScreen()),
                );
              },
            ),
            Divider(color: Colors.black),
            ListTile(
              leading:
                  Icon(Icons.hourglass_top, color: Colors.orange, size: 30),
              title: Text('Pending Approval', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PendingListScreen()),
                );
              },
            ),
            Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
