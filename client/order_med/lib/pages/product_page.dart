import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/service/product_service.dart';
import 'package:order_med/widgets/cart_button.dart';
import 'package:order_med/widgets/quantity_counter.dart';
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
  int quantity = 1;

  Future<Product> getProduct(String id) async {
    return await ProductService.instance.getProduct(id);
  }

  setProductImage() => ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'location-img-${product.id}',
          child: CachedNetworkImage(
              height: 300,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
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
        child: Column(
          children: [
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            // const SizedBox(height: 1),
            Text(
              '(${product.weightInGrams}g)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            )
          ],
        ),
      );
  setProductDetails() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Text(
                    //   // (model.calculateDiscount > 0)
                    //   (product.price > 0) ? "₹${product.price}" : "",
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     // color: model.calculateDiscount > 0
                    //     color: product.price > 0 ? Colors.red : Colors.black,
                    //     // decoration: model.productSalePrice > 0
                    //     decoration: product.price > 0
                    //         ? TextDecoration.lineThrough
                    //         : null,
                    //   ),
                    // ),
                    Text(
                      // (model.calculateDiscount > 0)
                      //     ? " ${Config.currency}${model.productSalePrice.toString()}"
                      //     : "",
                      (product.price > 0) ? " ₹${product.price}" : "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Text(
                      "SHARE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    label: const Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 20,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                product.quantityAvailable > 0
                    ? "In Stock: ${product.quantityAvailable}"
                    : "Product Out of Stock!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (!product.doesRequirePrescription &&
                product.quantityAvailable > 0)
              Card(
                color: Colors.amber,
                margin: const EdgeInsets.only(top: 8),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Icon(
                          Icons.info_rounded,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'An image of prescription will be required to order this product.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[300],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                    'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ipsam, a, officiis ducimus velit necessitatibus numquam sapiente quam modi, aut voluptate molestias eius perferendis voluptatibus? Provident hic enim recusandae reiciendis rerum.'),
              ),
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
              var addToCart = ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: (isAvailable && !isInCart)
                    ? () {
                        context.read<Cart>().add(product, quantity);
                      }
                    : null,
                icon: const Icon(Icons.add_shopping_cart_rounded),
                label: Padding(
                  padding: const EdgeInsets.all(10),
                  child: isInCart
                      ? const Text('Added to My Cart')
                      : const Text('Add to My Cart'),
                ),
              );
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
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      setProductImage(),
                      setProductName(),
                      setProductDetails()
                    ],
                  ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantityCounter(
                          upperLimit: product.quantityAvailable,
                          onChanged: (quantity) => this.quantity = quantity),
                      Center(
                          child: !product.doesRequirePrescription &&
                                  isAvailable &&
                                  !isInCart
                              ? Badge(
                                  position:
                                      BadgePosition.topEnd(top: -5, end: 5),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  animationType: BadgeAnimationType.scale,
                                  badgeContent: const Text(
                                    '!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: addToCart,
                                )
                              : addToCart),
                    ],
                  ),
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
