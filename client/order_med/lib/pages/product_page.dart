import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Product product;

  Future<Product> getProduct(String id) async {
    return await ProductService.instance.getProduct(id);
  }

  setProductImage() => ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'location-img-${product.id}',
          child: CachedNetworkImage(
              height: 240,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              imageUrl: '${globals.baseUrl}/${product.productImage}',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: LinearProgressIndicator(
                        value: downloadProgress.progress),
                  ),
              errorWidget: (context, url, error) => Center(
                  child: Image.asset('assets/img/product-placeholder-wp.jpg'))),
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
              margin: const EdgeInsets.symmetric(vertical: 12),
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
        future: getProduct(widget.productId),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.connectionState == ConnectionState.waiting) {
            child = const CircularProgressIndicator(key: ValueKey(0));
          } else {
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
                          context.read<Cart>().add(product, 1);
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: isInCart
                        ? const Text('Added to cart')
                        : const Text('Add to cart'),
                  ));
              child = Scaffold(
                key: const ValueKey(1),
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
                    iconTheme: const IconThemeData(
                        color: Colors.white,
                        shadows: [
                          Shadow(offset: Offset(2, 2), blurRadius: 2.5)
                        ])),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    setProductImage(),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: const Icon(
                                Icons.info_rounded,
                                color: Colors.white,
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                'An image of prescription will be required to order this product. Please attach the image while adding the product to the cart.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
                              position:
                                  BadgePosition.topEnd(top: -15, end: -7.5),
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
            } else {
              child = Container(
                key: const ValueKey(0),
              );
            }
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 750),
            child: child,
          );
        });
  }
}
