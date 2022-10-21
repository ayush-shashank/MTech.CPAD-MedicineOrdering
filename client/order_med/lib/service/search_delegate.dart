import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/widgets/search_tile.dart';

class ProductSearchDelegate extends SearchDelegate {
  List<Product> searchTerms;
  ProductSearchDelegate(this.searchTerms);

  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (var product in searchTerms) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return SearchTile(product: matchQuery[index]);
      },
    );
  }

  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (var product in searchTerms) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return SearchTile(product: matchQuery[index]);
      },
    );
  }
}
