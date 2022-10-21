import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:order_med/pages/cart_page.dart';
import 'package:order_med/globals.dart' as globals;

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Badge(
        position: BadgePosition.topEnd(top: 0, end: 3),
        animationDuration: const Duration(milliseconds: 300),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          globals.cart.orders.length.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        child: IconButton(
            tooltip: 'Cart',
            onPressed: () {
              print(globals.cart.orders);
              Navigator.pushNamed(context, CartPage.routeName);
            },
            icon: const Icon(Icons.shopping_cart)),
      ),
    );
  }
}
