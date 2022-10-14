import 'dart:convert';

import 'package:order_med/model/product_model.dart';
import 'package:order_med/service/network_service.dart';

class ProductService {
  static ProductService? _instance;
  // Avoid self instance
  ProductService._();
  static ProductService get instance {
    _instance ??= ProductService._();
    return _instance!;
  }

  String allProductsPath = '/product';
  String productPath = '/product';
  String searchProductPath = '/product/search';

  Future<List<Product>> getAllProducts() async {
    String response = await NetworkService.fetch(allProductsPath);
    List list = jsonDecode(response) as List;
    List<Product> products =
        list.map((product) => Product.fromJson(product)).toList();
    return products;
  }

  Future<Product> getProduct(String productId) async {
    String response = await NetworkService.fetch("$productPath/$productId");
    Map<String, dynamic> json = jsonDecode(response);
    return Product.fromJson(json);
  }

  Future<Product> searchProduct(String q) async {
    String response =
        await NetworkService.fetch('$searchProductPath?productName=$q');
    Map<String, dynamic> json = jsonDecode(response);
    return Product.fromJson(json);
  }
}
