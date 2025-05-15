import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/preferences_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remoto/account_service.dart';
import 'app/data/services/remoto/authentication_service.dart';
import 'app/data/services/remoto/internet_checker.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/preferences_repository.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  final sessionService = SessionSevices(const FlutterSecureStorage());
  final http = Http(
    Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey:
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzc0NWQ5YzU3YjZiYzE2MDBjZTEyOGM4YzY4OGQwOSIsIm5iZiI6MTcyMjk5NjkzOC4yNTM0OTQsInN1YiI6IjY2YjJkNDNiZTg0NjljOTg5MmE4NmQ4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QJc8s_d_niXZGaHGzqDS6hHc-0RG0BVRUxw0KLcWLT8',
    //lenguageCode: languageService.languageCode,
  );
  final systemDarkMode =
      ui.PlatformDispatcher.instance.platformBrightness == Brightness.dark;
  final preferences = await SharedPreferences.getInstance();
  final connectivity = ConnectivityRepositoryImpl(
    Connectivity(),
    InternetChecker(),
  );

  await connectivity.initialize();
  runApp(
    MultiProvider(
      providers: [
        Provider<PreferencesRepository>(
          create: (_) => PreferencesRepositoryImpl(preferences),
        ),
        Provider<PreferencesRepository>(
          create: (_) => PreferencesRepositoryImpl(preferences),
        ),
        Provider<ConnectivityRepository>(
          create: (_) {
            return connectivity;
          },
        ),
        Provider<AuthenticationRepository>(
          create: (_) {
            return AuthenticationRepositoryImpl(
              AuthenticationService(http),
              sessionService,
              AccountServices(
                http,
                sessionService,
              ),
            );
          },
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
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
