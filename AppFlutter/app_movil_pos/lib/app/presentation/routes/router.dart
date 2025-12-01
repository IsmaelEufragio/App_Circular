import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/enums.dart';
import '../../domain/models/user/user_create/select_option/user_data_option.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../my_app.dart';
import '../global/widgets/menu.dart';
import '../modules/billing/views/billing_view.dart';
import '../modules/error/view/error_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/splash_view.dart';
import '../modules/user/controller/user_crear_controller.dart';
import '../modules/user/view/user_crear_form.dart';
import '../modules/user/view/user_type_view.dart';
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
          return Menu(child: child);
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
        name: Routes.userType,
        path: '/userType',
        parentNavigatorKey: parentNavigatorKey,
        builder: (context, state) => const UserTypeView(),
      ),
      GoRoute(
        path: '/userCrear/:userType',
        name: Routes.userCrear,
        parentNavigatorKey: parentNavigatorKey,
        pageBuilder: (context, state) {
          final userTypeString = state.pathParameters['userType']!;
          final userType = UserType.values.firstWhere(
            (e) => e.name == userTypeString,
          );
          return MaterialPage(
            child: FutureBuilder<UserDataOption>(
              future: context.read<UserRepository>().getUserDataOption(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final option = snapshot.data!;
                  final controlle = context.read<UserCrearController>();
                  controlle.setOptiondCategories(option.categoriaNegocios);
                  controlle.setOptiodnDepartamentos(option.departamentos);

                  return CrearUserForm(type: userType);
                } else {
                  return const Scaffold(
                    body: Center(
                      child: Text('No data available'),
                    ),
                  );
                }
              },
            ),
          );
        },
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
