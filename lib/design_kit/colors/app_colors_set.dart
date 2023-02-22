import 'package:flutter/material.dart';

abstract class AppColorsSet {
  /// Primary
  Color get mainColor;

  Color get mainBackground;

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

  /// List of colors, example
  List<Color> get listOfColors;
}
