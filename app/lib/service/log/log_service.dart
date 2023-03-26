import 'dart:developer';

class Log {
  static void e(String message, [String? description, StackTrace? stackTrace]) {
    log('[ERROR] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  static void d(String message, [String? description, StackTrace? stackTrace]) {
    log('[DEBUG] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  static void p(String message, [String? description, StackTrace? stackTrace]) {
    log('[PRINT] ${description ?? ''} ==> : ${_replaceSensitiveInfo(message)} ${stackTrace ?? ''}');
  }

  static const replacement = ' ************';

  static String _replaceSensitiveInfo(String value) {
    final updatedString =
        value.replaceAllMapped(RegExp(r'(mnemonic:|rawSeed:)\s*\S+'), (match) => '${match.group(1)} $replacement');

    return updatedString;
  }
}
