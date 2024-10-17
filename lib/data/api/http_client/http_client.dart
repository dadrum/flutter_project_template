import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../domain/interfaces/i_authenticate_repository.dart';
import 'i_api_request.dart';
import 'request_canceled.dart';
import 'request_exception.dart';
import 'request_timeout_exception.dart';

enum AvailableApiMethods { get, post, put, delete, patch }

class DioClient {
  DioClient({bool useLocaleSettings = false}) {
    _baseUrl = const String.fromEnvironment('API_URL');

    // настройка использования разных языков
    if (useLocaleSettings) {
      _localeSettings = englishLocaleSettings;
    }
    _useLocaleSettings = useLocaleSettings;

    _initNewDioClient();
  }

  // ---------------------------------------------------------------------------
  Dio? _dio;
  late BaseOptions _dioOptions;

  // ---------------------------------------------------------------------------
  static const bool debugMode = true;

  static const String englishLocaleSettings = 'en';
  static const String russianLocaleSettings = 'ru';

  // listener for authenticate events
  IAuthenticateController? authenticateController;

  // listener for authenticate events
  Function(String)? _requestsLogger;

  String? _refreshToken;

  late final String _baseUrl;

  String get apiUrl => _baseUrl;

  // использование данных о языке в заголовке запроса
  late bool _useLocaleSettings;
  String? _localeSettings;

  // ---------------------------------------------------------------------------
  // инициализация HTTP-клиента с заданными настройками
  // и заголовком
  void _initNewDioClient({String accessToken = '', String? refreshToken}) {
    _dio?.interceptors.removeWhere((element) => true);

    _refreshToken = refreshToken;

    // собираем данные для заголовка
    final Map<String, Object?> headers = {};
    // установка токена
    if (accessToken.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] =
          _getTokenWithBearer(accessToken);
    }
    // установка выбранной локали
    if (_useLocaleSettings && (_localeSettings?.isNotEmpty ?? false)) {
      headers[HttpHeaders.acceptLanguageHeader] = _localeSettings;
    }

