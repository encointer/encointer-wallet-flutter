extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) => cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}

extension IterableExtensions<T> on Iterable<T>? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}
