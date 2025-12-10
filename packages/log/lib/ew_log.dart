import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

final bool _isRunningTests = Platform.environment.containsKey('FLUTTER_TEST');

/// A simple logging utility that masks sensitive information.
class Log {
  /// Logs an error message.
  static void e(String message, [String? description, StackTrace? stackTrace]) {
    lp('[ERROR] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  /// Logs a debug message.
  static void d(String message, [String? description, StackTrace? stackTrace]) {
    lp('[DEBUG] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  /// Logs a general print message.
  static void p(String message, [String? description, StackTrace? stackTrace]) {
    lp('[PRINT] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  /// Mask to be applied.
  static const replacement = ' ************';

  static String _replaceSensitiveInfo(String value) {
    final updatedString =
        value.replaceAllMapped(RegExp(r'(mnemonic:|rawSeed:)\s*\S+'), (match) => '${match.group(1)} $replacement');

    return updatedString;
  }
}

/// Logs a message and mirrors it to stdout if running tests.
void lp(String message) {
  log(message);
  if (_isRunningTests) {
    // Mirror to stdout so you see it in the test console
    debugPrint(message);
  }
}
