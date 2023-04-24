import 'package:flutter/material.dart';

mixin CompomnentTheme {
  RoundedRectangleBorder get shapeMedium => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      );

  ElevatedButtonThemeData elevatedButtonThemeData(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.secondary,
        shadowColor: Colors.transparent,
        shape: shapeMedium,
      ),
    );
  }

  IconThemeData iconTheme(ColorScheme colorScheme) {
    return IconThemeData(color: colorScheme.secondary);
  }

  AppBarTheme appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      centerTitle: true,
      foregroundColor: colorScheme.secondary,
    );
  }

  // CardTheme cardTheme() {
  //   return const CardTheme();
  // }
  // ButtonThemeData buttonTheme(MaterialColor primarySwatch) {
  //   return const ButtonThemeData();
  // }
  // InputDecorationTheme inputDecorationTheme(MaterialColor primarySwatch) {
  //   return const InputDecorationTheme(
  //     border: OutlineInputBorder(),
  //   );
  // }
  // ListTileThemeData listTileTheme(MaterialColor primarySwatch) {
  //   return const ListTileThemeData();
  // }
  // TabBarTheme tabBarTheme(MaterialColor primarySwatch) {
  //   return const TabBarTheme();
  // }
  // BottomAppBarTheme bottomAppBarTheme(MaterialColor primarySwatch) {
  //   return const BottomAppBarTheme();
  // }
  // BottomNavigationBarThemeData bottomNavigationBarTheme(MaterialColor primarySwatch) {
  //   return const BottomNavigationBarThemeData();
  // }
  // NavigationRailThemeData navigationRailTheme(MaterialColor primarySwatch) {
  //   return const NavigationRailThemeData();
  // }
  // DrawerThemeData drawerTheme(MaterialColor primarySwatch) {
  //   return const DrawerThemeData();
  // }
  // ScrollbarThemeData scrollbarThemeData(MaterialColor primarySwatch) {
  //   return const ScrollbarThemeData();
  // }
}
