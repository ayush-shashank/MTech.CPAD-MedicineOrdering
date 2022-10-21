import 'package:flutter/material.dart';
import 'package:order_med/globals.dart' as globals;

class CartPage extends StatelessWidget {
  static const String routeName = '/cart';

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart ${const Icon(Icons.shopping_cart)}')),
      body: Text(globals.cart.toString()),
    );
  }
}
