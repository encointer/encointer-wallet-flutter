import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class CustomTheme with CompomnentTheme, TypographyTheme {
  const CustomTheme(this.primarySwatch);

  final MaterialColor primarySwatch;

  ThemeData get light => ThemeData(
        primarySwatch: primarySwatch,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: elevatedButtonThemeData(primarySwatch),
        appBarTheme: appBarTheme(primarySwatch),
        textTheme: textTheme(primarySwatch),
      );

  LinearGradient get primaryGradient => LinearGradient(
        begin: const Alignment(-.9, 0),
        end: const Alignment(0.1, -.1),
        colors: [primarySwatch.shade400, primarySwatch.shade600],
      );
}
