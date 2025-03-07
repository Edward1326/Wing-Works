import 'package:flutter/material.dart';
import 'home_page.dart';
import 'simple_login_page.dart';
import 'login_page.dart';
import 'create_account_page.dart';
import 'success_page.dart';

class WebpagePage extends StatefulWidget {
  const WebpagePage({super.key});

  @override
  State<WebpagePage> createState() => _WebpagePageState();
}

class _WebpagePageState extends State<WebpagePage> {
  int _currentPage = 0;

  void _navigateToPage(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog(
          onBookNowTap: () {
            Navigator.of(context).pop();
            _navigateToPage(2);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFFB71C1C),
      ),
      home: IndexedStack(
        index: _currentPage,
        children: [
          HomePage(),
          SimpleLoginPage(
            onLoginTap: () => _navigateToPage(2),
          ),
          LoginAccountPage(
            onCreateAccountTap: () => _navigateToPage(3),
          ),
          CreateAccountPage(
            onLoginTap: () => _navigateToPage(2),
            onRegisterTap: _showSuccessDialog,
          ),
        ],
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) =>
            SimpleLoginPage(onLoginTap: () => _navigateToPage(2)),
        '/login-account': (context) =>
            LoginAccountPage(onCreateAccountTap: () => _navigateToPage(3)),
        '/create-account': (context) => CreateAccountPage(
              onLoginTap: () => _navigateToPage(2),
              onRegisterTap: _showSuccessDialog,
            ),
      },
    );
  }
}
