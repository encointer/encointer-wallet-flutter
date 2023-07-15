import 'dart:convert';

class BusinessUtils {
  /// To correctly display German Umlauts coming from IPFS.
  static String utf8convert(String text) {
    final bytes = text.codeUnits;
    return utf8.decode(bytes);
  }
}
