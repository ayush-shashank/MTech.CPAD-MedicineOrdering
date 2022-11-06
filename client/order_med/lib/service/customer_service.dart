import 'dart:convert';

import 'package:order_med/model/customer_model.dart';
import 'package:order_med/service/network_service.dart';

class CustomerService {
  static CustomerService? _instance;
  // Avoid self instance
  CustomerService._();
  static CustomerService get instance {
    _instance ??= CustomerService._();
    return _instance!;
  }

  final String _login = '/user/login';

  Future<Customer> login({String? email, String? password}) async {
    Object credentials = {"email": email, "password": password};
    String response = await NetworkService.fetch(_login, body: credentials);
    Map<String, dynamic> json = jsonDecode(response);
    if (json.keys.contains("error")) throw Exception(json['error']);
    return Customer.fromJson(json);
  }
}
