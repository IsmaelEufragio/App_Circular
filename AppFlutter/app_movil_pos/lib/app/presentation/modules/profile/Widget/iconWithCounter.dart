import 'package:flutter/material.dart';

import '../../../global/colors.dart';

class Iconwithcounter extends StatelessWidget {
  const Iconwithcounter({
    super.key,
    required this.icon,
    required this.number,
  });
  final IconData icon;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(icon),
          color: AppColors.primary,
          padding: const EdgeInsets.all(0),
        ),
        Text(
          number,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
