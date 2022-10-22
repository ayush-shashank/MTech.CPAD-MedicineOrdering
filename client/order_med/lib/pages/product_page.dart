import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/service/product_service.dart';
import 'package:order_med/widgets/cart_button.dart';
import 'package:provider/provider.dart';

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
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'location-img-${product.id}',
          child: Image.network(
            '${globals.baseUrl}/assets/img/${product.id}/0.jpg',
            height: 240,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
            errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) =>
                const Center(
              child: Icon(
                Icons.warning_amber_rounded,
                size: 100,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      );
  setProductName() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        child: Text(
          product.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  setProductDetails() => Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weight: ${product.weightInGrams}g'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.teal),
                  color: Colors.grey[300],
                  // shape: const RoundedRectangleBorder(),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const Text(
                  'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ipsam, a, officiis ducimus velit necessitatibus numquam sapiente quam modi, aut voluptate molestias eius perferendis voluptatibus? Provident hic enim recusandae reiciendis rerum.'),
            ),
            product.quantityAvailable > 0
                ? Text('In Stock: ${product.quantityAvailable}')
                : Container(
                    margin: const EdgeInsets.all(0),
                    child: const Text("Product Out of Stock!"),
                  ),
          ],
        ),
      );

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
            bool isInCart = context
                .watch<Cart>()
                .items
                .any((element) => element.product.id == product.id);
            bool isAvailable = product.quantityAvailable > 0;
            var addToCart = ElevatedButton(
                onPressed: (isAvailable && !isInCart)
                    ? () {
                        product.doesRequirePrescription
                            // TODO: Attach prescription
                            ? context.read<Cart>().add(product)
                            : context.read<Cart>().add(product);
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: isInCart
                      ? const Text('Added to cart')
                      : const Text('Add to cart'),
                ));
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
              bottomSheet: product.doesRequirePrescription
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                      decoration: const BoxDecoration(color: Colors.red),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: const Icon(
                              Icons.info_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'An image of prescription will be required to order this product. Please attach the image while adding the product to the cart.',
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
              persistentFooterButtons: [
                Center(
                    child: product.doesRequirePrescription &&
                            isAvailable &&
                            !isInCart
                        ? Badge(
                            position: BadgePosition.topEnd(top: -15, end: -7.5),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            animationType: BadgeAnimationType.scale,
                            badgeContent: const Text(
                              '!',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: addToCart,
                          )
                        : addToCart)
              ],
            );
          }
          return const Center(
            child: Text('Loading Product Details...'),
          );
        });
  }
}
