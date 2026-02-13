class IpfsUploadException implements Exception {
  IpfsUploadException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'IpfsUploadException: $message (status: $statusCode)';
}
