import 'package:flutter/material.dart';

import '../../../global/colors.dart';
import '../controller/user_crear_controller.dart';

class NavigationButtons extends StatefulWidget {
  const NavigationButtons(
      {super.key,
      required this.pageController,
      required this.controller,
      required this.keyForm});
  final PageController pageController;
  final UserCrearController controller;
  final Function(int) keyForm;
  @override
  NavigationButtonsState createState() => NavigationButtonsState();
}

class NavigationButtonsState extends State<NavigationButtons> {
  int _currentPage = 0;
  final int _totalPages = 5;

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en el PageController
    widget.pageController.addListener(_updatePage);
  }

  void _updatePage() {
    final newPage = widget.pageController.page?.round() ?? 0;
    if (newPage != _currentPage) {
      setState(() {
        _currentPage = newPage;
      });
    }
  }

  void _goToNextPage() {
    final List<String> errores = widget.controller.validarPagina(_currentPage);
    if (errores.isEmpty) {
      if (_currentPage < _totalPages - 1) {
        widget.pageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        widget.controller.submit();
      }
    } else {
      widget.keyForm(_currentPage);
      final message = errores.join(', ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      widget.pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Text(_currentPage == _totalPages - 1 ? 'Enviar' : 'Siguiente'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_updatePage);
    super.dispose();
  }
}
