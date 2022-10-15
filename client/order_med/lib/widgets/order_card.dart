import 'package:flutter/material.dart';
import 'package:order_med/model/order_model.dart';
import 'package:order_med/globals.dart' as globals;

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Order # ${order.id}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(children: [
                      Image.network(
                          '${globals.baseUrl}/assets/img/${order.productId}/0.jpg',
                          fit: BoxFit.contain,
                          height: 100,
                          width: 100,
                          errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  size: 100,
                                  color: Colors.amber,
                                ),
                              ))
                    ]),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
              ],
            )),
      ),
      onTap: () => Navigator.pushNamed(context, '/product'),
    );
  }
}
