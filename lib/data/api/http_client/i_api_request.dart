import 'http_client.dart';

// описание запроса к API
abstract class IApiRequest {
  IApiRequest({
    required AvailableApiMethods methodType,
    required String url,
  })  : _initialUrl = url,
        _methodType = methodType;

  // приватные данные
  final AvailableApiMethods _methodType;
  final String _initialUrl;

  // геттер, чтобы получить ссылку запроса
  String get initialUrl => _initialUrl;

  // геттер для оверрайта и преобразования ссылки к правильному эндпоинту
  String get endPoint => _initialUrl;

  // геттер для получения типа запроса
  AvailableApiMethods get methodType => _methodType;

  // геттер для оверрайта тела запроса
  Map<String, Object?>? get body => null;
}
