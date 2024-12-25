import 'package:flutter/material.dart';

import '../../../../global/colors.dart';
import 'IncrementWidgets.dart';
import 'cellWidgets.dart';

class DetailesWidgets extends StatelessWidget {
  const DetailesWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IncrementWidgets(),
        const CellWidgets(
          flex: 6,
          text: 'Mesa de Hierror',
          color: AppColors.info,
        ),
        const CellWidgets(
          flex: 3,
          text: '1500',
          color: AppColors.info,
        ),
        const CellWidgets(
          flex: 2,
          text: '0%',
          color: AppColors.info,
        ),
        const CellWidgets(
          flex: 3,
          text: '1500',
          color: AppColors.info,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.alert,
                  borderRadius: BorderRadius.circular(
                    2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'X',
                    style: TextStyle(
                      color: AppColors.fondo,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
