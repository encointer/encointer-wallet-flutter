import 'package:flutter/material.dart';

mixin TypographyTheme {
  TextTheme textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 66,
        color: colorScheme.primary,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        color: colorScheme.primary,
      ),
      displaySmall: TextStyle(
        fontSize: 19,
        color: colorScheme.primary,
      ),
      headlineMedium: TextStyle(
        fontSize: 14,
        color: colorScheme.primary,
      ),
    );
  }
}
