import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

class AppColors {
  static const ColorScheme leu = ColorScheme(
    primary: Color(0xff4374A3), // main color for almost all texts
    onPrimary: Color(0xffF4F8F9),
    secondary: Color(0xFF3969AC), // end color of gradient
    onSecondary: Color(0xffF4F8F9),
    surface: Color(0xffF4F8F9), // used for light blue buttons (i.e. secondary buttons)
    onSurface: Color(0xFF000022),
    error: Color(0xffF51D07),
    onError: Color(0xffF4F8F9),
    tertiary: Color(0xFF3880BD), // starting color of gradient
    brightness: Brightness.light,
  );

  /// TODO(eldiiar): Replace colors with designer's colors.
  static const ColorScheme gbd = ColorScheme(
    primary: Color(0xff288061), // main color for almost all texts
    onPrimary: Color(0xFFF6FAF1),
    secondary: Color.fromARGB(255, 41, 119, 86), // end color of gradient
    onSecondary: Color(0xFFF6FAF1),
    surface: Color(0xFFF6FAF1), // used for light blue buttons (i.e. secondary buttons)
    onSurface: Color(0xFF000022),
    error: Color(0xffF51D07),
    onError: Color(0xFFF6FAF1),
    tertiary: Color(0xff319673), // starting color of gradient
    brightness: Brightness.light,
  );

  static const Color encointerGrey = Color(0xff666666);
  static const Color encointerBlack = Color(0xff353535);

  static LinearGradient primaryGradient(BuildContext context) {
    return LinearGradient(
      begin: const Alignment(-.9, 0),
      end: const Alignment(0.1, -.1),
      colors: [context.colorScheme.tertiary, context.colorScheme.secondary],
    );
  }
}
