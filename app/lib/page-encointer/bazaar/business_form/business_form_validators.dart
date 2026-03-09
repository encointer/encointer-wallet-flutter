/// Pure validation functions for the business form.
/// No Flutter/l10n dependency — returns bool, form wires error messages.
class BusinessFormValidators {
  /// Name must have at least 2 non-whitespace characters.
  static bool isValidName(String? value) {
    if (value == null) return false;
    return value.replaceAll(RegExp(r'\s'), '').length >= 2;
  }

  /// Telephone: digits, plus, dashes, spaces, parentheses; min 6 chars.
  static bool isValidTelephone(String value) {
    return RegExp(r'^[0-9+\-\s()]{6,}$').hasMatch(value);
  }

  /// Email: basic format (local@domain.tld), no spaces.
  static bool isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  /// URL: must have http or https scheme and a non-empty host.
  static bool isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
  }
}