    _dioOptions = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds: 25000),
      receiveTimeout: const Duration(milliseconds: 25000),
      headers: headers,
    );
    _dio = Dio(_dioOptions);

    _dio?.interceptors.add(loggerInterceptor());
    _dio?.interceptors.add(invalidAccessTokenInterceptor());
    _dio?.interceptors.add(authErrorInterceptor());
  }

  // ---------------------------------------------------------------------------
  // инициализация HTTP-клиента с указанными настройками заголовка
  void _updateNewDioWithHeader(Map<String, Object?> newHeaders) {
    if (_dio == null) return;

    _dio!.interceptors.removeWhere((element) => true);

    _dioOptions = _dio!.options.copyWith(headers: newHeaders);

    _dio = Dio(_dioOptions);

    _dio?.interceptors.add(loggerInterceptor());
    _dio?.interceptors.add(invalidAccessTokenInterceptor());
    _dio?.interceptors.add(authErrorInterceptor());
  }

  // ---------------------------------------------------------------------------
  // установка выбранной локали
  // принимаются строки "RU", "Ru-ru", "ru, RU" и т.д.
  Future<void> setLocaleSettings(String newLocaleSettings) async {
    if (newLocaleSettings.toLowerCase().contains('ru')) {
      _localeSettings = russianLocaleSettings;
    } else {
      _localeSettings = englishLocaleSettings;
    }
    _useLocaleSettings = true;

    final newHeader = _dioOptions.headers;
    newHeader[HttpHeaders.acceptLanguageHeader] = _localeSettings;

    _updateNewDioWithHeader(newHeader);
  }

  // ---------------------------------------------------------------------------
  String _getTokenWithBearer(String token) {
    if (token.startsWith('Bearer ')) {
      return token;
    } else {
      return 'Bearer $token';
    }
  }

  // ---------------------------------------------------------------------------
  QueuedInterceptorsWrapper authErrorInterceptor() => QueuedInterceptorsWrapper(
        onResponse: (response, handler) {
          // _continuous401ErrorsCounter = 0;
          return handler.next(response);
        },
        onError: (dioError, handler) async {
          // если поступила ошибка аутентификации
          if (dioError.response?.statusCode == HttpStatus.unauthorized &&
              (_refreshToken?.isNotEmpty ?? false)) {
            // запрашиваем новый токен
            final Map<String, Object?>? tokensPair = await _requestNewToken();

            // если токены получены - сохраняем в клиент и передаем слушателям
            String? receivedAccessToken;
            String? receivedRefreshToken;
            if (tokensPair != null &&
                tokensPair.containsKey('access') &&
                tokensPair.containsKey('refresh')) {
              receivedAccessToken = '${tokensPair['access']}';
              receivedRefreshToken = '${tokensPair['refresh']}';

              _dioOptions.headers[HttpHeaders.authorizationHeader] =
                  _getTokenWithBearer(receivedAccessToken);

              _refreshToken = receivedRefreshToken;
              await authenticateController?.onAuthenticated(
                  receivedAccessToken, receivedRefreshToken);
            } else {
              clearTokens();
              await authenticateController?.onAuthenticateCanceled();
              handler.reject(dioError);
              return;
            }

            // если токен был получен - пробуем повторить запрос
            // на котором поучили 401
            if (receivedAccessToken.isNotEmpty) {
              try {
                // only for VERIFY request - change token in DATA
                final originalRequestData =
                    dioError.requestOptions.data as Map<String, Object?>?;

                final Response<String> response =
                    await _dio!.request<String>(dioError.requestOptions.path,
                        data: originalRequestData,
                        options: Options(
                          method: dioError.requestOptions.method,
                          headers: _dioOptions.headers,
                        ));
                handler.resolve(response);
                return;
              } on DioException catch (e) {
                if ((e.response?.statusCode ?? 0) == HttpStatus.forbidden) {
                  clearTokens();
                  await authenticateController?.onAuthenticateCanceled();
                  handler.next(dioError);
                  return;
                }
              } on Object {
                rethrow;
              }
            }
            handler.next(dioError);
            return;
          }
          handler.reject(dioError);
        },
      );

  // ---------------------------------------------------------------------------
  InterceptorsWrapper invalidAccessTokenInterceptor() => InterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (dioError, handler) async {
          // если поступила ошибка о том, что токен невалидный
          if (dioError.response?.statusCode == 418) {
            clearTokens();
            unawaited(authenticateController?.onAuthenticateCanceled());
            handler.reject(dioError);
          } else {
            handler.next(dioError);
          }
        },
      );

  // ---------------------------------------------------------------------------
  QueuedInterceptorsWrapper loggerInterceptor() => QueuedInterceptorsWrapper(
        onResponse: (response, handler) {
          final sb = StringBuffer()
            ..writeln('> HEADERS: ${response.requestOptions.headers}')
            ..writeln(
                '> ${response.requestOptions.method}: ${response.requestOptions.path}');

          if (response.requestOptions.data != null) {
            if (response.requestOptions.data is FormData) {
              sb.writeln(
                  '> BODY: ${(response.requestOptions.data as FormData).fields}');
            } else {
              sb.writeln('> BODY: ${response.requestOptions.data}');
            }
          }
          sb
            ..writeln('< STATUS: ${response.statusCode}')
            ..writeln('< RESPONSE: $response');
          _requestsLogger?.call(sb.toString());
          return handler.next(response);
        },
        onError: (dioError, handler) async {
          final sb = StringBuffer()
            ..writeln('> HEADERS: ${dioError.requestOptions.headers}')
            ..writeln(
                '> ${dioError.requestOptions.method}: ${dioError.requestOptions.path}');

          if (dioError.requestOptions.data != null) {
            if (dioError.requestOptions.data is FormData) {
              sb.writeln(
                  '> BODY: ${(dioError.requestOptions.data as FormData).fields}');
            } else {
              sb.writeln('> BODY: ${dioError.requestOptions.data}');
            }
          }
          sb
            ..writeln('< STATUS: ${dioError.response?.statusCode}')
            ..writeln('< RESPONSE: $dioError');
          _requestsLogger?.call(sb.toString());
          return handler.next(dioError);
        },
      );

  // ---------------------------------------------------------------------------
  // обновление токена в отдельном клиенте
  Future<Map<String, Object?>?> _requestNewToken() async {
    if (_refreshToken?.isEmpty ?? true) {
      return null;
    }

    final Map<String, Object> body = <String, Object>{
      'refresh': _refreshToken!
    };
    final String url = '$_baseUrl/User/Token/Refresh';

    try {
      final Response<String> response =
          await Dio(_dioOptions).post<String>(url, data: body);

      if (debugMode) {
        _logger(url, response, body: body);
      }

      if (response.statusCode == 200 && (response.data?.isNotEmpty ?? false)) {
        final Map<String, Object?> data =
            jsonDecode(response.data!) as Map<String, Object?>;
        return data;
      }
    } on Object {
      return null;
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  void setAuthenticateController(IAuthenticateController controller) {
    authenticateController = controller;
  }

  // ---------------------------------------------------------------------------
  void setRequestsLogger(Function(String) requestsLogger) {
    _requestsLogger = requestsLogger;
  }

  // ---------------------------------------------------------------------------
  void removeAuthenticateController() {
    authenticateController = null;
  }

  // ---------------------------------------------------------------------------
  void setTokens(String access, String refresh) {
    _initNewDioClient(accessToken: access);
    _refreshToken = refresh;
  }

  // ---------------------------------------------------------------------------
  void clearTokens() {
    setTokens('', '');
  }

  // ---------------------------------------------------------------------------
  void _logger(String url, Response<dynamic>? response, {Object? body}) {
    dev.log('V___________________________________');
    dev.log('> METHOD: ${response?.requestOptions.method ?? 'Unknown method'}');
    dev.log(
        '> HEADERS: ${response?.requestOptions.headers.toString() ?? 'Unknown headers'}');
    dev.log('> PATH: ${response?.requestOptions.path ?? url}');
    if (body != null) {
      if (body is FormData) {
        dev.log('> BODY: ${body.fields}');
      } else {
        dev.log('> BODY: $body');
      }
    }
    dev.log(
        '< STATUS: ${response?.statusCode?.toString() ?? 'Unknown statusCode'}');
    dev.log(
        '< RESPONSE: ${response?.data?.toString() ?? 'Response data is null'}');
    dev.log('^------------------------------------');
  }

  // ---------------------------------------------------------------------------
  Future<Response<Object?>?> request(
    /// request - экземпляр запроса
    IApiRequest request, {
    /// Опциональный: getProgress - void Function(double rate), где rate - прогресс выполнения от 0 до 1
    void Function(double)? receiveProgress,

    /// Фиговина для ручного прекращения выполнения сетевого запроса (применяется для прерывания отправки видео-файлов)
    CancelToken? cancelTokenForPostData,

    /// Опциональный: postProgress - void Function(double rate), где rate - прогресс выполнения от 0 до 1
    void Function(double)? sendProgress,
  }) async {
    if (_dio == null) throw UnimplementedError('Dio is not initialized');

    final String url = '$_baseUrl${request.endPoint}';
    try {
      Response<String> response;

      switch (request.methodType) {
        case AvailableApiMethods.delete:
          response = await _dio!.delete<String>(url, data: request.body);
        case AvailableApiMethods.get:
          response = await _dio!.get<String>(
            url,
            onReceiveProgress: (part, full) => receiveProgress?.call(
              full == 0 ? 1 : part / full,
            ),
            // options: Options(
            //   responseType: ResponseType.bytes,
            //   followRedirects: true,
            //   validateStatus: (s) => s != null && s >= 200 && s < 300,
            // ),
          );
        case AvailableApiMethods.post:
          response = await _dio!.post<String>(
            url,
            data: request.body,
            cancelToken: cancelTokenForPostData,
            onSendProgress: (part, full) => sendProgress?.call(
              full == 0 ? 1 : part / full,
            ),
            onReceiveProgress: (part, full) => receiveProgress?.call(
              full == 0 ? 1 : part / full,
            ),
          );
        case AvailableApiMethods.put:
          response = await _dio!.put<String>(
            url,
            data: request.body,
            onSendProgress: (part, full) => sendProgress?.call(
              full == 0 ? 1 : part / full,
            ),
            onReceiveProgress: (part, full) => receiveProgress?.call(
              full == 0 ? 1 : part / full,
            ),
          );
        case AvailableApiMethods.patch:
          response = await _dio!.patch<String>(
            url,
            data: request.body,
            onSendProgress: (part, full) => sendProgress?.call(
              full == 0 ? 1 : part / full,
            ),
            onReceiveProgress: (part, full) => receiveProgress?.call(
              full == 0 ? 1 : part / full,
            ),
          );
      }

      if (debugMode) {
        _logger(url, response, body: request.body);
      }

      return response;
    } on DioException catch (dioError, mainStackTrace) {
      final stackTrace = StackTrace.fromString(
        'Main stackTrace:\n$mainStackTrace\n'
        'Dio stackTrace:\n${dioError.stackTrace}',
      );

      if (debugMode) {
        _logger(url, dioError.response, body: request.body);
      }

      switch (dioError.type) {
        case DioExceptionType.cancel:
          Error.throwWithStackTrace(RequestCanceled(), stackTrace);
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          Error.throwWithStackTrace(
            RequestTimeoutException(
              httpStatusCode: dioError.response?.statusCode ?? 0,
              requestPath: dioError.requestOptions.path,
              requestData: dioError.requestOptions.data,
              requestMethod: dioError.requestOptions.method,
            ),
            stackTrace,
          );
        default:
        // продолжаем обработку ошибки
      }

      Map<String, Object?>? responseBody;
      String? responseValues;
      if (dioError.response?.data != null) {
        if ('${dioError.response?.data}'.isNotEmpty) {
          final jsonDecoded = jsonDecode(dioError.response!.data as String);
          if (jsonDecoded is Map) {
            responseBody = jsonDecoded as Map<String, Object?>;
          } else if (jsonDecoded is Iterable) {
            responseBody = Map<String, String>.fromEntries(jsonDecoded
                //ignore: avoid_types_on_closure_parameters
                .map((Object? e) => MapEntry<String, String>('', '$e')));
          }

          if (responseBody != null) {
            String errorText = '';
            responseBody.forEach((key, value) {
              if (value is String) {
                errorText = errorText + value + '\n';
              } else if (value is Map<String, Object?>) {
                value.forEach((key, value) {
                  if (value is String) {
                    errorText = errorText + value + '\n';
                  }
                });
              } else if (value is List<Object?>) {
                value.forEach((item) {
                  errorText = errorText + '$item\n';
                });
              }
            });
            if (errorText.isNotEmpty) {
              responseValues = errorText.trim();
            }
          }
        }
      }
      Error.throwWithStackTrace(
        RequestException(
          httpStatusCode: dioError.response?.statusCode ?? 0,
          response: responseBody,
          responseValues: responseValues,
          requestPath: dioError.requestOptions.path,
          requestData: dioError.requestOptions.data,
          requestMethod: dioError.requestOptions.method,
          headers: dioError.requestOptions.headers,
        ),
        stackTrace,
      );
    } on Object {
      rethrow;
    }
  }
}
