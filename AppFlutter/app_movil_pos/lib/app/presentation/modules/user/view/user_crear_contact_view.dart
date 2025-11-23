import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/colors.dart';
import '../controller/user_crear_controller.dart';
import '../widgets/user_text_field.dart';

class CrearUserContactView extends StatefulWidget {
  const CrearUserContactView({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<CrearUserContactView> createState() => _CrearUserContactViewState();
}

class _CrearUserContactViewState extends State<CrearUserContactView> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserCrearController>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserField(
                label: 'Teléfono',
                onChanged: controller.onTelefonoChanged,
                value: controller.state.telefono,
                keyboardType: TextInputType.phone,
              ),
              UserField(
                label: 'Email',
                onChanged: controller.onEmailChanged,
                value: controller.state.email,
                keyboardType: TextInputType.emailAddress,
              ),
              UserField(
                label: 'Facebook',
                onChanged: controller.onFacebookChanged,
                value: controller.state.facebook,
                keyboardType: TextInputType.url,
              ),
              UserField(
                label: 'Instagram',
                onChanged: controller.onInstagramChanged,
                value: controller.state.instagram,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('WhatsApp',
                    style: TextStyle(color: AppColors.info)),
                value: controller.state.whatsapp,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      controller.onWhatsappChanged(value);
                    });
                  }
                },
                activeColor: AppColors.sucess,
                checkColor: Colors.white,
              ),
              CheckboxListTile(
                title: const Text('Domicilio',
                    style: TextStyle(color: AppColors.info)),
                value: controller.state.domicilio,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      controller.onDomicilioChanged(value);
                    });
                  }
                },
                activeColor: AppColors.sucess,
                checkColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
