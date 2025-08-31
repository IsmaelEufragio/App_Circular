import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../../my_app.dart';
import '../modules/billing/views/billing_view.dart';
import '../modules/error/view/error_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/splash_view.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  final _router = GoRouter(
    //initialLocation: Routes.splash,
    //errorBuilder: (_, state) => ErrorView(goRouterState: state),
    onException: (context, state, router) {
      router.goNamed(Routes.error, extra: state.uri.toString());
    },
    routes: [
      GoRoute(
        name: Routes.splash,
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: Routes.home,
        path: '/home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        name: Routes.signIn,
        path: '/sigIn',
        redirect: (context, state) async {
          final isSignedIn =
              await context.read<AuthenticationRepository>().isSignedIn;
          if (isSignedIn) {
            return '/'; // Redirect to home if already signed in
          }
          return null; //
        },
        builder: (context, state) {
          final ur = state.uri;
          final callbackUrll = ur.queryParameters['callbackUrll'] ?? '/';
          return SingInView(
            callbackUrll: callbackUrll,
          );
        },
      ),
      GoRoute(
        name: Routes.billing,
        path: '/billing',
        builder: (context, state) => const BillingView(),
      ),
      GoRoute(
        name: Routes.profile,
        path: '/profile',
        redirect: (context, state) => redirectToSignIn(context, state),
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const ProfileView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
      GoRoute(
        name: Routes.offLine,
        path: '/offLine',
        builder: (context, state) => const OffLineView(),
      ),
      GoRoute(
        name: Routes.error,
        path: '/404',
        builder: (context, state) => ErrorView(
          uri: state.extra as String? ?? '',
        ),
      )
    ],
  );

  GoRouter get router => _router;
}

FutureOr<String?> redirectToSignIn(
  BuildContext context,
  GoRouterState state,
) async {
  final isSignedIn = await context.read<AuthenticationRepository>().isSignedIn;
  if (!isSignedIn) {
    return '/sigIn?callbackUrll=${state.uri.toString()}';
  }
  return null;
}
