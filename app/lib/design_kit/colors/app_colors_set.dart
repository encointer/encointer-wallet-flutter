import 'package:flutter/material.dart';

abstract class AppColorsSet {
  /// Primary
  Color get mainColor;

  Color get mainBackground;

  Color get encointerGrey;

  Color get encointerBlack;

  /// Secondary
  Color get secondaryColor;

  Color get secondaryBackground;

  /// General
  Color get white;

  Color get black;

  Color get gray;

  Color get transparent;

  /// Transaction States
  Color get success;

  Color get pending;

  Color get error;

  /// Gradients, example
  LinearGradient get gradients;

  LinearGradient get primaryGradient;

  /// List of colors, example
  List<Color> get listOfColors;

  MaterialColor get zurichLion;
}
