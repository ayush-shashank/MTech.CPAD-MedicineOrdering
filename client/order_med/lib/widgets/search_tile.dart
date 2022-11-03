import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/pages/product_page.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2,
  symbol: '₹ ',
);

class SearchTile extends StatelessWidget {
  final Product product;

  const SearchTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (() => Navigator.of(context)
          .pushNamed(ProductPage.routeName, arguments: product.id)),
      contentPadding: const EdgeInsets.all(10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text('${product.weightInGrams}g',
              style: TextStyle(color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'location-img-${product.id}',
          child: CachedNetworkImage(
              imageUrl: '${globals.baseUrl}/${product.productImage}',
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/img/product-placeholder-wp.jpg')),
        ),
      ),
      trailing: Text(formatCurrency.format(product.price)),
    );
  }
}
