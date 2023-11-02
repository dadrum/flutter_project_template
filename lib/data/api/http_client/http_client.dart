import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../domain/interfaces/i_authenticate_controller.dart';
import 'i_api_request.dart';
import 'request_exception.dart';

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

  static const String englishLocaleSettings = 'en-US,en;q=0.9,ru-RU';
  static const String russianLocaleSettings = 'ru-RU,ru;q=0.9,en-US';

  // listener for authenticate events
  IAuthenticateController? authenticateController;

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

    _dio?.interceptors.add(authErrorInterceptor());
  }

  // ---------------------------------------------------------------------------
  // инициализация HTTP-клиента с указанными настройками заголовка
  void _updateNewDioWithHeader(Map<String, Object?> newHeaders) {
    if (_dio == null) return;

    _dio!.interceptors.removeWhere((element) => true);

    _dioOptions = _dio!.options.copyWith(headers: newHeaders);

    _dio = Dio(_dioOptions);

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

              _dioOptions.headers['authorization'] =
                  _getTokenWithBearer(receivedAccessToken);

              _refreshToken = receivedRefreshToken;
              await authenticateController?.onAccessTokensUpdated(
                  receivedAccessToken, receivedRefreshToken);
            }

            // если токен был получен - пробуем повторить запрос
            // на котором поучили 401
            if (receivedAccessToken?.isNotEmpty ?? false) {
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
                  authenticateController?.onAuthenticateFailed();
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
  Future<Response<Object?>?> request(IApiRequest request) async {
    if (_dio == null) throw UnimplementedError('Dio is not initialized');

    final String url = '$_baseUrl${request.endPoint}';
    try {
      Response<String> response;

      switch (request.methodType) {
        case AvailableApiMethods.get:
          response = await _dio!.get<String>(url);
        case AvailableApiMethods.post:
          response = await _dio!.post<String>(url, data: request.body);
        case AvailableApiMethods.put:
          response = await _dio!.put<String>(url, data: request.body);
        case AvailableApiMethods.delete:
          response = await _dio!.delete<String>(url, data: request.body);
        case AvailableApiMethods.patch:
          response = await _dio!.patch<String>(url, data: request.body);
      }

      if (debugMode) {
        _logger(url, response, body: request.body);
      }

      return response;
    } on DioException catch (dioError, stackTrace) {
      if (debugMode) {
        _logger(url, dioError.response, body: request.body);
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
          stackTrace);
    } on Object {
      rethrow;
    }
  }
}
