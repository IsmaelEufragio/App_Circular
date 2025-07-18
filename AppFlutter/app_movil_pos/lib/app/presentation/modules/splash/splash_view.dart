import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/authentication_repository.dart';
import '../../../domain/repositories/connectivity_repository.dart';
import '../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> _init() async {
    final ConnectivityRepository connectivityRepository = context.read();
    final AuthenticationRepository authenticationRepository = context.read();

    final hasInternet = connectivityRepository.hasInternet;
    if (hasInternet) {
      if (mounted) {
        if (await authenticationRepository.isSignedIn) {}
        _goTo(Routes.signIn);
        return;
      }
    } else {
      _goTo(Routes.offLine);
      return;
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }
}
