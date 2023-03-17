import 'package:flutter/material.dart';

import '../../config/gen/colors.gen.dart';

class AppTheme {
  ThemeData get theme => ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),
        scaffoldBackgroundColor: ColorTones.primary,
      );
}
