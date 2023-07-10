import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';

extension TypographyTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  // Custom text styles
  TextStyle get displayLarge => textTheme.displayLarge!.copyWith(color: colorScheme.onSurface);
  TextStyle get displayMedium => textTheme.displayMedium!.copyWith(color: colorScheme.onSurface);
  TextStyle get displaySmall => textTheme.displaySmall!.copyWith(color: colorScheme.onSurface);
  TextStyle get headlineLarge => textTheme.headlineLarge!.copyWith(color: colorScheme.primary);
  TextStyle get headlineMedium => textTheme.headlineMedium!.copyWith(color: colorScheme.primary);
  TextStyle get headlineSmall => textTheme.headlineSmall!.copyWith(color: colorScheme.primary);
  TextStyle get titleLarge => textTheme.titleLarge!.copyWith(color: colorScheme.onSurface);
  TextStyle get titleMedium => textTheme.titleMedium!.copyWith(color: colorScheme.onSurface);
  TextStyle get titleSmall => textTheme.titleSmall!.copyWith(color: colorScheme.onSurface);
  TextStyle get bodyLarge => textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface);
  TextStyle get bodyMedium => textTheme.bodyMedium!.copyWith(color: colorScheme.onSurface);
  TextStyle get bodySmall => textTheme.bodySmall!.copyWith(color: colorScheme.onSurface);
  TextStyle get labelLarge => textTheme.labelLarge!.copyWith(color: colorScheme.onSurface);
  TextStyle get labelMedium => textTheme.labelMedium!.copyWith(color: colorScheme.onSurface);
  TextStyle get labelSmall => textTheme.labelSmall!.copyWith(color: colorScheme.onSurface);
}
// mixin TypographyTheme {
//   TextTheme textTheme(ColorScheme colorScheme) {
//     return TextTheme(
//       displayLarge: TextStyle(
//         fontSize: 66,
//         color: colorScheme.primary,
//       ),
//       displayMedium: TextStyle(
//         fontSize: 22,
//         color: colorScheme.primary,
//       ),
//       displaySmall: TextStyle(
//         fontSize: 19,
//         color: colorScheme.primary,
//       ),
//       headlineMedium: TextStyle(
//         fontSize: 14,
//         color: colorScheme.primary,
//       ),
//     );
//   }
// }
