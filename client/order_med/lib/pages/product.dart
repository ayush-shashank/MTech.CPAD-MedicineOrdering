import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: Card(
        child: Column(
          children: [
            Image.network(
              'src',
              fit: BoxFit.contain,
              height: 200,
            ),
            const Text('Product Name'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Product Description'),
                Text('Weight'),
                Text('Prescription Required?')
              ],
            )
          ],
        ),
      ),
      drawer: const ButtonBar(children: [Text('Add to cart')]),
    );
  }
}
