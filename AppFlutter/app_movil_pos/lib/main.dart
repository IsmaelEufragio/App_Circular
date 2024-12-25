import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/repositories_implementation/preferences_repository_impl.dart';
import 'app/domain/repositories/preferences_repository.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controller/theme_controller.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  final systemDarkMode =
      ui.PlatformDispatcher.instance.platformBrightness == Brightness.dark;
  final preferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<PreferencesRepository>(
          create: (_) => PreferencesRepositoryImpl(preferences),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final preferencesRepository = context.read<PreferencesRepository>();
            return ThemeController(
              context.read<PreferencesRepository>().darkMode ?? systemDarkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}
