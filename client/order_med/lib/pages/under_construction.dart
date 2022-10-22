import 'package:flutter/material.dart';

class UnderConstruction extends StatelessWidget {
  static const String routeName = '/404';

  const UnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found!')),
      body: const Center(child: Text('The page is under construction')),
    );
  }
}
