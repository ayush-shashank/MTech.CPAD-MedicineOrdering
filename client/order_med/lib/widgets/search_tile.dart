import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/pages/product_page.dart';

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
          child: Image.network(
            '${globals.baseUrl}/assets/img/${product.id}/0.jpg',
            height: 50.0,
            width: 50.0,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) =>
                const Icon(
              Icons.warning_amber_rounded,
              size: 50,
              color: Colors.amber,
            ),
          ),
        ),
      ),
      trailing: Text('₹${product.price}'),
    );
  }
}
