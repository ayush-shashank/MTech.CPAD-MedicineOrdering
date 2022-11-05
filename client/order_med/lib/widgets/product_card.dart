import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/pages/product_page.dart';

final formatCurrency = NumberFormat.compactCurrency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2,
  symbol: '₹',
);

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: product.discount > 0,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Text(
                            "${product.discount}% OFF",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )))),
              GestureDetector(
                child: Hero(
                  tag: 'location-img-${product.id}',
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: '${globals.baseUrl}/${product.productImage}',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/img/product-placeholder-wp.jpg'),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductPage.routeName,
                    arguments: product.id,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 10),
                child: Text(
                  product.name,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Text(formatCurrency.format(product.price),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                color: product.discount > 0
                                    ? Colors.red
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: product.salePrice > 0
                                    ? TextDecoration.lineThrough
                                    : null,
                              )),
                          Text(
                            (product.discount > 0)
                                ? " ${formatCurrency.format(product.salePrice)}"
                                : "",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const FavIcon()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class FavIcon extends StatefulWidget {
  const FavIcon({Key? key}) : super(key: key);

  @override
  State<FavIcon> createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> {
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.favorite,
        color: fav ? Colors.red : Colors.grey,
        size: 20,
      ),
      onTap: () {
        fav = !fav;
        setState(() {});
      },
    );
  }
}
