import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class CustomTheme with CompomnentTheme {
  const CustomTheme(this.colorScheme);

  final ColorScheme colorScheme;

  ThemeData get light => ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: elevatedButtonThemeData(colorScheme),
        appBarTheme: appBarTheme(colorScheme),
        iconTheme: iconTheme(colorScheme),
        useMaterial3: true,
      );
}
