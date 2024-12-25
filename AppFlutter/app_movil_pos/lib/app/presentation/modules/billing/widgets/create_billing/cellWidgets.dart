import 'package:flutter/material.dart';

class CellWidgets extends StatelessWidget {
  const CellWidgets({
    super.key,
    required this.flex,
    required this.text,
    required this.color,
  });

  final int flex;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
