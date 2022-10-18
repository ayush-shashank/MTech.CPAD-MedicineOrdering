import 'package:flutter/material.dart';
import 'package:order_med/service/search_service.dart';

class OrderMedicinePage extends StatelessWidget {
  const OrderMedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Medicine'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: MedicineSearchDelegate());
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            SizedBox(height: 8),
            Center(
                child: Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
