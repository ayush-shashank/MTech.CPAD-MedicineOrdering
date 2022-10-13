import 'dart:convert';

import 'package:order_med/globals.dart' as globals;
import 'package:order_med/model/orderModel.dart';
import 'package:order_med/service/networkService.dart';

class OrderService {
  String activeTransactionsPath = '/user/${globals.userId}/activeTransactions';
  String latestTransactionsPath = '/user/${globals.userId}/latestTransactions';
  String allOrdersPath = '/user/${globals.userId}/orders';
  String orderPath = '/order';

  Future<List<Order>> getActiveTransactions() async {
    print("getActiveTransactions");
    String response = await Service.fetch(activeTransactionsPath);
    print("act res $response");
    List list = jsonDecode(response) as List;
    List<Order> orders = list.map((order) => Order.fromJson(order)).toList();
    print(orders);
    return orders;
  }

  Future<List<Order>> getLatestTransactions() async {
    String response = await Service.fetch(latestTransactionsPath);
    List list = jsonDecode(response) as List;
    List<Order> orders = list.map((order) => Order.fromJson(order)).toList();
    return orders;
  }

  Future<List<Order>> getAllOrders() async {
    String response = await Service.fetch(allOrdersPath);
    List list = jsonDecode(response) as List;
    List<Order> orders = list.map((order) => Order.fromJson(order)).toList();
    return orders;
  }

  Future<Order> getOrder(String orderId) async {
    String response = await Service.fetch('$orderPath/$orderId');
    Map<String, dynamic> json = jsonDecode(response);
    return Order.fromJson(json);
  }
}
