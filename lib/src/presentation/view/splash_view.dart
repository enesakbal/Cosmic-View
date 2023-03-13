import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../main.dart';
import '../../config/app_router.dart';

class SplashView extends HookWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () {
        router.replace(const HomeRoute());
      });

      return () {};
    });

    return Scaffold(
      body: Center(
        child: Container(
          width: 120,
          height: 120,
          color: Colors.red,
          child: Text('splash'),
        ),
      ),
    );
  }
}
