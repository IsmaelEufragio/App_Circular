import 'package:flutter/material.dart';

import '../colors.dart';

class IconBoton extends StatelessWidget {
  const IconBoton({
    super.key,
    required this.iconData,
    this.funnction,
  });

  final IconData iconData;
  final void Function()? funnction;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.primary),
          borderRadius: BorderRadius.circular(3),
        ),
        child: IconButton(
          onPressed: () => funnction,
          icon: Icon(
            iconData,
            color: AppColors.info,
          ),
        ),
      ),
    );
  }
}
