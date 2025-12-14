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
import 'app/data/repositories_implementation/category_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/geolocator_repository_impl.dart';
import 'app/data/repositories_implementation/preferences_repository_impl.dart';
import 'app/data/repositories_implementation/printer_repository_impl.dart';
import 'app/data/repositories_implementation/scan_repository_impl.dart';
import 'app/data/repositories_implementation/user_repository_impl.dart';
import 'app/data/services/local/geolocator_service.dart';
import 'app/data/services/local/printer_service.dart';
import 'app/data/services/local/scan_service.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remoto/account_service.dart';
import 'app/data/services/remoto/authentication_service.dart';
import 'app/data/services/remoto/category_service.dart';
import 'app/data/services/remoto/internet_checker.dart';
import 'app/data/services/remoto/user_service.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/category_repsitory.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/geolocator_repository.dart';
import 'app/domain/repositories/preferences_repository.dart';
import 'app/domain/repositories/printer_repository.dart';
import 'app/domain/repositories/scan_repository.dart';
import 'app/domain/repositories/user_repository.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';
import 'app/presentation/modules/user/controller/state/user_crear_state.dart';
import 'app/presentation/modules/user/controller/user_crear_controller.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  final sessionService = SessionSevices(const FlutterSecureStorage());
  final scanService = ScanService();
  scanService.scannerService();
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
        Provider<CategoryRepository>(
          create: (_) => CategoryRepositoryImpl(
            CategoryService(http),
          ),
        ),
        Provider<UserRepository>(
          create: (_) => UserRepositoryImpl(
            UserService(http),
          ),
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
        Provider<GeolocatorRepository>(
          create: (_) {
            return GeolocatorRepositoryImpl(
              GeolocatorService(),
            );
          },
        ),
        Provider<PrinterRepository>(create: (_) {
          return PrinterRepositoryImpl(
            printerService: PrinterService(),
          );
        }),
        Provider<ScanRepository>.value(
          value: ScanRepositoryImpl(
            scanService,
          ),
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
        ChangeNotifierProvider(
          create: (context) => UserCrearController(
            UserCrearState(),
            geolocatorRepository: context.read<GeolocatorRepository>(),
          ),
        ),
      ],
      child: MyApp(scanService: scanService),
    ),
  );
}
