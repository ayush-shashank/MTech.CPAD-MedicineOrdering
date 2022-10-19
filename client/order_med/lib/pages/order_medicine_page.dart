import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/service/product_service.dart';
import 'package:order_med/service/search_delegate.dart';
import 'package:order_med/widgets/latest_transactions.dart';

class OrderMedicinePage extends StatelessWidget {
  const OrderMedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Medicine'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                tooltip: 'Search Medicines',
                icon: const Icon(Icons.search),
                onPressed: () async {
                  List<Product> products =
                      await ProductService.instance.getAllProducts();
                  showSearch(
                      context: context,
                      delegate: ProductSearchDelegate(products));
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              LatestTransactions(),
            ],
          ),
        ));
  }
}
