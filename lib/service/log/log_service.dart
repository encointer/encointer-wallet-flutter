import 'dart:developer';

class Log {
  static void e(String message, [String? description, StackTrace? stackTrace]) {
    log('[ERROR] ${description ?? ''} ==> : ${_replaceSensitiveText(message)} ${stackTrace ?? ''}');
  }

  static void d(String message, [String? description, StackTrace? stackTrace]) {
    log('[DEBUG] ${description ?? ''} ==> : ${_replaceSensitiveText(message)} ${stackTrace ?? ''}');
  }

  static void p(String message, [String? description, StackTrace? stackTrace]) {
    ///TODO(Azamat): should we use [debugPrint] instead of [log] here?
    log('[PRINT] ${description ?? ''} ==> : ${_replaceSensitiveText(message)} ${stackTrace ?? ''}');
  }

  static const pubKey = 'pubKey:';
  static const mnemonic = 'mnemonic:';
  static const encoded = 'encoded:';
  static const address = 'address:';
  static const rawSeed = 'rawSeed:';
  static const replacement = ' ************';

  static String _replaceSensitiveText(String message) {
    var replacedText = message;
    if (message.contains(pubKey)) {
      const start = pubKey;
      const end = ',';

      final startIndex = message.indexOf(start);
      final endIndex = message.indexOf(end, startIndex + start.length);
      if (endIndex == -1) {
        return message;
      } else {
        final textToReplace = message.substring(startIndex + start.length, endIndex);

        final pattern = RegExp(textToReplace, caseSensitive: false, multiLine: true, dotAll: true);
        replacedText = message.replaceAllMapped(pattern, (match) => replacement);

        replacedText = _replaceAddress(_replaceEncoded(_replaceMnemonic(_replaceRawSeed(replacedText))));
      }
    }

    return replacedText;
  }

  static String _replaceMnemonic(String message) {
    var replacedText = message;
    if (message.contains(mnemonic)) {
      const start = mnemonic;
      const end = ',';

      final startIndex = message.indexOf(start);
      final endIndex = message.indexOf(end, startIndex + start.length);

      if (endIndex == -1) {
        return message;
      } else {
        final textToReplace = message.substring(startIndex + start.length, endIndex);

        final pattern = RegExp(textToReplace, caseSensitive: false);
        replacedText = message.replaceFirstMapped(pattern, (match) => replacement);
      }
    }

    return replacedText;
  }

  static String _replaceRawSeed(String message) {
    var replacedText = message;
    if (message.contains(rawSeed)) {
      const start = rawSeed;
      const end = ',';

      final startIndex = message.indexOf(start);
      final endIndex = message.indexOf(end, startIndex + start.length);

      if (endIndex == -1) {
        return message;
      } else {
        final textToReplace = message.substring(startIndex + start.length, endIndex);

        final pattern = RegExp(textToReplace, caseSensitive: false);
        replacedText = message.replaceFirstMapped(pattern, (match) => replacement);
      }
    }

    return replacedText;
  }

  static String _replaceAddress(String message) {
    var replacedText = message;
    if (message.contains(address)) {
      const start = address;
      const end = ',';

      final startIndex = message.indexOf(start);
      final endIndex = message.indexOf(end, startIndex + start.length);

      if (endIndex == -1) {
        return message;
      } else {
        final textToReplace = message.substring(startIndex + start.length, endIndex);

        final pattern = RegExp(textToReplace, caseSensitive: false);
        replacedText = message.replaceFirstMapped(pattern, (match) => replacement);
      }
    }

    return replacedText;
  }

  static String _replaceEncoded(String message) {
    var replacedText = message;
    if (message.contains(encoded)) {
      const start = encoded;
      const end = ',';

      final startIndex = message.indexOf(start);
      final endIndex = message.indexOf(end, startIndex + start.length);

      if (endIndex == -1) {
        return message;
      } else {
        final textToReplace = message.substring(startIndex + start.length, endIndex);

        replacedText = message.replaceAll(textToReplace, replacement);
      }
    }

    return replacedText;
  }
}
