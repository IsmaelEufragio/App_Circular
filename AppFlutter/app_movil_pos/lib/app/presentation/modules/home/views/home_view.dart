import 'package:flutter/material.dart';

import '../../../global/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: const Center(
          child: Text(
            'Home',
            style: TextStyle(
              color: AppColors.dark,
            ),
          ),
        ),
      ),
    );
  }
}
