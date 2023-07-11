extension MapExtensions<T, E> on Map<T, E>? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}
