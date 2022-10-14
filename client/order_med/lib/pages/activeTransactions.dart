import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_med/model/order_model.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/service/order_service.dart';
import 'package:order_med/service/product_service.dart';
import 'package:order_med/widgets/order_card.dart';

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
    List<Order> orderList = await OrderService.instance.getActiveTransactions();
    List<Widget> widgetList =
        orderList.map((order) => OrderCard(order: order)).toList();
    setState(() {
      orders = widgetList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Center(
                  child: Text(
                'Active Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 8,
              ),
              Column(children: orders)
            ],
          ),
        ),
      ),
    );
  }
}
