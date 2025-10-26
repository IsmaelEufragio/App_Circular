import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/enums.dart';
import '../../../global/colors.dart';
import '../../../routes/routes.dart';
import '../widgets/button_type_user.dart';

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.fondo,
                AppColors.primary,
              ],
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Que tipo de usuario desea crear?',
                  style: TextStyle(
                    color: AppColors.sucess,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                BotonTipoUsuario(
                  accion: () {
                    context.goNamed(
                      Routes.userCrear,
                      pathParameters: {'userType': UserType.ong.name},
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.fondo,
                  ),
                  messageToolpin:
                      'Cuando un empresa cuenta con poco trabajadores.',
                  messageBotton: 'ONG',
                ),
                const SizedBox(
                  height: 10,
                ),
                BotonTipoUsuario(
                  accion: () {
                    context.goNamed(
                      Routes.userCrear,
                      pathParameters: {'userType': UserType.local.name},
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.fondo,
                  ),
                  messageToolpin:
                      'Solo para ver y poder enseñar sus habilidades..',
                  messageBotton: 'Local',
                ),
                const SizedBox(
                  height: 10,
                ),
                BotonTipoUsuario(
                  accion: () {
                    context.goNamed(
                      Routes.userCrear,
                      pathParameters: {'userType': UserType.servicio.name},
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.fondo,
                  ),
                  messageToolpin:
                      'Solo para ver y poder enseñar sus habilidades..',
                  messageBotton: 'Servicios',
                ),
                const SizedBox(
                  height: 10,
                ),
                BotonTipoUsuario(
                  accion: () {
                    context.goNamed(
                      Routes.userCrear,
                      pathParameters: {'userType': UserType.empresarial.name},
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.fondo,
                  ),
                  messageToolpin:
                      'Solo para ver y poder enseñar sus habilidades..',
                  messageBotton: 'Empresarial',
                ),
                const SizedBox(
                  height: 10,
                ),
                BotonTipoUsuario(
                  accion: () {
                    context.goNamed(
                      Routes.userCrear,
                      pathParameters: {'userType': UserType.microempresa.name},
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.fondo,
                  ),
                  messageToolpin:
                      'Solo para ver y poder enseñar sus habilidades..',
                  messageBotton: 'Microempresa',
                ),
                const SizedBox(
                  height: 10,
                ),
                BotonTipoUsuario(
                  accion: () {
                    context.goNamed(
                      Routes.userCrear,
                      pathParameters: {
                        'userType': UserType.usuarioParticular.name
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.fondo,
                  ),
                  messageToolpin:
                      'Solo para ver y poder enseñar sus habilidades..',
                  messageBotton: 'Usuario Particular',
                ),
                const SizedBox(
                  height: 10,
                ),
                BotonTipoUsuario(
                  accion: () {
                    context.goNamed(
                      Routes.userCrear,
                      pathParameters: {
                        'userType': UserType.usuarioConHabilidades.name
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.fondo,
                  ),
                  messageToolpin:
                      'Solo para ver y poder enseñar sus habilidades..',
                  messageBotton: 'Usuario Con Habilidades',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
