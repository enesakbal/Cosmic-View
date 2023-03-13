import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_tones.dart';

class AppTheme {
  ThemeData get theme => ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),
        scaffoldBackgroundColor: ColorTones.primaryColor,
      );
}
