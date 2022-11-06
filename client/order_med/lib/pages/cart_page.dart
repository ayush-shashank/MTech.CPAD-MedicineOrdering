import 'package:flutter/material.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/pages/order_processing.dart';
import 'package:order_med/widgets/bottom_nav_bar.dart';
import 'package:order_med/widgets/cart_item_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2,
  symbol: '₹',
);

class CartPage extends StatefulWidget {
  static const String routeName = '/cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = context.read<Cart>().items.isEmpty;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 4),
      appBar: AppBar(
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
            Icon(
              Icons.shopping_cart,
              size: 20,
            ),
            Text(' My Cart'),
          ])),
      body: isEmpty
          ? const Center(child: Text("Cart is empty!"))
          : ListView.builder(
              itemCount: context.watch<Cart>().items.length,
              itemBuilder: (context, index) {
                CartItem item = context.watch<Cart>().items.elementAt(index);
                return CartItemWidget(
                  item: item,
                  index: index,
                );
              },
            ),
      bottomSheet: isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal.shade700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    formatCurrency.format(context.watch<Cart>().total),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          backgroundColor: Colors.white),
                      onPressed: context.watch<Cart>().isGood()
                          ? () => Navigator.pushNamed(
                              context, OrderProcessingPage.routeName)
                          : null,
                      icon: const Icon(
                        Icons.shopping_cart_checkout_rounded,
                        color: Colors.teal,
                      ),
                      label: const Text('Place Order',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          )))
                ],
              ),
            ),
    );
  }
}
