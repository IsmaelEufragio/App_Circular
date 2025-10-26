import 'package:flutter/material.dart';

import '../../../global/colors.dart';

class BotonTipoUsuario extends StatelessWidget {
  const BotonTipoUsuario(
      {super.key,
      required this.messageToolpin,
      required this.accion,
      required this.messageBotton,
      required this.icon});

  final String messageToolpin;
  final VoidCallback? accion;
  final String messageBotton;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: messageToolpin,
      height: 20,
      //padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.alert,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
      child: GestureDetector(
        onTap: accion,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                border: Border.all(
                  color: AppColors.sucess,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2), // Shadow position
                  ),
                ],
              ),
              //margin: const EdgeInsets.only(left: 10),
              child: icon,
            ),
            Container(
              height: 45,
              width: 300,
              decoration: const BoxDecoration(
                color: AppColors.fondo,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2), // Shadow position
                  ),
                ],
                border: Border(
                  top: BorderSide(
                    color: AppColors.sucess,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: AppColors.sucess,
                    width: 1,
                  ),
                  right: BorderSide(
                    color: AppColors.sucess,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  messageBotton,
                  style: const TextStyle(
                    color: AppColors.sucess,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
