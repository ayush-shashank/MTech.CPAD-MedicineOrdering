import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/service/product_service.dart';
import 'package:order_med/widgets/product_card.dart';

class ProductCatalogue extends StatefulWidget {
  const ProductCatalogue({super.key});

  @override
  State<ProductCatalogue> createState() => _ProductCatalogueState();
}

class _ProductCatalogueState extends State<ProductCatalogue> {
  late Future<List<Product>> products;

  @override
  initState() {
    super.initState();
    getFuture();
  }

  Future<List<Product>> getFuture() async {
    await Future.delayed(const Duration(seconds: 1));
    return ProductService.instance.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getFuture(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error fetching products!');
        }
        if (snapshot.hasData) {
          List<Product> products = snapshot.data!;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        }
        return const LinearProgressIndicator(
          minHeight: 10,
        );
      },
    );
  }
}
