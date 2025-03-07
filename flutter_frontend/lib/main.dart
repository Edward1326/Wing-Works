import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/inventory/inventory_main_s.dart';
import 'screens/inventory/login/login_s.dart';
import 'webpage/webpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Is Web Platform: $kIsWeb");

    return MaterialApp(
      title: 'Wings on Wheels',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFB71C1C),
        fontFamily: 'Poppins',
      ),
      home: kIsWeb ? const WebpagePage() : const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/inventory': (context) => const InventoryMainScreen(),
      },
    );
  }
}
