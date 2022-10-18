import 'package:flutter/material.dart';
import 'package:order_med/pages/under_construction.dart';

class NavRow extends StatelessWidget {
  const NavRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed('/404'),
            child: const Card(
                color: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Book Doctor Appointment',
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ),
        Expanded(
            child: InkWell(
          onTap: () => Navigator.of(context).pushNamed('/orderMedicine'),
          child: const Card(
            color: Colors.lightGreen,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Order Medicines',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )),
        Expanded(
            child: InkWell(
          onTap: () => Navigator.of(context).pushNamed('/404'),
          child: const Card(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Book Lab Appointment',
                  textAlign: TextAlign.center,
                ),
              )),
        ))
      ]),
    );
  }
}
