import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    new GlobalKey<ScaffoldMessengerState>();

class RootSnackBar {
  static void hideCurrent() {
    rootScaffoldMessengerKey.currentState!.hideCurrentSnackBar();
  }

  static void removeCurrent() {
    rootScaffoldMessengerKey.currentState!.removeCurrentSnackBar();
  }

  static void show(
    Widget content, {
    int durationMillis: 1500,
    backgroundColor: Colors.white,
  }) {
    showSnackBar(
      content,
      durationMillis: durationMillis,
      backgroundColor: backgroundColor,
    );
  }

  static void showMsg(
    String msg, {
    int durationMillis: 1500,
    textColor: Colors.black54,
    backgroundColor: Colors.white,
  }) {
    showSnackBar(
      Text(msg, style: TextStyle(color: textColor)),
      durationMillis: durationMillis,
      backgroundColor: backgroundColor,
    );
  }
}

void showSnackBar(
  Widget content, {
  int durationMillis: 1500,
  backgroundColor: Colors.white,
}) {
  rootScaffoldMessengerKey.currentState!.hideCurrentSnackBar();
  rootScaffoldMessengerKey.currentState!.removeCurrentSnackBar();
  rootScaffoldMessengerKey.currentState!
    ..showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        duration: Duration(milliseconds: durationMillis),
      ),
    );
}
