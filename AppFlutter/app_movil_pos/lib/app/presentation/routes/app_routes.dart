import 'package:flutter/material.dart';

import '../modules/billing/views/billing_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.offLine: (context) => const OffLineView(),
    Routes.billing: (context) => const BillingView(),
    Routes.signIn: (context) => const SingInView(),
    Routes.home: (context) => const HomeView(),
  };
}
