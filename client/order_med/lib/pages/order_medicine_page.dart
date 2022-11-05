import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/service/product_service.dart';
import 'package:order_med/service/search_delegate.dart';
import 'package:order_med/widgets/cart_button.dart';
import 'package:order_med/widgets/latest_transactions.dart';
import 'package:order_med/widgets/product_catalogue.dart';

class OrderMedicinePage extends StatefulWidget {
  static const String routeName = '/orderMedicine';

  const OrderMedicinePage({super.key});

  @override
  State<OrderMedicinePage> createState() => _OrderMedicinePageState();
}

class _OrderMedicinePageState extends State<OrderMedicinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Order Medicine',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
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
            ),
            const CartButton()
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  'Latest Transactions',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const LatestTransactions(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  'Product Catalogue',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const ProductCatalogue(),
            ],
          ),
        ));
  }
}
