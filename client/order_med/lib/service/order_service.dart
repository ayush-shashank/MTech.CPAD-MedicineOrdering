import 'dart:convert';

import 'package:order_med/globals.dart' as globals;
import 'package:order_med/model/cart_item_model.dart';
import 'package:order_med/model/order_model.dart';
import 'package:order_med/service/network_service.dart';

class OrderService {
  static OrderService? _instance;
  // Avoid self instance
  OrderService._();
  static OrderService get instance {
    _instance ??= OrderService._();
    return _instance!;
  }

  final String _activeTransactionsPath =
      '/user/${globals.userId}/activeTransactions';
  final String _latestTransactionsPath =
      '/user/${globals.userId}/latestTransactions';
  final String _allOrdersPath = '/user/${globals.userId}/orders';
  final String _orderPath = '/order';
  final String _placeOrder = '/user/${globals.userId}/orderMedicine';

  Future<List<Order>> getActiveTransactions() async {
    String response = await NetworkService.fetch(_activeTransactionsPath);
    List list = jsonDecode(response) as List;
    List<Order> orders = list.map((order) => Order.fromJson(order)).toList();
    return orders;
  }

  Future<List<Order>> getLatestTransactions() async {
    String response = await NetworkService.fetch(_latestTransactionsPath);
    List list = jsonDecode(response) as List;
    List<Order> orders = list.map((order) => Order.fromJson(order)).toList();
    return orders;
  }

  Future<List<Order>> getAllOrders() async {
    String response = await NetworkService.fetch(_allOrdersPath);
    List list = jsonDecode(response) as List;
    List<Order> orders = list.map((order) => Order.fromJson(order)).toList();
    return orders;
  }

  Future<Order> getOrder(String orderId) async {
    String response = await NetworkService.fetch('$_orderPath/$orderId');
    Map<String, dynamic> json = jsonDecode(response);
    return Order.fromJson(json);
  }

  Future<Order> placeOrder(CartItem item) async {
    String pathToImage = '';
    if (item.product.doesRequirePrescription) {
      pathToImage = await NetworkService.uploadImage(item.prescription!);
    }
    Order toPlace = Order();
    toPlace.customerId = globals.userId;
    toPlace.productId = item.product.id;
    toPlace.productName = item.product.name;
    toPlace.quantity = item.quantity;
    toPlace.orderAmount = item.orderTotal;
    toPlace.prescriptionURL = pathToImage;
    String response =
        await NetworkService.fetch(_placeOrder, body: toPlace.toJson());
    Map<String, dynamic> json = jsonDecode(response);
    return Order.fromJson(json);
  }
}
