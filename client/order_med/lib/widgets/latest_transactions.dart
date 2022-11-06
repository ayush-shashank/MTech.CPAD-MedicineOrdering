import 'package:flutter/material.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/model/order_model.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/service/order_service.dart';
import 'package:order_med/service/product_service.dart';
import 'package:order_med/widgets/order_card.dart';
import 'package:provider/provider.dart';

class LatestTransactions extends StatefulWidget {
  const LatestTransactions({super.key});

  @override
  State<LatestTransactions> createState() => _LatestTransactionsState();
}

class _LatestTransactionsState extends State<LatestTransactions> {
  repeatOrder(BuildContext context, Order order) async {
    Product product = await ProductService.instance.getProduct(order.productId);
    if (!mounted) return;
    Cart cart = context.read<Cart>();
    try {
      cart.add(product, order.quantity);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[600],
          duration: const Duration(milliseconds: 250),
          content: Text(err.toString().split(':')[1].substring(1))));
      print(err);
    }
    // Navigator.of(context).pushNamed(CartPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: OrderService.instance.getLatestTransactions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Could Not Fetch Data!"));
        }
        if (snapshot.hasData) {
          List<Order> orders = snapshot.data!;
          if (orders.isNotEmpty) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orders.length < 3 ? orders.length : 3,
                itemBuilder: (context, index) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: OrderCard(order: orders[index]),
                        ),
                        Card(
                          margin: const EdgeInsets.only(right: 4),
                          elevation: 4,
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              // Add to Cart
                              repeatOrder(context, orders[index]);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.amber,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.replay_circle_filled_rounded,
                                    size: 32,
                                  ),
                                  Text('Repeat'),
                                  Text('Order'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]);
                });
          }
          return const Center(child: Text("No Transactions"));
        }
        return const LinearProgressIndicator(
          minHeight: 10,
        );
      },
    );
  }
}
