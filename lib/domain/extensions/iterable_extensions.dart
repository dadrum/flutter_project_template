extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) =>
      cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}

extension IterableAny<T> on List<T> {
  // the lists contain at least one duplicate entry
  bool containsAny(Iterable<T> items) {
    final asSet = toSet();
    for (final newItem in items) {
      if (asSet.contains(newItem)) {
        return true;
      }
    }
    return false;
  }
}
