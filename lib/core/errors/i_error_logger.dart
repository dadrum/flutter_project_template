abstract class IErrorLogger {
  // on event
  Future<void> onEvent({required String eventName, String? eventText});

  // on error
  Future<void> onError({required Object error, Object? stacktrace});

  Iterable<String> getStack();

  void clearStack();

  void bindLogMethod(Function(String)? logMethod);
}
