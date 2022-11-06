import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:order_med/model/cart_model.dart';
import 'package:order_med/pages/cart_page.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  void _gotoCart() {
    Navigator.pushNamed(context, CartPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: context.watch<Cart>().items.isNotEmpty
          ? Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                '${context.watch<Cart>().items.length}',
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                  tooltip: 'Cart',
                  onPressed: _gotoCart,
                  icon: const Icon(Icons.shopping_cart)),
            )
          : IconButton(
              tooltip: 'Cart',
              onPressed: _gotoCart,
              icon: const Icon(Icons.shopping_cart),
            ),
    );
  }
}
