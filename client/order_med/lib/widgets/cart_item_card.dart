import 'package:flutter/material.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/widgets/upload_prescription.dart';
import 'package:provider/provider.dart';
import 'package:order_med/globals.dart' as globals;

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final int index;

  const CartItemWidget({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    CartItem item = widget.item;
    Cart cart = context.read<Cart>();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      cart.incrementQuantity(index);
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
                      cart.decrementQuantity(index);
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
          UploadPrescription(item: item, index: index)
        ],
      ),
    );
  }
}
