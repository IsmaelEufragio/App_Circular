import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/user_crear_controller.dart';
import '../widgets/user_text_field.dart';

class UserCrearAccountView extends StatelessWidget {
  const UserCrearAccountView({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserCrearController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserField(
                label: 'Nombre de Usuario',
                onChanged: controller.onUserNameChanged,
                value: controller.state.nombreUsuario,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validUserNama,
              ),
              UserField(
                label: 'Contraseña',
                onChanged: controller.onPasswordChanged,
                value: controller.state.password,
                keyboardType: TextInputType.visiblePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validPassword,
              ),
              UserField(
                label: 'Confirmar Contraseña',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text != controller.state.password) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
