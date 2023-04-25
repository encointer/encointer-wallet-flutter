import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

class AppColors {
  static ColorScheme leu = ColorScheme.fromSeed(
    seedColor: const Color(0xff4374A3), // main color for almost all texts
    background: const Color(0xffF4F8F9), // used for light blue buttons (i.e. secondary buttons)
    outline: const Color(0xffBCCEE0), // medium blue border color of progress bar
    surface: const Color(0xFF000022), // dark blue for the scan bottomButtonBar icon
    secondary: const Color(0xFF3969AC), //  end color of gradient
    tertiary: const Color(0xFF3880BD), // starting color of gradient
  );

  static ColorScheme gbd = ColorScheme.fromSeed(
    seedColor: const Color(0xFF79C943),
    background: const Color(0xFFF6FAF1),
    outline: const Color(0xFF93C47D),
    surface: const Color(0xFF000022),
    secondary: const Color(0xFF35B731),
    tertiary: const Color(0xFF7CB342),
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
