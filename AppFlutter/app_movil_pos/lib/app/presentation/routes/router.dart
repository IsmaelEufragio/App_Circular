import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../my_app.dart';
import '../modules/billing/views/billing_view.dart';
import '../modules/error/view/error_view.dart';
import '../modules/home/views/home_view.dart';
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
        builder: (context, state) => const SingInView(),
      ),
      GoRoute(
        name: Routes.billing,
        path: '/billing',
        builder: (context, state) => const BillingView(),
      ),
      GoRoute(
        name: Routes.profile,
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
      // GoRoute(
      //   name: Routes.offLine,
      //   path: '/offLine',
      //   builder: (context, state) => const OffLineView(),
      // ),
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
