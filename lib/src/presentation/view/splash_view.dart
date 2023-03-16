import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

import '../../../gen/assets.gen.dart';
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
          width: 200.w,
          child: RiveAnimation.asset(
            Assets.animation.superman,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
