import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();

class RootSnackBar {
  static void hideCurrent() {
    rootScaffoldMessengerKey.currentState.hideCurrentSnackBar();
  }

  static void removeCurrent() {
    rootScaffoldMessengerKey.currentState.removeCurrentSnackBar();
  }

  static void show(String msg, {int durationMillis: 1500}) {
    showSnackBar(msg, durationMillis: durationMillis);
  }
}

void showSnackBar(String msg, {int durationMillis: 1500}) {
  rootScaffoldMessengerKey.currentState.hideCurrentSnackBar();
  rootScaffoldMessengerKey.currentState.removeCurrentSnackBar();
  rootScaffoldMessengerKey.currentState
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(msg, style: TextStyle(color: Colors.black54)),
        duration: Duration(milliseconds: 1500),
      ),
    );
}
