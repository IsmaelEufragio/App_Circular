import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../global/colors.dart';
import '../controller/user_crear_controller.dart';
import '../widgets/user_header.dart';
import 'user_crear_contact_view.dart';
import 'user_crear_info_view.dart';
import 'user_crear_location_view.dart';

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
  int _currentPage = 0;
  final int _totalPages = 3;

  void _nextPage() {
    if (_currentPage != _totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      context.read<UserCrearController>().submit();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages - 1) {
      // Validar paso actual antes de continuar
      if (true) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      //_submitForm();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    CrearUserInfoView(formKey: _formKeyStep1),
                    CrearUserContactView(formKey: _formKeyStep2),
                    UserCrearLocationView(formKey: _formKeyStep3),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _goToPreviousPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('Atrás'),
                    ),
                    Text(
                      'Paso ${_currentPage + 1} de $_totalPages',
                      style: const TextStyle(color: AppColors.info),
                    ),
                    ElevatedButton(
                      onPressed: _goToNextPage,
                      child: Text(_currentPage == _totalPages - 1
                          ? 'Enviar'
                          : 'Siguiente'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
