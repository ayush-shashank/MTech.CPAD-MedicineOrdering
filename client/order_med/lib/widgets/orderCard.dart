import 'package:flutter/material.dart';
import 'package:order_med/model/orderModel.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                    Text(order.productId,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    Text(
                      order.customerId,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      '₹ ${order.qty.toString()}',
                      style: const TextStyle(fontSize: 28),
                    )
                  ],
                ),
              ],
            )),
      ),
      onTap: () => Navigator.pushNamed(context, '/home'),
    );
  }
}
