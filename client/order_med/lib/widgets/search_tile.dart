import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/pages/product_page.dart';

class SearchCard extends StatelessWidget {
  final Product product;

  const SearchCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (() => Navigator.of(context)
          .pushNamed(ProductPage.routeName, arguments: product.id)),
      contentPadding: const EdgeInsets.all(10),
      title: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'location-img-${product.id}',
          child: Image.network(
            '${globals.baseUrl}/assets/img/${product.id}/0.jpg',
            height: 50.0,
            // width: 50.0,
            // fit: BoxFit.contain,
          ),
        ),
      ),
      trailing: Text('₹${product.price}'),
    );
  }
}
