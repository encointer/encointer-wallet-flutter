class HttpException implements Exception {
  const HttpException({
    required this.statusCode,
    this.error,
    this.stackTrace,
  });

  final int statusCode;
  final dynamic error;
  final StackTrace? stackTrace;
}
