import 'package:order_med/model/product_model.dart';

class CartItem {
  final Product _product;
  int _quantity = 0;
  num _orderTotal = 0;
  // late ByteStream prescription;

  CartItem(this._product);

  Product get product => _product;

  int get quantity => _quantity;
  set quantity(int value) {
    if (value == 0 || value > _product.quantityAvailable) {
      throw Exception("Invalid Quantity");
    }
    _quantity = value;
    _orderTotal = _product.price * _quantity;
  }

  num get orderTotal => _orderTotal;
  set orderTotal(num value) => _orderTotal = value;
}
