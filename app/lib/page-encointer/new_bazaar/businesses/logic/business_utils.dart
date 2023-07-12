import 'dart:convert';

class BusinessUtils {
  /// To display, correctly, german names coming from server
  static String utf8convert(String text) {
    final bytes = text.codeUnits;
    return utf8.decode(bytes);
  }
}
