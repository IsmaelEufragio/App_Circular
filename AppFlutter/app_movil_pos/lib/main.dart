import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/preferences_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remoto/account_service.dart';
import 'app/data/services/remoto/authentication_service.dart';
import 'app/data/services/remoto/internet_checker.dart';
import 'app/domain/repositories/account_repository.dart';
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
    baseUrl:
        'https://apicircular-c6a8def4bjhycyga.canadacentral-01.azurewebsites.net',
    apiKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwZDc0ZDM5OC05MDJlLTQ1MjktYTU3ZS00YmJmMDQyYjFmZWUiLCJuYW1lIjoiUG9sbG9zIGVsIFR1YW5pcyB0ZXMiLCJqdGkiOiI4NTFjZWFkOS00MDEyLTRlODctYjEzOC1jMjkwMTE0YzM1MDYiLCJQZXJtaXNvIjoiRWRpdGFyQ29ycmVvIiwiZXhwIjoxNzQ3NTI2MDI3LCJpc3MiOiJodHRwczovL3R1LWFwaS5jb20iLCJhdWQiOiJodHRwczovL3R1LWFwaS5jb20ifQ.OsJIYCyEoPfWWgA-oZKwCDSSPOanT2mIUg1MQZH5M3w',
    sessionSevices: sessionService,
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
        Provider<AccountRepository>(
          create: (_) {
            return AccountRepositoryImpl(
              AccountServices(
                http,
              ),
            );
          },
        ),
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
