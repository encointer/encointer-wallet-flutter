import 'package:collection/collection.dart' show IterableExtension;

/// Parses a String into an enum
/// Recognizes patterns like: CeremonyPhase.Registering, CeremonyPhase.REGISTERING, Registering, REGISTERING,
T? getEnumFromString<T>(Iterable<T> values, String? value) {
  return values.firstWhereOrNull(
    (type) => type.toString().split('.').last.toUpperCase() == value.toString().split('.').last.toUpperCase(),
  );
}

String toEnumValue<T>(T enumValue) {
  return enumValue.toString().split('.').last;
}
