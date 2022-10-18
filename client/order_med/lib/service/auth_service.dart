import 'package:flutter/material.dart';
import 'package:order_med/globals.dart' as globals;
import 'package:order_med/service/customer_service.dart';

class AuthService {
  SnackBar failure = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red[600],
      duration: const Duration(milliseconds: 1250),
      content: const Text('Invalid Credentials!'));
  SnackBar success = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[600],
      duration: const Duration(milliseconds: 1250),
      content: const Text('Successfully Logged In!'));

  void login(BuildContext context, String email, String password) async {
    print(globals.baseUrl);
    CustomerService.instance
        .login(email: email, password: password)
        .then((user) {
      globals.isLoggedIn = true;
      globals.userId = user.id;
      Navigator.pushReplacementNamed(context, '/dashboard');
      ScaffoldMessenger.of(context).showSnackBar(success);
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(failure);
    });
  }
}
