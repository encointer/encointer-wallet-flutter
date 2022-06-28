import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();

class RootSnackBar {

  static void hideCurrent() {
    rootScaffoldMessengerKey.currentState.hideCurrentSnackBar();
  }

  static void removeCurrent() {
    rootScaffoldMessengerKey.currentState.removeCurrentSnackBar();
  }

  static void show(String msg) {
    showSnackBar(msg);
  }
}

void showSnackBar(String msg) {
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
