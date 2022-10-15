import 'package:flutter/material.dart';
import 'package:order_med/pages/activeTransactions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: const ActiveTransactions(),
      bottomNavigationBar: const SizedBox(
        width: 10,
        child: Text('ask'),
      ),
      drawer: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(12),
        width: 600,
        child: Column(children: const [
          Text('Pages1'),
          Text('data Page 2'),
          Text('data'),
          Text('data')
        ]),
      ),
    );
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
