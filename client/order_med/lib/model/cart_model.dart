import 'package:flutter/cupertino.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/product_model.dart';

class Cart with ChangeNotifier {
  static List<CartItem> _items = [];
  static num _total = 0;

  List<CartItem> get items => _items;
  static num get total => _total;

  List<CartItem> get orders => _items;

  @override
  String toString() {
    return '{orders: $_items, total: $_total}';
  }

  void add(Product product) {
    CartItem newOrder = CartItem(product);
    newOrder.quantity = 1;
    _items.add(newOrder);
    _total += newOrder.orderTotal;
    notifyListeners();
  }

  static incrementQuantity(int index) {
    CartItem order = _items.elementAt(index);
    _total -= order.orderTotal;
    try {
      ++order.quantity;
    } catch (err) {
      print(err);
    } finally {
      _total += order.orderTotal;
    }
  }

  static decrementQuantity(int index) {
    CartItem order = _items.elementAt(index);
    _total -= order.orderTotal;
    try {
      --order.quantity;
    } catch (err) {
      print(err);
    } finally {
      _total += order.orderTotal;
    }
  }

  void remove(int index) {
    CartItem removed = items.removeAt(index);
    _total -= removed.orderTotal;
    notifyListeners();
  }

  static num getTotal() {
    _total = 0;
    for (var i = 0; i < _items.length; i++) {
      _total += _items.elementAt(i).orderTotal;
    }
    return _total;
  }
}
