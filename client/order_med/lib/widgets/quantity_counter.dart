import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  final int upperLimit;

  final ValueChanged<int> onChanged;

  const QuantityCounter({
    super.key,
    required this.upperLimit,
    required this.onChanged,
  });

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: IconButton(
                icon: const Icon(
                  Icons.remove_circle_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    value = value == 1 ? 1 : value -= 1;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
            SizedBox(
              width: 20,
              child: Text(
                '$value',
                style: const TextStyle(
                  // fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    value = value == widget.upperLimit
                        ? widget.upperLimit
                        : value += 1;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
          ],
        ));
  }
}
