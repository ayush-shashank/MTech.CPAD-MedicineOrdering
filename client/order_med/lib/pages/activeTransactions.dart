import 'package:flutter/material.dart';
import 'package:order_med/model/orderModel.dart';
import 'package:order_med/model/productModel.dart';
import 'package:order_med/service/orderService.dart';
import 'package:order_med/service/productService.dart';
import 'package:order_med/widgets/orderCard.dart';
import 'package:order_med/widgets/productCard.dart';

class ActiveTransactions extends StatefulWidget {
  const ActiveTransactions({super.key});

  @override
  State<ActiveTransactions> createState() => _ActiveTransactionsState();
}

class _ActiveTransactionsState extends State<ActiveTransactions> {
  List<Widget> orders = [];
  @override
  void initState() {
    super.initState();
    getActiveTransactions();
  }

  void getActiveTransactions() async {
    List<Order> orderList = await OrderService().getActiveTransactions();
    // List<Product> orderList = await ProductService().getAllProducts();
    // String val = await Service.fetch('/user/login', body: {
    //   "email": "gianni.hills@yahoo.com",
    //   "password": "4tKj8iA_zgj3h4g"
    // });
    List<Widget> widgetList =
        orderList.map((order) => OrderCard(order: order)).toList();
    // orderList.map((order) => ProductCard(product: order)).toList();
    setState(() {
      orders = widgetList;
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
            Column(children: orders)
          ],
        ),
      ),
    );
  }
}
