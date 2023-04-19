import 'package:flutter/material.dart';

mixin TypographyTheme {
  TextTheme textTheme(MaterialColor primarySwatch) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 66,
        color: primarySwatch.shade500,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        color: primarySwatch.shade500,
      ),
      displaySmall: TextStyle(
        fontSize: 19,
        color: primarySwatch.shade500,
      ),
      headlineMedium: TextStyle(
        fontSize: 14,
        color: primarySwatch.shade500,
      ),
    );
  }
}
