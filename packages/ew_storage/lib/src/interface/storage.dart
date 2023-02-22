/// A Dart EwStorage Client Interface
abstract class EwStorage {
  /// Returns value for the provided [key].
  /// Read returns `null` if no value is found for the given [key].
  /// Throws a [Exception] if the read fails.
  Future<String?> readAsync({required String key});

  /// Returns value for the provided [key].
  /// Read returns `null` if no value is found for the given [key].
  /// Throws a [Exception] if the read fails.
  T? read<T>({required String key});

  /// Writes the provided [key], [value] pair asynchronously.
  /// Throws a [Exception] if the write fails.
  Future<void> write<T>({required String key, required T value});

  /// Removes the value for the provided [key] asynchronously.
  /// Throws a [Exception] if the delete fails.
  Future<void> delete({required String key});

  /// Removes all key, value pairs asynchronously.
  /// Throws a [Exception] if the delete fails.
  Future<void> clear();
}
