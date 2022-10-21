import 'package:flutter/material.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/service/product_service.dart';
import 'package:order_med/widgets/cart_button.dart';

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
        transitionOnUserGestures: true,
        tag: 'location-img-${product.id}',
        child: Image.network(
            '${globals.baseUrl}/assets/img/${product.id}/0.jpg',
            // height: 240,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
            errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) =>
                const Center(
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 100,
                    color: Colors.amber,
                  ),
                )),
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
          Container(
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
          )
        ],
      );
  // Widget _shoppingCartBadge() {
  //   return Badge(
  //     position: BadgePosition.topEnd(top: 0, end: 3),
  //     animationDuration: const Duration(milliseconds: 300),
  //     animationType: BadgeAnimationType.slide,
  //     badgeContent: Text(
  //       globals.cart.orders.length.toString(),
  //       style: const TextStyle(color: Colors.white),
  //     ),
  //     child:
  //         IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProduct(productId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.hasData) {
            product = snapshot.data!;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  title: const Text(
                    'Product Detail',
                    style: TextStyle(shadows: [
                      Shadow(offset: Offset(2, 2), blurRadius: 2.5)
                    ]),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: const [CartButton()],
                  iconTheme: const IconThemeData(color: Colors.white, shadows: [
                    Shadow(offset: Offset(2, 2), blurRadius: 2.5)
                  ])),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  setProductImages(),
                  setProductName(),
                  setProductDetails()
                ],
              ),
              persistentFooterButtons: [
                Center(
                  child: Card(
                    child: ElevatedButton(
                      onPressed: (product.quantityAvailable > 0)
                          ? () {
                              print("Added to cart");
                              setState(() {
                                globals.cart.orders
                                    .add(ProductQuantity(product, 1));
                              });
                            }
                          : null,
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
          return const Center(
            child: Text('Loading Product Details...'),
          );
        });
  }
}
