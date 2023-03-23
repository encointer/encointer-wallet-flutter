import 'package:encointer_wallet/design_kit/colors/app_colors_set.dart';
import 'package:flutter/material.dart';

class AppDarkColorsSet extends AppColorsSet {
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

  @override
  LinearGradient get primaryGradient => LinearGradient(
        begin: const Alignment(-.9, 0),
        end: const Alignment(0.1, -.1),
        colors: <Color>[zurichLion.shade400, zurichLion.shade600],
      );

  @override
  MaterialColor get zurichLion => const MaterialColor(
        0xff4374A3,
        <int, Color>{
          50: Color(0xffF4F8F9), // <--- used for light blue buttons (i.e. secondary buttons)
          100: Color(0xffF4F8F9),
          200: Color(0xffF4F8F9),
          300: Color(0xffBCCEE0), // <--- medium blue border color of progress bar
          400: Color(0xFF3880BD), // <--- starting color of gradient
          500: Color(0xff4374A3), // <--- main color for almost all texts
          600: Color(0xFF3969AC), // <--- end color of gradient
          700: Color(0xFF3969AC),
          800: Color(0xFF3969AC),
          900: Color(0xFF000022), // <--- dark blue for the scan bottomButtonBar icon
        },
      );

  @override
  Color get encointerBlack => const Color(0xff353535);

  @override
  Color get encointerGrey => const Color(0xff666666);
}
