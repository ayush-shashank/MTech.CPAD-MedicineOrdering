import 'package:flutter/material.dart';
import 'package:order_med/model/order_model.dart';
import 'package:order_med/pages/product_page.dart';
import 'package:order_med/globals.dart' as globals;

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductPage.routeName,
          arguments: order.productId),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
            decoration: BoxDecoration(
              // color: Colors.amber,
              border: Border(
                  top: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 4.0,
              )),
            ),
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Order # ${order.id}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Image.network(
                            '${globals.baseUrl}/assets/img/${order.productId}/0.jpg',
                            fit: BoxFit.contain,
                            semanticLabel: 'Image',
                            errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) =>
                                const Center(
                                  child: Icon(
                                    Icons.warning_amber_rounded,
                                    size: 100,
                                    color: Colors.amber,
                                  ),
                                ))),
                    const SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(order.productName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          Text(
                            order.updatedAt.toString(),
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Quantity: ${order.quantity}',
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
