import 'package:flutter/services.dart';

class RegExInputFormatter implements TextInputFormatter {
  factory RegExInputFormatter.withRegex(String regexString) {
    final regex = RegExp(regexString);
    return RegExInputFormatter._(regex);
  }

  RegExInputFormatter._(this._regExp);
  final RegExp _regExp;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = _isValid(oldValue.text);
    final newValueValid = _isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }

  bool _isValid(String value) {
    try {
      final matches = _regExp.allMatches(value);
      for (final Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}
