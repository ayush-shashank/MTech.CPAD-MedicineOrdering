import 'package:flutter/material.dart';

class NavRow extends StatelessWidget {
  const NavRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Card(
              child: SizedBox(width: 50, height: 20, child: Text('data')),
            ),
            Card(
              child: SizedBox(width: 50, height: 20, child: Text('data')),
            ),
            Card(
              child: SizedBox(width: 50, height: 20, child: Text('data')),
            )
          ]),
    );
  }
}
