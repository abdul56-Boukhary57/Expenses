import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double fill;

  const ChartBar({super.key, required this.fill});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
