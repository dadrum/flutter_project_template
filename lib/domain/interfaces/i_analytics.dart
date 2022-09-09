abstract class IAnalytics {
  // on event
  Future<void> onEvent({required String eventName, String? eventText});

  // on error
  Future<void> onError({required Object error, Object? stacktrace});
}
