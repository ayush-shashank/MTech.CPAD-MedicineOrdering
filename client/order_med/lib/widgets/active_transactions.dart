import 'package:flutter/material.dart';
import 'package:order_med/model/order_model.dart';
import 'package:order_med/service/order_service.dart';
import 'package:order_med/widgets/order_card.dart';

class ActiveTransactions extends StatefulWidget {
  ActiveTransactions({super.key});

  @override
  State<ActiveTransactions> createState() => _ActiveTransactionsState();
}

class _ActiveTransactionsState extends State<ActiveTransactions> {
  List<Order> orderList = [];
  @override
  void initState() {
    super.initState();
    getActiveTransactions();
  }

  void getActiveTransactions() async {
    orderList = await OrderService.instance.getActiveTransactions();
    if (orderList.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return orderList.isEmpty
        ? const Center(child: Text("No Transactions"))
        : Expanded(
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  order: orderList[index],
                  repeat: false,
                );
              },
            ),
          );
  }
}
