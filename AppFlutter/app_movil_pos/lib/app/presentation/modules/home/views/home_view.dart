import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../global/colors.dart';
import '../../../routes/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> //with LoadingMixin
{
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
        child: Center(
          child: Row(
            children: [
              TextButton(
                child: const Text(
                  'SigIn',
                  style: TextStyle(
                    color: AppColors.dark,
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    Routes.signIn,
                  );
                },
              ),
              TextButton(
                child: const Text(
                  'Billing',
                  style: TextStyle(
                    color: AppColors.dark,
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    Routes.billing,
                  );
                },
              ),
              TextButton(
                child: const Text(
                  'Profile',
                  style: TextStyle(
                    color: AppColors.dark,
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    Routes.profile,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
