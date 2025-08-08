import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../my_app.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  final _router = GoRouter(
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
    ],
  );

  GoRouter get router => _router;
}
