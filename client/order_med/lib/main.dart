import 'package:flutter/material.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/service/router_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => Cart())],
        child: const MyApp()),
  );
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
