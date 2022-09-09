// исключение, вызванное ошибкой при запросе к API
class RequestException implements Exception {
  static const String errorKey = 'Error';

  final int httpStatusCode;
  final Map<String, Object?>? response;
  final String? responseValues;

  RequestException(
      {required this.httpStatusCode, this.response, this.responseValues});
}
