import 'dart:developer';

class Log {
  /// ```dart
  ///
  /// static void e(String message, [String? description, StackTrace? stackTrace]) {
  ///   log('[ERROR] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  /// }
  ///
  /// ```
  static void e(String message, [String? description, StackTrace? stackTrace]) {
    log('[ERROR] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  }

  /// ```dart
  ///
  /// static void d(String message, [String? description, StackTrace? stackTrace]) {
  ///   log('[DEBUG] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  /// }
  ///
  /// ```
  static void d(String message, [String? description, StackTrace? stackTrace]) {
    log('[DEBUG] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  }

  /// ```dart
  ///
  /// static void p(String message, [String? description, StackTrace? stackTrace]) {
  ///   log('[PRINT] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  /// }
  ///
  /// ```
  static void p(String message, [String? description, StackTrace? stackTrace]) {
    log('[PRINT] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  }
}
