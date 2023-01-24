import '../../data/api/http_client/request_exception.dart';
import '../interfaces/i_analytics.dart';

class Analytics implements IAnalytics {
  @override
  Future<void> onError({required Object error, Object? stacktrace}) async {
    // TODO: implement onError
    if (error is RequestException) {
      // print(error);
      // print(error.requestPath);
      // print(error.requestMethod);
      // print(error.requestData);
      // print(error.httpStatusCode);
      // print(error.response);
    } else {
      // print(error);
    }
    // print(stacktrace);
  }

  @override
  Future<void> onEvent({required String eventName, String? eventText}) async {
    // TODO: implement onEvent
    // print('$eventName  $eventText');
  }
}
