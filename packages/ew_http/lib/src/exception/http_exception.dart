class HttpStatusException implements Exception {
  const HttpStatusException({
    required this.statusCode,
    this.error,
    this.stackTrace,
  });

  final int statusCode;
  final dynamic error;
  final StackTrace? stackTrace;
}
