class ConvertException implements Exception {
  const ConvertException([this.error, this.stackTrace]);

  final dynamic error;
  final StackTrace? stackTrace;
}
