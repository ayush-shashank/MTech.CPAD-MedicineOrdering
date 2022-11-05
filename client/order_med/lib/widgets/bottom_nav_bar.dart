import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/pages/cart_page.dart';
import 'package:order_med/pages/dashboard_page.dart';
import 'package:order_med/pages/order_medicine_page.dart';
import 'package:order_med/pages/under_construction.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  int index;
  BottomNavBar({super.key, this.index = 2});

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

  _onTap() {
    if (_index == 0 || _index == 1) {
      navigate(context, _routeList[_index],
          isRootNavigator: false, arguments: {"index": _index});
    } else {
      navigate(context, _routeList[_index], isRootNavigator: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      enableFeedback: true,
      selectedItemColor: Colors.teal.shade700,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.shifting,
      currentIndex: widget.index,
      onTap: (index) {
        setState(() {
          _index = index;
        });
        _onTap();
      },
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.vaccines_rounded), label: "Book Doctor"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined), label: "Book Lab"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded), label: "Dashboard"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.medication_rounded), label: "Order Medicine"),
        BottomNavigationBarItem(
            icon: context.watch<Cart>().items.isNotEmpty
                ? Badge(
                    position: BadgePosition.topEnd(top: -10, end: -10),
                    animationDuration: const Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      '${context.watch<Cart>().items.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: const Icon(Icons.shopping_cart_rounded))
                : const Icon(Icons.shopping_cart_rounded),
            label: "My Cart"),
      ],

      // body: widgetList[index],
    );
  }
}
