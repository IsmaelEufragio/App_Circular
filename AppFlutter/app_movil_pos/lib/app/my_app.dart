import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/services/local/scan_service.dart';
import 'presentation/global/controllers/theme_controller.dart';
import 'presentation/global/theme.dart';
import 'presentation/routes/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.scanService,
  });
  final ScanService scanService;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, RouterMixin {
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    widget.scanService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    return GestureDetector(
      onTap: () {
        final focus = FocusScope.of(context);
        final focusedChild = focus.focusedChild;
        if (focusedChild != null && !focusedChild.hasPrimaryFocus) {
          focusedChild.unfocus();
        }
      },
      child: MaterialApp.router(
        routerConfig: router,
        theme: getTheme(themeController.dartMode),
      ),
      /*child: MaterialApp(
        //initialRoute: Routes.signIn,
        theme: getTheme(themeController.dartMode),
        routes: appRoutes,
        onUnknownRoute: (_) => MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404'),
            ),
          ),
        ),
      ),*/
    );
  }
}
