import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import 'src/config/app_router.dart';
import 'src/config/navigator_observers.dart';

import 'src/core/theme/app_theme.dart';
import 'src/injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );

  await di.init();

  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

final router = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cosmos View',
      theme: AppTheme().theme,
      routerDelegate: AutoRouterDelegate(
        router,
        navigatorObservers: () => [
          NavigatorObservers(),
        ],
      ),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }

  //* fluttergen'i kurabilmek için Xcode'u update et. (brew install FlutterGen/tap/fluttergen)
  //* ikinci apinin modelini ve entitiysini oluştur. ona özel bir data soruce yaz daha sonra hepsinin testini yaz.
}
