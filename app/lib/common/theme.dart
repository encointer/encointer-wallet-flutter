import 'package:flutter/material.dart';

final appThemeEncointer = ThemeData(
  primarySwatch: zurichLion,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 66,
      color: zurichLion.shade500,
    ),
    displayMedium: TextStyle(
      fontSize: 22,
      color: zurichLion.shade500,
    ),
    displaySmall: TextStyle(
      fontSize: 19,
      color: zurichLion.shade500,
    ),
    headlineMedium: TextStyle(
      fontSize: 14,
      color: zurichLion.shade500,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: zurichLion.shade50,
      foregroundColor: zurichLion.shade500,
      shadowColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  ),
  iconTheme: IconThemeData(
    color: zurichLion.shade500,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    // foregroundColor: Colors.orange, // this gets for some reason ignored and we have to define iconTheme and textTheme
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: zurichLion.shade500,
    ),
    shadowColor: Colors.transparent,
    centerTitle: true,
    toolbarTextStyle: TextTheme(
      titleLarge: TextStyle(
        // it's not obvious but appBar uses headline6
        fontSize: 19,
        color: zurichLion.shade500,
      ),
    ).bodyMedium,
    titleTextStyle: TextTheme(
      titleLarge: TextStyle(
        // it's not obvious but appBar uses headline6
        fontSize: 19,
        color: zurichLion.shade500,
      ),
    ).titleLarge,
  ),
  scaffoldBackgroundColor: Colors.white,
);

const MaterialColor zurichLion = MaterialColor(
  0xFF79C943, // <-- primary green color
  <int, Color>{
    50: Color(0xFFF6FAF1), // <--- used for light green buttons (i.e. secondary buttons)
    100: Color(0xFFF6FAF1),
    200: Color(0xFFF6FAF2),
    300: Color(0xFF93C47D), // <--- medium green border color of progress bar
    400: Color(0xFF7CB342), // <--- starting color of gradient
    500: Color(0xFF0D8102), // <--- main color for almost all texts
    600: Color(0xFF35B731), // <--- end color of gradient
    700: Color(0xFF35B733),
    800: Color(0xFF34B032),
    900: Color(0xFF004D08), // <--- dark green for the scan bottomButtonBar icon
  },
);

const MaterialColor zurichLion3 = MaterialColor(
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
const Color encointerGrey = Color(0xff666666);
const Color encointerBlack = Color(0xff353535);

// TODO later: maybe turn into a function that takes the 2 colors and returns the gradient
final primaryGradient = LinearGradient(
  begin: const Alignment(-.9, 0),
  end: const Alignment(0.1, -.1),
  colors: <Color>[zurichLion.shade400, zurichLion.shade600],
);
