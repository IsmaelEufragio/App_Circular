import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../my_app.dart';
import '../modules/error/view/error_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  final _router = GoRouter(
    //initialLocation: Routes.home,
    //errorBuilder: (_, state) => ErrorView(goRouterState: state),
    onException: (context, state, router) {
      router.goNamed(Routes.error, extra: state.uri.toString());
    },
    routes: [
      GoRoute(
        name: Routes.home,
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        name: Routes.signIn,
        path: '/sigIn',
        builder: (context, state) => const SingInView(),
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
