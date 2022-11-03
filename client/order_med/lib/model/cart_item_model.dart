import 'dart:io';
import 'package:order_med/model/product_model.dart';

class CartItem {
  final Product _product;
  int _quantity = 0;
  num _orderTotal = 0;
  bool isUploaded = false;
  File? prescription;

  CartItem(this._product);

  Product get product => _product;

  int get quantity => _quantity;
  set quantity(int value) {
    if (value == 0) {
      throw Exception("Quantity cannot be 0!");
    } else if (value > _product.quantityAvailable) {
      throw Exception("Stock unavailable!");
    }
    _quantity = value;
    _orderTotal = _product.price * _quantity;
  }

  num get orderTotal => _orderTotal;
  set orderTotal(num value) => _orderTotal = value;
}
