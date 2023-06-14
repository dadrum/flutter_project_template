// исключение, вызванное ошибкой при запросе к API
class RequestException implements Exception {
  const RequestException({
    required this.httpStatusCode,
    this.response,
    this.responseValues,
    required this.requestPath,
    this.requestData,
    required this.requestMethod,
  });

  // ---------------------------------------------------------------------------
  static const String errorKey = 'Error';

  final int httpStatusCode;
  final Map<String, Object?>? response;
  final String? responseValues;
  final String requestPath;
  final Object? requestData;
  final String requestMethod;

  /// Возвращает сообщение об ошибке по тегу, если указанного тэга не найдено, возвращает null
  String? getMsgByTag(String errorKey, {bool withDots = false}) {
    final e = this;
    if (e.response?.keys.contains(errorKey) ?? false) {
      final keyValue = e.response![errorKey];
      if (keyValue is Iterable) {
        final errors = keyValue.map((dynamic item) => '$item').toList();
        if (withDots == false) {
          return errors.join(' ');
        } else {
          return errors.join('. ');
        }
      } else {
        return '$keyValue';
      }
    } else {
      return null;
    }
  }
}
