import 'package:flutter/material.dart';

import '../../../../domain/enums.dart';
import '../../../global/colors.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 20,
              ),
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
                      onChanged: (value) {},
                    ),
                    const UserTextField(label: 'Description', maxLines: 3),
                    const UserTextField(
                        label: 'RTN - Institucion', maxLines: 1),
                    const UserTextField(label: 'RTN - Personal', maxLines: 1),
                    const UserTextField(label: 'Rugruo', maxLines: 1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ])
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
