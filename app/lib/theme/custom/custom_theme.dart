import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class CustomTheme with CompomnentTheme, TypographyTheme {
  const CustomTheme(this.colorScheme);

  final ColorScheme colorScheme;

  ThemeData get light => ThemeData(
        // primarySwatch: primarySwatch,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: elevatedButtonThemeData(colorScheme),
        appBarTheme: appBarTheme(colorScheme),
        textTheme: textTheme(colorScheme),
        iconTheme: iconTheme(colorScheme),
      );
  // colorScheme: ColorScheme.fromSeed(
  //   seedColor: primarySwatch,
  //   background: primarySwatch.shade50,
  //   secondary: primarySwatch.shade500,
  // ));

  // LinearGradient get primaryGradient => LinearGradient(
  //       begin: const Alignment(-.9, 0),
  //       end: const Alignment(0.1, -.1),
  //       colors: [primarySwatch.shade400, primarySwatch.shade600],
  //     );
}
