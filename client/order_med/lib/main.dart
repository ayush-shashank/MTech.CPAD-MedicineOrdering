import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:order_med/pages/activeTransactions.dart';
import 'package:order_med/pages/dashboard_page.dart';
import 'package:order_med/pages/login_page.dart';
import 'package:order_med/pages/product.dart';
import 'package:order_med/service/network_service.dart';
import 'package:order_med/globals.dart' as globals;

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
        '/': (context) => const MyHomePage(title: 'Online Medical Order'),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/orderMedicine': (context) => const Scaffold(),
        '/home': (context) => const MyHomePage(title: 'Online Medical Order'),
        '/product': (context) => const ProductPage(),
        '/activeTransactions': (context) => const ActiveTransactions()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String resVal = 'val';

  @override
  void initState() {
    super.initState();
    NetworkService.setBaseAddress();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (globals.isLoggedIn) {
        print('isLoggedIn');
        Navigator.pushNamed(context, '/dashboard');
      } else {
        print('isNotLoggedIn');
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(resVal),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
