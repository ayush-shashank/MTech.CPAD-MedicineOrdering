import 'package:flutter/material.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
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
                return Card(
                  child: InkWell(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Cart.incrementQuantity(index);
                                setState(() {});
                                print("++");
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Text('${item.quantity}'),
                            ),
                            IconButton(
                              onPressed: () {
                                Cart.decrementQuantity(index);
                                setState(() {});
                                print("--");
                              },
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        Text(
                          item.product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' (Avail. ${item.product.quantityAvailable})',
                        ),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {
                              context.read<Cart>().remove(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
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
