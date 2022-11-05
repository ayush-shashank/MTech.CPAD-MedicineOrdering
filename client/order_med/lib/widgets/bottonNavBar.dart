import 'package:flutter/material.dart';
import 'package:order_med/pages/cart_page.dart';
import 'package:order_med/pages/dashboard_page.dart';
import 'package:order_med/pages/order_medicine_page.dart';
import 'package:order_med/pages/under_construction.dart';
import 'package:order_med/widgets/cart_button.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<String> _routeList = const [
    UnderConstruction.routeName,
    UnderConstruction.routeName,
    DashboardPage.routeName,
    OrderMedicinePage.routeName,
    CartPage.routeName,
  ];
  int _index = 2;
  Future<void> navigate(BuildContext context, String route,
          {bool isDialog = false,
          bool isRootNavigator = true,
          Map<String, dynamic>? arguments}) =>
      Navigator.of(context, rootNavigator: isRootNavigator)
          .pushNamed(route, arguments: arguments);
  _onTap() {
    navigate(context, _routeList[_index], isRootNavigator: false);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      enableFeedback: true,
      selectedItemColor: Colors.teal.shade700,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.shifting,
      currentIndex: _index,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          _index = index;
        });
        _onTap();
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.vaccines_rounded), label: "Book Doctor"),
        BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined), label: "Book Lab"),
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded), label: "Dashboard"),
        BottomNavigationBarItem(
            icon: Icon(Icons.medication_rounded), label: "Order Medicine"),
        BottomNavigationBarItem(icon: CartButton(), label: "My Cart"),
      ],

      // body: widgetList[index],
    );
  }
}
