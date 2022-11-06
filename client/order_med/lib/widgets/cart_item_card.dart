import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/widgets/upload_prescription.dart';
import 'package:provider/provider.dart';
import 'package:order_med/globals.dart' as globals;

final formatCurrency = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2,
  symbol: '₹',
);

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final int index;

  const CartItemWidget({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  _customCatch(BuildContext context, Object err) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[600],
        duration: const Duration(milliseconds: 500),
        content: Text(err.toString().split(':')[1].substring(1))));
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    CartItem item = widget.item;
    Cart cart = context.read<Cart>();
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      try {
                        cart.incrementQuantity(index);
                      } catch (err) {
                        _customCatch(context, err);
                      }
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: 20, child: Text('${item.quantity}')),
                  IconButton(
                    onPressed: () {
                      try {
                        cart.decrementQuantity(index);
                      } catch (err) {
                        _customCatch(context, err);
                      }
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                    '${globals.baseUrl}/assets/img/${item.product.id}/0.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    semanticLabel: 'Image',
                    errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) =>
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 50,
                          color: Colors.amber,
                        )),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(formatCurrency.format(item.orderTotal)),
              const SizedBox(width: 4),
              IconButton(
                  onPressed: () {
                    context.read<Cart>().remove(index);
                  },
                  icon: const Icon(
                    Icons.remove_shopping_cart_rounded,
                    color: Colors.red,
                  ))
            ],
          ),
          UploadPrescription(item: item, index: index)
        ],
      ),
    );
  }
}
