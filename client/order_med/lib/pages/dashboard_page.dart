import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_med/pages/activeTransactions.dart';
import 'package:order_med/widgets/nav_row.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dashboard"), actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                              child: const Text("Yes"), onPressed: () {}),
                          TextButton(
                              child: const Text(
                                "No",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ]),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: const [
              NavRow(),
              ActiveTransactions(),
            ],
          ),
        ));
  }
}

// Column(
//         children: [
//           const Text("Dashboard Body"),
//           IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/activeTransactions');
//               },
//               icon: const Icon(Icons.edit_location)),
//         ],
//       ),
