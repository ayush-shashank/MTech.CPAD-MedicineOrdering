import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/product_model.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  num _total = 0;

  List<CartItem> get items => _items;
  num get total => _total;

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

  incrementQuantity(int index) {
    CartItem order = _items.elementAt(index);
    _total -= order.orderTotal;
    try {
      ++order.quantity;
    } catch (err) {
      print(err);
    } finally {
      _total += order.orderTotal;
    }
    notifyListeners();
  }

  decrementQuantity(int index) {
    CartItem order = _items.elementAt(index);
    _total -= order.orderTotal;
    try {
      --order.quantity;
    } catch (err) {
      print(err);
    } finally {
      _total += order.orderTotal;
    }
    notifyListeners();
  }

  void remove(int index) {
    CartItem removed = items.removeAt(index);
    _total -= removed.orderTotal;
    notifyListeners();
  }

  num getTotal() {
    _total = 0;
    for (var i = 0; i < _items.length; i++) {
      _total += _items.elementAt(i).orderTotal;
    }
    return _total;
  }

  isGood() {
    return _items
        .where((element) => element.product.doesRequirePrescription)
        .every((element) => element.isUploaded);
  }

  uploadPrescription(int index, XFile? image) {
    CartItem order = _items.elementAt(index);
    order.prescription = File(image!.path);
    order.isUploaded = true;
    notifyListeners();
  }

  removePrescription(int index) {
    CartItem order = _items.elementAt(index);
    order.prescription = null;
    order.isUploaded = false;
    notifyListeners();
  }

  clear() {
    _items = [];
    _total = 0;
  }
}
