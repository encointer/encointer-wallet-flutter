class HttpRequestException implements Exception {
  const HttpRequestException({this.error, this.stackTrace, this.statusCode});

  final dynamic error;
  final StackTrace? stackTrace;
  final int? statusCode;
}

class JsonDecodeException implements Exception {
  const JsonDecodeException({this.error, this.stackTrace});

  final dynamic error;
  final StackTrace? stackTrace;
}

class JsonDeserializationException implements Exception {
  const JsonDeserializationException({this.error, this.stackTrace});

  final dynamic error;
  final StackTrace? stackTrace;
}
