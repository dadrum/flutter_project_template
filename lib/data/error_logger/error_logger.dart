import '../../core/errors/i_error_logger.dart';
import '../api/http_client/request_exception.dart';

class CustomErrorLogger implements IErrorLogger {
  final List<String> _stack = [];

  Function(String)? _sendLogMethod;

  @override
  Future<void> onError({required Object error, Object? stacktrace}) async {
    // TODO(Admin): implement onError
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
    // TODO(Admin): #some text to send
    _sendLogMethod?.call('');
  }

  @override
  Future<void> onEvent({required String eventName, String? eventText}) async {
    // TODO(Admin): implement onEvent
    // print('$eventName  $eventText');
    // TODO(Admin): #some text to send
    _sendLogMethod?.call('');
  }

  @override
  Iterable<String> getStack() => Iterable.castFrom(_stack);

  @override
  void clearStack() => _stack.clear();

  @override
  void bindLogMethod(Function(String)? logMethod) => _sendLogMethod = logMethod;
}
