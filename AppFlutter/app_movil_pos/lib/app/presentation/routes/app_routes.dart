import 'package:app_movil_pos/app/presentation/modules/billing/views/billing_view.dart';
import 'package:app_movil_pos/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.billing: (context) => const BillingView(),
  };
}