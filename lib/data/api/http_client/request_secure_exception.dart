/// A secure networking exception caused by a failure in the
/// TLS/SSL protocol.
class RequestSecureException implements Exception {
  const RequestSecureException({
    required this.httpStatusCode,
    this.response,
    this.responseValues,
    required this.requestPath,
    this.requestData,
    required this.requestMethod,
    required this.responseData,
    required this.exceptionType,
  });

  // ---------------------------------------------------------------------------
  static const String errorKey = 'Error';

  final int httpStatusCode;
  final Map<String, Object?>? response;
  final String? responseValues;
  final String requestPath;
  final Object? requestData;
  final String requestMethod;
  final Object? responseData;
  final Object? exceptionType;

  @override
  String toString() {
    return 'RequestSecureException: {'
        'httpStatusCode: $httpStatusCode, '
        'response: ${response?.toString() ?? "null"}, '
        'responseValues: ${responseValues ?? "null"}, '
        'requestPath: $requestPath, '
        'requestData: ${requestData?.toString() ?? "null"}, '
        'requestMethod: $requestMethod'
        'responseData: ${responseData?.toString() ?? "null"}, '
        'exceptionType: ${exceptionType?.toString() ?? "null"}, '
        '}';
  }
}
