import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/booking/bookings/booking_add.dart';
import 'package:flutter_frontend/pages/booking/bookings/booking_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_frontend/pages/booking/bookings/booking_view.dart';

class BookingsScreen extends StatefulWidget {
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  List<dynamic> bookings = [];
  List<dynamic> filteredBookings = [];
  bool isLoading = true; // Track if data is still loading
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    String apiUrl = "http://10.0.2.2:8000/api/bookings/list/";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          bookings = jsonDecode(response.body);
          filteredBookings = bookings; // Initially, show all bookings
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to Load Bookings")),
        );
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Connecting to Server")),
      );
    }
  }

  // 🔍 Search functionality (filters by customer name or event name)
  void searchBookings(String query) {
    setState(() {
      filteredBookings = bookings.where((booking) {
        final customerName = booking['customer_name'].toLowerCase();
        final eventName = booking['event_name'].toLowerCase();
        final searchLower = query.toLowerCase();

        return customerName.contains(searchLower) ||
            eventName.contains(searchLower);
      }).toList();
    });
  }

  // 🔄 Clear search and restore original bookings list
  void clearSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      filteredBookings = bookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB51616),
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search bookings...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: searchBookings,
              )
            : Text('Bookings', style: TextStyle(color: Colors.white)),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: clearSearch, // Closes search bar
                )
              : IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
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
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner
            : filteredBookings.isEmpty
                ? Center(
                    child: Text(
                      "No bookings found",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];

                      return BookingCard(
                        eventName: booking['event_name'],
                        customerName: booking['customer_name'],
                        bookingId: booking['id'].toString(),
                        submissionDate: booking['booking_date'],
                        bookingDate: booking['booking_date'],
                        paymentStatus: booking['payment_status'],
                        bookingStatus: booking['booking_status'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewBookingPage(
                                bookingId: booking['id'].toString(),
                                customerName: booking['customer_name'],
                                eventName: booking['event_name'],
                                bookingDate: booking['booking_date'],
                                customerEmail: booking['customer_email'],
                                contactNumber: booking['customer_contact'],
                                numberOfAttendees: booking['head_count'],
                                location: booking['location'],
                                paymentStatus: booking['payment_status'],
                                bookingStatus: booking['booking_status'],
                              ),
                            ),
                          );
                        },
                      );
                    },
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
