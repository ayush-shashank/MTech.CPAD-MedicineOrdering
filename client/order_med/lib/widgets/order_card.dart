import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:order_med/model/order_model.dart';
import 'package:order_med/pages/product_page.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2,
  symbol: '₹ ',
);

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order # ${order.id}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'Ordered On ${formatDate(order.createdAt!, [
                          mm,
                          '-',
                          dd,
                          '-',
                          yyyy
                        ])}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                    ),
                  )),
                ],
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                minLeadingWidth: 50,
                leading: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                      '${globals.baseUrl}/assets/img/${order.productId}/0.jpg',
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
                title: Text(order.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Quantity: ${order.quantity}',
                ),
                trailing: Text(formatCurrency.format(order.orderAmount)),
              ),
              Text(
                'Last Updated On ${formatDate(order.updatedAt!, [
                      mm,
                      '-',
                      dd,
                      '-',
                      yyyy,
                      ' at ',
                      hh,
                      ':',
                      mm,
                      ' ',
                      am
                    ])}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 10,
                ),
              ),
            ],
          )),
    );
  }
}
