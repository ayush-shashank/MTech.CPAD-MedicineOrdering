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

  setProductImages() => ClipRRect(
          child: Hero(
        tag: 'location-img-${product.id}',
        child: Image.network(
          '${globals.baseUrl}/assets/img/${product.id}/0.jpg',
          // height: 240,
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        ),
      ));

  setProductName() => Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          product.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromARGB(255, 30, 30, 30)),
        ),
      );
  setProductDetails() => Column(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(10))),
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Prescription Required? - ${product.doesRequirePrescription ? "Yes" : "No"}'),
                    const Text('Product Description'),
                    Text('In Stock: ${product.quantityAvailable}'),
                    Text('Weight: ${product.weightInGrams}g'),
                  ],
                ),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
                tooltip: 'Cart',
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart)),
          )
        ],
      ),
      body: FutureBuilder(
          future: getProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container();
            }
            if (snapshot.hasData) {
              product = snapshot.data!;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    setProductImages(),
                    setProductName(),
                    setProductDetails()
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Loading...'),
            );
          }),
      persistentFooterButtons: [
        Center(
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Text('Add to cart'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
