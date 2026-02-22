import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../global/colors.dart';
import '../controller/user_crear_controller.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/user_header.dart';
import 'user_crear_account_view.dart';
import 'user_crear_contact_view.dart';
import 'user_crear_info_view.dart';
import 'user_crear_location_view.dart';
import 'user_crear_schedule_view.dart';

class CrearUserForm extends StatefulWidget {
  const CrearUserForm({
    super.key,
    required this.type,
  });

  final UserType type;

  @override
  State<CrearUserForm> createState() => _CrearUserFormState();
}

class _CrearUserFormState extends State<CrearUserForm> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKeyStep1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStep2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStep3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStep4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStep5 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = context.read<UserCrearController>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
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
          child: Column(
            children: [
              const SizedBox(height: 10),
              const UserHeader(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CrearUserInfoView(formKey: _formKeyStep1),
                    CrearUserContactView(formKey: _formKeyStep2),
                    UserCrearLocationView(formKey: _formKeyStep3),
                    UserCrearScheduleView(formKey: _formKeyStep4),
                    UserCrearAccountView(formKey: _formKeyStep5),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: NavigationButtons(
                  pageController: _pageController,
                  controller: controller,
                  keyForm: (paginaActual) {
                    switch (paginaActual) {
                      case 0:
                        _formKeyStep1.currentState?.validate();
                        break;
                      case 1:
                        _formKeyStep2.currentState?.validate();
                        break;
                      case 2:
                        _formKeyStep3.currentState?.validate();
                        break;
                      case 3:
                        _formKeyStep4.currentState?.validate();
                        break;
                      case 4:
                        _formKeyStep5.currentState?.validate();
                      default:
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
