import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class CustomTheme with CompomnentTheme, TypographyTheme {
  const CustomTheme(this.colorScheme);

  final ColorScheme colorScheme;

  ThemeData get light => ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: elevatedButtonThemeData(colorScheme),
        appBarTheme: appBarTheme(colorScheme),
        textTheme: textTheme(colorScheme),
        iconTheme: iconTheme(colorScheme),
      );
}
