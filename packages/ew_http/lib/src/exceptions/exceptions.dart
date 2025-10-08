class EwHttpException implements Exception {
  const EwHttpException(this.failureType, {this.error, this.data, this.stackTrace, this.statusCode});

  final dynamic error;
  final dynamic data;
  final FailureType failureType;
  final StackTrace? stackTrace;
  final int? statusCode;

  @override
  String toString() {
    return 'EwHttpException: { failureType: $failureType, error: $error, data: $data, stackTrace: ${stackTrace?.toString() ?? 'null'}, statusCode: ${statusCode ?? 'null'} }';
  }
}

enum FailureType {
  /// Represents http error 400
  badRequest,

  /// Represents http error 401
  noAuthorization,

  /// Forbidden http error 403
  forbidden,

  /// Internal server http error 500
  internalServer,

  /// Json decode error
  decode,

  /// Json deserialization error
  deserialization,

  /// Unknown error
  unknown,
}
