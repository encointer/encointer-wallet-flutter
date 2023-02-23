/// Exception thrown if a storage operation fails.
class StorageException implements Exception {
  const StorageException([this.error, this.stackTrace]);

  /// Error thrown during the storage operation.
  final dynamic error;

  /// The stack trace associated with the error, if any.
  final StackTrace? stackTrace;
}
