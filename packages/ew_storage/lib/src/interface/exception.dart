/// Exception thrown if a storage operation fails.
class StorageException implements Exception {
  const StorageException(this.error);

  /// Error thrown during the storage operation.
  final Object error;
}
