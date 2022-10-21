import 'package:flutter/material.dart';
import 'package:order_med/model/product_model.dart';
import 'package:order_med/widgets/search_tile.dart';

class ProductSearchDelegate extends SearchDelegate {
  List<Product> searchTerms;
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

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
    return AnimatedList(
      key: _listKey,
      initialItemCount: matchQuery.length,
      itemBuilder: (context, index, animation) {
        return SearchTile(product: matchQuery[index]);
        // return SlideTransition(
        //     position: animation.drive(_offset),
        //     child: SearchTile(product: matchQuery[index]));
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
    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      initialItemCount: matchQuery.length,
      itemBuilder: (context, index, animation) {
        return SearchTile(product: matchQuery[index]);
        //   return SlideTransition(
        //       position: animation.drive(_offset),
        //       child: SearchTile(product: matchQuery[index]));
      },
    );
  }
}
