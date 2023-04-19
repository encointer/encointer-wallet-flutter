import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class CustomTheme with CompomnentTheme, TypographyTheme {
  const CustomTheme(this.primarySwatch);

  final MaterialColor primarySwatch;

  ThemeData light() {
    return ThemeData(
      primarySwatch: primarySwatch,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: elevatedButtonThemeData(primarySwatch),
      appBarTheme: appBarTheme(primarySwatch),
      textTheme: textTheme(primarySwatch),
    );
  }

  CustomTheme copyWith({MaterialColor? primarySwatch}) {
    return CustomTheme(primarySwatch ?? this.primarySwatch);
  }
}
