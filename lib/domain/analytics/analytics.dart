import '../interfaces/i_analytics.dart';

class Analytics implements IAnalytics {
  @override
  Future<void> onError({required Object error, Object? stacktrace}) async {
    // TODO: implement onError
    print(error);
    print(stacktrace);
  }

  @override
  Future<void> onEvent({required String eventName, String? eventText}) async {
    // TODO: implement onEvent
    print('$eventName  $eventText');
  }
}
