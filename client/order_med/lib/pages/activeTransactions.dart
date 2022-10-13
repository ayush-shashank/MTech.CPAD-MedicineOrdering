import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_med/model/product.dart';
import 'package:order_med/service/networkService.dart';
import 'package:order_med/widgets/productCard.dart';

class ActiveTransactions extends StatefulWidget {
  const ActiveTransactions({super.key});

  @override
  State<ActiveTransactions> createState() => _ActiveTransactionsState();
}

class _ActiveTransactionsState extends State<ActiveTransactions> {
  List<Widget> products = [];
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
    List resList = jsonDecode(res) as List;
    Iterable<Product> productList =
        resList.map((data) => Product.fromJson(data));
    List<Widget> widgetList =
        productList.map((product) => ProductCard(product: product)).toList();
    setState(() {
      products = widgetList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: ListTile(
                title: Text('Active Transactions'),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: products),
            )
          ],
        ),
      ),
    );
  }
}
