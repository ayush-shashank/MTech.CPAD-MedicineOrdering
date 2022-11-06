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
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.grey.shade400,
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed('/404'),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      'Book Doctor Appointment',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          color: Colors.lightGreen,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed('/orderMedicine'),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Order Medicines',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        )),
        Expanded(
            child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade400,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed('/404'),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Book Lab Appointment',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ))
      ]),
    );
  }
}
