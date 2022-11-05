import 'package:flutter/material.dart';
import 'package:order_med/widgets/bottom_nav_bar.dart';

class UnderConstruction extends StatelessWidget {
  static const String routeName = '/404';

  int index;

  UnderConstruction({super.key, this.index = 1});

  @override
  Widget build(BuildContext context) {
    print(index);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: index),
      appBar: AppBar(title: const Text('Page Not Found!')),
      body: const Center(child: Text('The page is under construction')),
    );
  }
}
