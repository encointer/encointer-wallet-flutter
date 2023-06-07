import 'package:flutter/material.dart';

mixin CompomnentTheme {
  RoundedRectangleBorder get roundedRectBorder20 => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      );

  ElevatedButtonThemeData elevatedButtonThemeData(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.secondary,
        shadowColor: Colors.transparent,
        shape: roundedRectBorder20,
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

  CardTheme cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.background,
    );
  }

  // TODO(eldiiar): Use this code for set theme components
  // ButtonThemeData buttonTheme(ColorScheme colorScheme) {
  //   return const ButtonThemeData();
  // }
  // InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {
  //   return const InputDecorationTheme(
  //     border: OutlineInputBorder(),
  //   );
  // }
  // ListTileThemeData listTileTheme(ColorScheme colorScheme) {
  //   return const ListTileThemeData();
  // }
  // TabBarTheme tabBarTheme(ColorScheme colorScheme) {
  //   return const TabBarTheme();
  // }
  // BottomAppBarTheme bottomAppBarTheme(ColorScheme colorScheme) {
  //   return const BottomAppBarTheme();
  // }
  // BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colorScheme) {
  //   return const BottomNavigationBarThemeData();
  // }
  // NavigationRailThemeData navigationRailTheme(ColorScheme colorScheme) {
  //   return const NavigationRailThemeData();
  // }
  // DrawerThemeData drawerTheme(ColorScheme colorScheme) {
  //   return const DrawerThemeData();
  // }
  // ScrollbarThemeData scrollbarThemeData(ColorScheme colorScheme) {
  //   return const ScrollbarThemeData();
  // }
}
