import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../domain/interfaces/i_authenticate_controller.dart';
import 'i_api_request.dart';
import 'request_exception.dart';

enum AvailableApiMethods { get, post, put, delete, patch }

class DioClient {
  Dio? _dio;
  late BaseOptions _dioOptions;

  // ---------------------------------------------------------------------------
  static const bool debugMode = true;

  static const String englishLocaleSettings = 'en-US,en;q=0.9,ru-RU';
  static const String russianLocaleSettings = 'ru-RU,ru;q=0.9,en-US';
  static const String _hostHttp = 'https';
  static const String _hostUrl = 'domain.ru/api_path';
  static const String _baseUrl = '$_hostHttp://$_hostUrl';

  // listener for authenticate events
  IAuthenticateController? authenticateController;

  String? _refreshToken;

  String get apiUrl => _baseUrl;

  // использование данных о языке в заголовке запроса
  late bool _useLocaleSettings;
  String? _localeSettings;

  // ---------------------------------------------------------------------------
  DioClient({bool useLocaleSettings = false}) {
    // настройка использования разных языков
    if (useLocaleSettings) {
      _localeSettings = englishLocaleSettings;
    }
    _useLocaleSettings = useLocaleSettings;

    _initNewDioClient();
  }

  // ---------------------------------------------------------------------------
  // инициализация HTTP-клиента с заданными настройками
  // и заголовком
  void _initNewDioClient({String accessToken = '', String? refreshToken}) {
    _dio?.interceptors.removeWhere((element) => true);

    _refreshToken = refreshToken;

    // собираем данные для заголовка
    final Map<String, Object?> _headers = {};
    // установка токена
    if (accessToken.isNotEmpty) {
      _headers[HttpHeaders.authorizationHeader] =
          _getTokenWithBearer(accessToken);
    }
    // установка выбранной локали
    if (_useLocaleSettings && (_localeSettings?.isNotEmpty ?? false)) {
      _headers[HttpHeaders.acceptLanguageHeader] = _localeSettings;
    }

    _dioOptions = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 25000,
      receiveTimeout: 25000,
      headers: _headers,
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

    Map<String, Object?> newHeader = _dioOptions.headers;
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
  InterceptorsWrapper authErrorInterceptor() => InterceptorsWrapper(
        onResponse: (response, handler) {
          // _continuous401ErrorsCounter = 0;
          return handler.next(response);
        },
        onError: (dioError, handler) async {
          // если поступила ошибка аутентификации
          if (dioError.response?.statusCode == HttpStatus.unauthorized &&
              (_refreshToken?.isNotEmpty ?? false)) {
            // блокируем клиент
            //todo в 5 версии когда удалять dio.lock изменить поведение интерсептора
            //ignore: deprecated_member_use
            _dio!.lock();
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

            // разблокируем клиент
            //todo в 5 версии когда удалят dio.unlock изменить поведение интерсептора
            //ignore: deprecated_member_use
            _dio!.unlock();

            // если токен был получен - пробуем повторить запрос
            // на котором поучили 401
            if (receivedAccessToken?.isNotEmpty ?? false) {
              try {
                // only for VERIFY request - change token in DATA
                Map<String, Object?>? originalRequestData =
                    dioError.requestOptions.data as Map<String, Object?>?;
                // if (originalRequestData != null &&
                //     dioError.requestOptions.path.contains('auth/jwt/verify')) {
                //   originalRequestData['token'] = receivedAccessToken;
                // }

                final Response<String> response =
                    await _dio!.request<String>(dioError.requestOptions.path,
                        data: originalRequestData,
                        options: Options(
                          method: dioError.requestOptions.method,
                          headers: _dioOptions.headers,
                        ));
                handler.resolve(response);
                return;
              } on DioError catch (e) {
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

    final Map<String, Object> _body = <String, Object>{
      'refresh': _refreshToken!
    };
    const String _url = '${_baseUrl}auth/token/refresh/';

    try {
      final Response<String> response =
          await Dio(_dioOptions).post<String>(_url, data: _body);

      if (debugMode) {
        _logger(_url, response, body: _body);
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
  void _logger(String url, Response? response, {Object? body}) {
    dev.log('V___________________________________');
    dev.log(
        '> METHOD: ${response?.requestOptions.method.toString() ?? 'Unknown method'}');
    dev.log(
        '> HEADERS: ${response?.requestOptions.headers.toString() ?? 'Unknown headers'}');
    dev.log('> PATH: ${response?.requestOptions.path.toString() ?? url}');
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
          break;
        case AvailableApiMethods.post:
          response = await _dio!.post<String>(url, data: request.body);
          break;
        case AvailableApiMethods.put:
          response = await _dio!.put<String>(url, data: request.body);
          break;
        case AvailableApiMethods.delete:
          response = await _dio!.delete<String>(url, data: request.body);
          break;
        case AvailableApiMethods.patch:
          response = await _dio!.patch<String>(url, data: request.body);
          break;
      }

      if (debugMode) {
        _logger(url, response, body: request.body);
      }

      return response;
    } on DioError catch (dioError, stackTrace) {
      if (debugMode) {
        _logger(url, dioError.response, body: request.body);
      }

      Map<String, Object?>? responseBody;
      String? responseValues;
      if (dioError.response?.data != null) {
        if ('${dioError.response?.data}'.isNotEmpty) {
          Object? jsonDecoded = jsonDecode(dioError.response!.data as String);
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
          ),
          stackTrace);
    } on Object {
      rethrow;
    }
  }
}
