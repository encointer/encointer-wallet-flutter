class HttpStatusException implements Exception {
  const HttpStatusException({
    this.error,
    this.stackTrace,
  });

  final dynamic error;
  final StackTrace? stackTrace;
}
