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
  bool done = false;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () => processOrders(context.read<Cart>()));
  }

  processOrders(Cart cart) async {
    List<CartItem> items = cart.items;
    for (int i = 0; i < items.length; ++i) {
      Future.delayed(const Duration(seconds: 1));
      try {
        OrderService.instance.placeOrder(items[i]);
        cart.remove(i);
        setState(() {
          n = i / items.length;
        });
      } catch (err) {
        print(err);
      }
    }
    Future.delayed(const Duration(seconds: 5));
    done = true;
    Navigator.of(context).pushReplacementNamed(DashboardPage.routeName);
    //, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing Transaction'),
      ),
      body: Center(
          child: done
              ? const Text('redirecting')
              : CircularProgressIndicator(
                  value: n,
                )),
    );
  }
}
