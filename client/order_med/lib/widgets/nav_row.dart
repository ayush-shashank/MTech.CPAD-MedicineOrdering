import 'package:flutter/material.dart';

class NavRow extends StatelessWidget {
  const NavRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(children: [
        Expanded(
          child: Card(
            color: Colors.grey,
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed('/404'),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Book Doctor Appointment',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: Card(
          color: Colors.lightGreen,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed('/orderMedicine'),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Order Medicines',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )),
        Expanded(
            child: Card(
          color: Colors.grey,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed('/404'),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Book Lab Appointment',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ))
      ]),
    );
  }
}
