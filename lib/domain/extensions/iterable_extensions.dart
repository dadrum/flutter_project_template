extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) =>
      cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}

extension IterableAddUnique<T> on List<T> {
  // добавление новых уникальных записей
  Iterable<T> addUniqueIterable(Iterable<T> items) sync* {
    final asSet = toSet();
    yield* this;
    for (final newItem in items) {
      if (!asSet.contains(newItem)) {
        yield newItem;
      }
    }
  }

  // списки содержат хоть одну дублирующуюся запись
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
