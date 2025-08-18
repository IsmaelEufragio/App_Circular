import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/account_repository.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../../domain/repositories/connectivity_repository.dart';
import '../../global/controllers/session_controller.dart';
import '../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> _init() async {
    final ConnectivityRepository connectivityRepository = context.read();
    final AuthenticationRepository authenticationRepository = context.read();
    final AccountRepository accountRepository = context.read();
    final SessionController sessionController = context.read();

    final hasInternet = connectivityRepository.hasInternet;
    if (hasInternet) {
      if (mounted) {
        if (await authenticationRepository.isSignedIn) {
          final user = await accountRepository.getUserData();
          if (user != null) {
            sessionController.setUser(user);
            // ignore: use_build_context_synchronously
            GoRouter.of(context).pushNamed(Routes.home);
            return;
          }
          // ignore: use_build_context_synchronously
          GoRouter.of(context).pushNamed(Routes.home);
          return;
        }
        // ignore: use_build_context_synchronously
        GoRouter.of(context).pushNamed(Routes.signIn);
        return;
      }
    } else {
      GoRouter.of(context).pushNamed(Routes.offLine);
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
