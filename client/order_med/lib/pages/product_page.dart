import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/service/product_service.dart';

class ProductPage extends StatefulWidget {
  static const String routeName = '/product';
  final String productId;

  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState(productId);
}

class _ProductPageState extends State<ProductPage> {
  final String productId;
  late Product product;

  _ProductPageState(this.productId);

  Future<Product> getProduct(String id) async {
    return await ProductService.instance.getProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
        ),
        body: FutureBuilder(
            future: getProduct(productId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }

              if (snapshot.hasData) {
                product = snapshot.data!;
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(product.name),
                        Image.network(
                          '${globals.baseUrl}/assets/img/${product.id}/0.jpg',
                          fit: BoxFit.contain,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Product Description'),
                            Text('In Stock: ${product.quantityAvailable}'),
                            Text('Weight: ${product.weightInGrams}g'),
                            Text(
                                'Prescription Required? - ${product.doesRequirePrescription ? "Yes" : "No"}')
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            }));
  }
}
