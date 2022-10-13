import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:order_med/pages/activeTransactions.dart';
import 'package:order_med/model/productModel.dart';
import 'package:order_med/pages/dashboard.dart';
import 'package:order_med/service/networkService.dart';

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
        '/': (context) => const Dashboard(),
        '/home': (context) => const MyHomePage(title: 'Online Medical Order'),
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
    getProducts();
  }

  void getProducts() async {
    String res = await Service.fetch('/product');
    // String val = await Service.fetch('/user/login', body: {
    //   "email": "gianni.hills@yahoo.com",
    //   "password": "4tKj8iA_zgj3h4g"
    // });
    List li = jsonDecode(res) as List;
    Iterable prodList = li.map((data) => Product.fromJson(data));
    print(prodList);
    setState(() {
      resVal = 'prodList';
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
