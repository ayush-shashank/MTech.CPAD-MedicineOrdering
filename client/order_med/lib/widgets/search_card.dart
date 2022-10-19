import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/globals.dart' as globals;

class SearchCard extends StatelessWidget {
  final Product product;

  const SearchCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => print('object')),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Image.network(
                      '${globals.baseUrl}/assets/img/${product.id}/0.jpg')),
              const SizedBox(
                width: 8,
              ),
              Expanded(flex: 7, child: Wrap(children: [Text(product.name)])),
              const SizedBox(
                width: 8,
              ),
              Expanded(flex: 2, child: Text('${product.weightInGrams}g')),
            ],
          ),
        ),
      ),
    );
  }
}
