import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/widgets/cart_item_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:async';

final formatCurrency = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2,
  symbol: '₹ ',
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
    return Scaffold(
      appBar: AppBar(
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
            Icon(
              Icons.shopping_cart,
              size: 20,
            ),
            Text(' Cart'),
          ])),
      body: context.read<Cart>().items.isEmpty
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
      bottomSheet: Row(children: [
        const Expanded(
            child: Text(
          "Cart Total :",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        Expanded(
          child: Text(
            '${formatCurrency.format(Cart.total)}/-',
            textAlign: TextAlign.end,
          ),
        )
      ]),
    );
  }
}
