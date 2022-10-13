import 'dart:convert';

import 'package:order_med/model/productModel.dart';
import 'package:order_med/service/networkService.dart';

class ProductService {
  ProductService._instance();
  static final ProductService _productService = ProductService._instance();

  String allProductsPath = '/product';
  String productPath = '/product';
  String searchProductPath = '/product/search';

  factory ProductService() {
    return _productService;
  }

  Future<List<Product>> getAllProducts() async {
    String response = await Service.fetch(allProductsPath);
    List list = jsonDecode(response) as List;
    List<Product> products =
        list.map((product) => Product.fromJson(product)).toList();
    return products;
  }

  Future<Product> getProduct(String productId) async {
    String response = await Service.fetch("$productPath/$productId");
    Map<String, dynamic> json = jsonDecode(response);
    return Product.fromJson(json);
  }

  Future<Product> searchProduct(String q) async {
    String response = await Service.fetch('$searchProductPath?productName=$q');
    Map<String, dynamic> json = jsonDecode(response);
    return Product.fromJson(json);
  }
}
