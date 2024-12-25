import 'package:flutter/material.dart';

import '../../../../global/colors.dart';
import 'description.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({
    super.key,
    required this.titulo,
    required this.description,
  });

  final String titulo;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DescriptionProduct(
          text: titulo,
          fontSize: 8,
          color: AppColors.info,
        ),
        DescriptionProduct(
          text: ' $description',
          fontSize: 9,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
