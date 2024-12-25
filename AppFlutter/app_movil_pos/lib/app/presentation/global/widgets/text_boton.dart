import 'package:flutter/material.dart';

import '../colors.dart';

class TextBoton extends StatelessWidget {
  const TextBoton({
    super.key,
    required this.text,
    this.funnction,
  });

  final String text;
  final void Function()? funnction;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: TextButton(
          onPressed: () => funnction,
          child: FittedBox(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
