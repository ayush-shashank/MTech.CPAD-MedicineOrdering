import 'package:flutter/material.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/pages/dashboard_page.dart';
import 'package:order_med/service/order_service.dart';
import 'package:provider/provider.dart';

class OrderProcessingPage extends StatefulWidget {
  static const String routeName = '/orderProcessing';
  const OrderProcessingPage({Key? key}) : super(key: key);

  @override
  State<OrderProcessingPage> createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {
  double n = 0.0;
  String status = 'Processing Transactions...';

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => processOrders(context.read<Cart>()));
  }

  processOrders(Cart cart) async {
    List<CartItem> items = cart.items;
    for (int i = 0; i < items.length; ++i) {
      await Future.delayed(const Duration(seconds: 2));
      try {
        OrderService.instance.placeOrder(items[i]);
        setState(() {
          if (items.isNotEmpty) {
            n = (i + 1) / items.length;
          }
        });
      } catch (err) {
        print(err);
      }
    }
    cart.clear();
    setState(() {
      status = 'Processing Complete';
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      status = 'Redirecting';
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      DashboardPage.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing Transaction'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            value: n,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(status)
        ],
      )),
    );
  }
}
