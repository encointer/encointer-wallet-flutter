import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.pink,
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
      ),
      headline2: TextStyle(
        fontSize: 22,
      ),
      headline3: TextStyle(
        fontSize: 20,
      ),
      headline4: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      button: TextStyle(
        color: Colors.white,
        fontSize: 18,
      )),
);
// TODO: dark theme has display issues
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.pink,
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
      ),
      headline2: TextStyle(
        fontSize: 22,
      ),
      headline3: TextStyle(
        fontSize: 20,
      ),
      headline4: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      button: TextStyle(
        color: Colors.white,
        fontSize: 18,
      )),
);

const MaterialColor kusamaBlack = const MaterialColor(
  0xFF222222,
  const <int, Color>{
    50: const Color(0xFF555555),
    100: const Color(0xFF444444),
    200: const Color(0xFF444444),
    300: const Color(0xFF333333),
    400: const Color(0xFF333333),
    500: const Color(0xFF222222),
    600: const Color(0xFF111111),
    700: const Color(0xFF111111),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);

final appThemeKusama = ThemeData(
  primarySwatch: kusamaBlack,
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
      ),
      headline2: TextStyle(
        fontSize: 22,
      ),
      headline3: TextStyle(
        fontSize: 20,
      ),
      headline4: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      button: TextStyle(
        color: Colors.white,
        fontSize: 18,
      )),
);

final appThemeEncointer = ThemeData(
  // primarySwatch: Colors.green,
  primaryColor: Color(0xff4374A3),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 66,
      color: Color(0xff4374A3),
    ),
    headline2: TextStyle(
      fontSize: 22,
      color: Color(0xff4374A3),
    ),
    headline3: TextStyle(
      fontSize: 19,
      color: Color(0xff4374A3),
    ),
    headline4: TextStyle(
      fontSize: 14,
      color: Color(0xff4374A3),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xffF4F8F9),
      onPrimary: Color(0xff4374A3),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  ),
);

final appThemeLaminar = ThemeData(
  primarySwatch: Colors.deepPurple,
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
      ),
      headline2: TextStyle(
        fontSize: 22,
      ),
      headline3: TextStyle(
        fontSize: 20,
      ),
      headline4: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      button: TextStyle(
        color: Colors.white,
        fontSize: 18,
      )),
);

// TODO later: maybe turn into a function that takes the 2 colors and returns the gradient
final encointerGradient = LinearGradient(
  begin: Alignment(-.9, 0),
  end: Alignment(0.1, -.1),
  colors: <Color>[Color(0xff3880BD), Color(0xff3969AC)],
);
