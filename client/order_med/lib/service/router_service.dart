import 'package:flutter/material.dart';
import 'package:order_med/pages/dashboard_page.dart';
import 'package:order_med/pages/home_page.dart';
import 'package:order_med/pages/login_page.dart';
import 'package:order_med/pages/order_medicine_page.dart';
import 'package:order_med/pages/product_page.dart';
import 'package:order_med/pages/under_construction.dart';

class RouterService {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    const String homeRoute = HomePage.routeName;
    const String loginRoute = LoginPage.routeName;
    const String dashboardRoute = DashboardPage.routeName;
    const String orderMedicineRoute = OrderMedicinePage.routeName;
    const String productRoute = ProductPage.routeName;
    const String underConstructionRoute = UnderConstruction.routeName;

    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => const HomePage(title: 'Online Medical Order'));
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case orderMedicineRoute:
        return MaterialPageRoute(builder: (_) => const OrderMedicinePage());
      case productRoute:
        String productId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ProductPage(productId: productId));
      case underConstructionRoute:
        return MaterialPageRoute(builder: (_) => const UnderConstruction());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
