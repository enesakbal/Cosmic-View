import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rive/rive.dart';

import '../../../main.dart';
import '../../config/app_router.dart';

class SplashView extends HookWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 3), () {
        router.replace(const HomeRoute());
      });

      return () {};
    });

    return Scaffold(
      backgroundColor: Color(0XFF151421),
      body: Center(
        child: Container(
          width: 250,
          child: RiveAnimation.asset(
            'assets/animation/superman.riv',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
