import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();

class RootSnackBar {
  static void hideCurrent() {
    rootScaffoldMessengerKey.currentState.hideCurrentSnackBar();
  }

  static void removeCurrent() {
    rootScaffoldMessengerKey.currentState.removeCurrentSnackBar();
  }

  static void showMsg(
    String msg, {
    int durationMillis: 1500,
    textColor: Colors.black54,
    backgroundColor: Colors.white,
  }) {
    showSnackBar(
      msg,
      durationMillis: durationMillis,
      textColor: textColor,
      backgroundColor: backgroundColor,
    );
  }
}

void showSnackBar(
  String msg, {
  int durationMillis: 1500,
  textColor: Colors.black54,
  backgroundColor: Colors.white,
}) {
  rootScaffoldMessengerKey.currentState.hideCurrentSnackBar();
  rootScaffoldMessengerKey.currentState.removeCurrentSnackBar();
  rootScaffoldMessengerKey.currentState
    ..showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: Duration(milliseconds: durationMillis),
      ),
    );
}
