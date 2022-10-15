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
            Text('Product Name'),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Description'),
                  Text('Weight'),
                  Text('Presctiption Required?')
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Container(
        child: ButtonBar(children: [Text('Add to cart')]),
      ),
    );
  }
}
