// исключение, вызванное ошибкой при запросе к API
class RequestException implements Exception {
  static const String errorKey = 'Error';

  final int httpStatusCode;
  final Map<String, Object?>? response;
  final String? responseValues;
  final String requestPath;
  final Object? requestData;
  final String requestMethod;

  RequestException({
    required this.httpStatusCode,
    this.response,
    this.responseValues,
    required this.requestPath,
    this.requestData,
    required this.requestMethod,
  });
}
