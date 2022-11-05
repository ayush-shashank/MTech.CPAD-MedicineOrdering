import 'package:flutter/material.dart';
import 'package:order_med/pages/dashboard_page.dart';
import 'package:order_med/pages/login_page.dart';
import 'package:order_med/service/auth_service.dart';
import 'package:order_med/service/network_service.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    NetworkService.setBaseAddress();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService().checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return const DashboardPage();
            } else {
              return const LoginPage();
            }
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: const Text('Loading'));
          }
        });
  }
}
