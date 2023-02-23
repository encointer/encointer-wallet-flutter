/// A Dart EwStorage Client Interface
abstract class EwStorage {
  /// Returns value for the provided [key].
  /// Read returns `null` if no value is found for the given [key].
  /// Throws a [Exception] if the read fails.
  Future<String?> read({required String key});

  /// Writes the provided [key], [value] pair asynchronously.
  /// Throws a [Exception] if the write fails.
  Future<void> writeString({required String key, required String value});

  /// Removes the value for the provided [key] asynchronously.
  /// Throws a [Exception] if the delete fails.
  Future<void> delete({required String key});

  /// Removes all key, value pairs asynchronously.
  /// Throws a [Exception] if the delete fails.
  Future<void> clear();
}
