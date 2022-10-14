import 'package:flutter/material.dart';
import 'package:order_med/model/order_model.dart';

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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style:
                      const TextStyle(fontStyle: FontStyle.italic, fontSize: 8),
                ),
                Row(
                  children: [
                    Column(children: [
                      Image.network(
                        'https://images.newscientist.com/wp-content/uploads/2019/06/18153152/medicineshutterstock_1421041688.jpg',
                        fit: BoxFit.fill,
                        height: 60,
                      )
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
                          order.id!,
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
      onTap: () => Navigator.pushNamed(context, '/home'),
    );
  }
}
