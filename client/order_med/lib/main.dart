import 'package:flutter/material.dart';
import 'package:order_med/pages/under_construction.dart';
import 'package:order_med/widgets/active_transactions.dart';
import 'package:order_med/pages/dashboard_page.dart';
import 'package:order_med/pages/home_page.dart';
import 'package:order_med/pages/login_page.dart';
import 'package:order_med/pages/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'Online Medical Order'),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/orderMedicine': (context) => const Scaffold(),
        '/product': (context) => const ProductPage(),
        '/404': (context) => const UnderConstruction(),
      },
    );
  }
}
