import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../../my_app.dart';
import '../global/colors.dart';
import '../modules/billing/views/billing_view.dart';
import '../modules/error/view/error_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/splash_view.dart';
import 'routes.dart';

final parentNavigatorKey = GlobalKey<NavigatorState>();

mixin RouterMixin on State<MyApp> {
  final _router = GoRouter(
    navigatorKey: parentNavigatorKey,
    //initialLocation: Routes.splash,
    //errorBuilder: (_, state) => ErrorView(goRouterState: state),
    onException: (context, state, router) {
      router.goNamed(Routes.error, extra: state.uri.toString());
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Stack(
            children: [
              child,
              Positioned(
                bottom: 0,
                left: 170,
                right: 170,
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.info,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                Routes.home,
                              );
                            },
                            icon: const Icon(Icons.home),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                Routes.billing,
                              );
                            },
                            icon: const Icon(Icons.receipt),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.store),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                Routes.profile,
                              );
                            },
                            icon: const Icon(Icons.engineering),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.print),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.inventory),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.campaign),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.recycling),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.post_add),
                            color: AppColors.fondo,
                            padding: const EdgeInsets.all(0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        routes: [
          GoRoute(
            name: Routes.home,
            path: '/home',
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            name: Routes.billing,
            path: '/billing',
            builder: (context, state) => const BillingView(),
          ),
        ],
      ),
      GoRoute(
        name: Routes.splash,
        path: '/',
        parentNavigatorKey: parentNavigatorKey,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: Routes.signIn,
        parentNavigatorKey: parentNavigatorKey,
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
        name: Routes.profile,
        path: '/profile',
        parentNavigatorKey: parentNavigatorKey,
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
        parentNavigatorKey: parentNavigatorKey,
        path: '/offLine',
        builder: (context, state) => const OffLineView(),
      ),
      GoRoute(
        name: Routes.error,
        parentNavigatorKey: parentNavigatorKey,
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
