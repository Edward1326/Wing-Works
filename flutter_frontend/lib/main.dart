import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/inventory/inventory_main_s.dart';
import 'screens/inventory/login/login_s.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wings on Wheels',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFFFE8E0),
        primaryColor: const Color(0xFFB71C1C),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/inventory': (context) => const InventoryMainScreen(),
      },
    );
  }
}
