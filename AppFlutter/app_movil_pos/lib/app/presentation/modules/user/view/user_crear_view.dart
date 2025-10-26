import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../global/colors.dart';
import '../controller/user_crear_controller.dart';
import '../widgets/user_header.dart';
import '../widgets/user_text_field.dart';

class CrearUserView extends StatefulWidget {
  const CrearUserView({
    super.key,
    required this.type,
  });

  final UserType type;

  @override
  State<CrearUserView> createState() => _CrearUserViewState();
}

class _CrearUserViewState extends State<CrearUserView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserCrearController>();
    controller.init();
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const UserHeader(),
                    const SizedBox(height: 30),
                    UserTextField(
                      label: 'Nombre',
                      maxLines: 1,
                      onChanged: controller.onUserNameChanged,
                    ),
                    UserTextField(
                      label: 'Description',
                      maxLines: 3,
                      onChanged: controller.onDescripcionChanged,
                    ),
                    UserTextField(
                      label: 'RTN - Institucion',
                      maxLines: 1,
                      onChanged: controller.onRtnChanged,
                    ),
                    UserTextField(
                      label: 'RTN - Personal',
                      maxLines: 1,
                      onChanged: controller.onRtnPersonalChanged,
                    ),
                    UserTextField(
                      label: 'Rugruo',
                      maxLines: 1,
                      onChanged: (value) {
                        final id = int.tryParse(value) ?? 0;
                        controller.onIdRubroChanged(id);
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.submit();
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
