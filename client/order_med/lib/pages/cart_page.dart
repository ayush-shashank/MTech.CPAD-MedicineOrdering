import 'package:flutter/material.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/service/order_service.dart';
import 'package:order_med/widgets/cart_item_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
    bool isEmpty = context.read<Cart>().items.isEmpty;
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: Colors.grey.shade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      formatCurrency.format(context.watch<Cart>().total),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.teal),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          //     textStyle:
                          //         MaterialStateProperty.resolveWith((states) {
                          //       if (states.contains(MaterialState.disabled)) {
                          //         return TextStyle(color: Colors.grey.shade200);
                          //       }
                          //       return const TextStyle(color: Colors.white);
                          //     }),
                          //     backgroundColor:
                          //         MaterialStateProperty.resolveWith((states) {
                          //       if (states.contains(MaterialState.disabled)) {
                          //         return Colors.grey.shade900;
                          //       }
                          //       return Colors.teal.shade700;
                          //     }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ))),
                      onPressed: context.watch<Cart>().isGood()
                          ? () {
                              // TODO: Place order
                              context.read<Cart>().items.forEach((item) {
                                OrderService.instance.placeOrder(item);
                              });
                              print('placed order');
                            }
                          : null,
                      child: const Text(
                        'Place Order',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
    );
  }
}
