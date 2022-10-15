import 'package:flutter/material.dart';
import 'package:order_med/pages/activeTransactions.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: const ActiveTransactions(),
      bottomNavigationBar: Container(
        child: SizedBox(
          width: 10,
          child: Text('asbk'),
        ),
      ),
      drawer: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(12),
        width: 600,
        child: Column(children: [
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
