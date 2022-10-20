import 'package:flutter/material.dart';
import 'package:order_med/service/router_service.dart';

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
      onGenerateRoute: RouterService.generateRoute,
      initialRoute: '/',
    );
  }
}
