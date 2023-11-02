// исключение, вызванное ошибкой при запросе к API
import 'package:dio/dio.dart';

class RequestException implements Exception {
  const RequestException({
    required this.httpStatusCode,
    required this.headers,
    this.response,
    this.responseValues,
    required this.requestPath,
    this.requestData,
    required this.requestMethod,
  });

  // ---------------------------------------------------------------------------
  static const String errorKey = 'Error';

  final int httpStatusCode;
  final Map<String, dynamic>? headers;
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
        if (!withDots) {
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

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('> METHOD: $requestMethod')
      ..writeln('> HEADERS: $headers')
      ..writeln('> PATH: $requestPath');

    if (requestData != null) {
      if (requestData is FormData) {
        sb.writeln('> BODY: ${(requestData as FormData).fields}');
      } else {
        sb.writeln('> BODY: $requestData');
      }
    }
    sb
      ..writeln('< STATUS: $httpStatusCode')
      ..writeln(
          '< RESPONSE: ${response?.toString() ?? 'Response data is null'}');

    return sb.toString();
  }
}
