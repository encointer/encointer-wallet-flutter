const unsupportedNegativeValuesMsg = 'Negative values are not supported yet';

class FixedPointException implements Exception {
  const FixedPointException(this.message);

  factory FixedPointException.unsupportedNegativeValues() => const FixedPointException(unsupportedNegativeValuesMsg);

  final String message;

  @override
  String toString() {
    return 'FixedPointException: $message';
  }
}
