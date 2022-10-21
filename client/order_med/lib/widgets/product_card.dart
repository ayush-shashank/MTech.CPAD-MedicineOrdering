import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(children: [
                  Image.network(
                      'https://images.newscientist.com/wp-content/uploads/2019/06/18153152/medicineshutterstock_1421041688.jpg',
                      fit: BoxFit.fill,
                      height: 60,
                      errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.warning_amber_rounded,
                              size: 100,
                              color: Colors.amber,
                            ),
                          ))
                ]),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    Text(
                      '${product.weightInGrams.toString()}g',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      '₹ ${product.price.toString()}',
                      style: const TextStyle(fontSize: 28),
                    )
                  ],
                ),
              ],
            )),
      ),
      onTap: () => Navigator.pushNamed(context, '/home'),
    );
  }
}
