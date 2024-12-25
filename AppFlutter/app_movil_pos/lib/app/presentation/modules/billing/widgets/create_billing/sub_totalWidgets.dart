import 'package:flutter/material.dart';

import '../../../../global/colors.dart';

class SubTotalWidgets extends StatelessWidget {
  const SubTotalWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.info,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal: ',
                    style: TextStyle(fontSize: 12, color: AppColors.fondo),
                    //textAlign: TextAlign.right,
                  ),
                  Text(
                    'Descuento: ',
                    style: TextStyle(fontSize: 12, color: AppColors.fondo),
                    //textAlign: TextAlign.right,
                  ),
                  Text(
                    'I.V.S: ',
                    style: TextStyle(fontSize: 12, color: AppColors.fondo),
                    //textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1500',
                      style: TextStyle(fontSize: 12, color: AppColors.fondo),
                    ),
                    Text(
                      '0%',
                      style: TextStyle(fontSize: 12, color: AppColors.fondo),
                    ),
                    Text(
                      '0%',
                      style: TextStyle(fontSize: 12, color: AppColors.fondo),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(color: AppColors.fondo),
                  ),
                  Text(
                    '1500 lps',
                    style: TextStyle(
                      color: AppColors.sucess,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
