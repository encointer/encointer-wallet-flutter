import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

final bool _isRunningTests = Platform.environment.containsKey('FLUTTER_TEST');

class Log {
  static void e(String message, [String? description, StackTrace? stackTrace]) {
    lp('[ERROR] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  static void d(String message, [String? description, StackTrace? stackTrace]) {
    lp('[DEBUG] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  static void p(String message, [String? description, StackTrace? stackTrace]) {
    lp('[PRINT] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  static const replacement = ' ************';

  static String _replaceSensitiveInfo(String value) {
    final updatedString =
    value.replaceAllMapped(RegExp(r'(mnemonic:|rawSeed:)\s*\S+'), (match) => '${match.group(1)} $replacement');

    return updatedString;
  }
}

void lp(String message) {
  log(message);
  if (_isRunningTests) {
    // Mirror to stdout so you see it in the test console
    debugPrint(message);
  }
}
