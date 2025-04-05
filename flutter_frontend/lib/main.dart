import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_frontend/pages/create_order/create_order.dart';
import 'package:flutter_frontend/pages/login/login_page.dart';
import 'package:flutter_frontend/pages/orders/orders_list.dart';
import 'package:flutter_frontend/pages/inventory/inventory_main.dart';
import 'package:flutter_frontend/pages/financial/financial_main.dart';
import 'package:flutter_frontend/pages/booking/booking_main.dart';
import 'package:flutter_frontend/pages/employee/employee_main.dart';
>>>>>>> recovered-files

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp();
=======
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/createOrder': (context) => CreateOrderScreen(),
        '/orders': (context) => OrdersScreen(),
        '/inventory': (context) => InventoryScreen(),
        '/financial': (context) => FinancialScreen(),
        '/booking': (context) => BookingScreen(),
        '/employee': (context) => EmployeeScreen(),
      },
    );
>>>>>>> recovered-files
  }
}
