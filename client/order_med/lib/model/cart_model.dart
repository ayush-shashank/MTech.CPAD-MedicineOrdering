import 'package:order_med/model/product_model.dart';

class ProductQuantity {
  Product _product;
  int _orderedQuantity = 0;
  ProductQuantity(this._product, this._orderedQuantity);

  @override
  String toString() {
    return '{product: ${_product.toJson()}, quantity: $_orderedQuantity}';
  }
}

class Cart {
  List<ProductQuantity> _orders = [];
  num _total = 0;

  List<ProductQuantity> get orders => _orders;

  set orders(List<ProductQuantity> value) => _orders = value;

  get total => _total;

  set total(value) => _total = value;
  @override
  String toString() {
    return '{orders: $_orders, total: $_total}';
  }
}
