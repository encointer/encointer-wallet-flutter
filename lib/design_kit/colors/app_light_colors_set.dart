import 'package:encointer_wallet/design_kit/colors/app_colors_set.dart';
import 'package:flutter/material.dart';

class AppLightColorsSet extends AppColorsSet {
  @override
  // TODO: implement black
  Color get black => Colors.black;

  @override
  // TODO: implement error
  Color get error => const Color.fromARGB(255, 249, 15, 15);

  @override
  // TODO: implement gradients
  LinearGradient get gradients => const LinearGradient(
        colors: [
          Color(0xFFF2E3DE),
          Color(0xFFFCE2FC),
        ],
      );

  @override
  // TODO: implement gray1
  Color get gray => throw UnimplementedError();

  @override
  // TODO: implement listOfColors
  List<Color> get listOfColors => const [
        Color(0xFFA8EDEA),
        Color(0xFFFED6E3),
      ];

  @override
  // TODO: implement mainBackground
  Color get mainBackground => throw UnimplementedError();

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();

  @override
  // TODO: implement pending
  Color get pending => throw UnimplementedError();

  @override
  // TODO: implement secondaryBackground
  Color get secondaryBackground => throw UnimplementedError();

  @override
  // TODO: implement secondaryColor
  Color get secondaryColor => throw UnimplementedError();

  @override
  // TODO: implement success
  Color get success => throw UnimplementedError();

  @override
  // TODO: implement transparent
  Color get transparent => Colors.transparent;

  @override
  // TODO: implement white
  Color get white => Colors.white;
}
