import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loggy/loggy.dart';

import 'src/config/app_router.dart';
import 'src/config/navigator_observers.dart';
import 'src/core/theme/app_theme.dart';
import 'src/injector.dart' as di;
import 'src/presentation/bloc/apod/apod_bloc.dart';
import 'src/presentation/bloc/nasa_image/nasa_image_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.injector<APODBloc>()),
        BlocProvider(create: (context) => di.injector<NasaImageBloc>()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          builder: (context, _) {
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
          }),
    );
  }
}

//* bloc tarafının testini tekrar yaz. şöyle bir senaryo olabilir. apod verisi saatlik 5000 ile sınırlı 
//* testi kullanmak amacıyla, eğer apoddan veri gelmezse üstte çıkacak ve yana kaydırdıkça ilerleyecek olan cardları gösterme
//* yalnızca bir akış olsun 
//* favori sayfasını şöyle yapabilirsin
//* herhangi bir X yazısını favoriye atarsan, gönderinin tüm verileri locale kayıt et.
//* hem model olarak kayıt et (dao ve sqflite) hem de resmi kayıt et (bytes)
//* offline iken bu datalar görünür olur ve ana sayfada ufak bir yazı koyarsın retry dediğinde tekrar istek atmaya çalışır.
//* bunların da dışında lazy loading yapmalısın
//* hangi apiyi nerede kullanacağına henüz karar vermedin
//* ancak şurası kesin olmalı ki akış sayfasında aşağı inildikçe 5'er veya 10'ar olarak tekrar istek atmalısın.
//* ikinci api bunu için daha uygun çünkü bir sınırı yok
