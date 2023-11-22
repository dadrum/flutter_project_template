import 'dart:async';

import 'package:flutter/foundation.dart';

import '../interfaces/i_authenticate_repository.dart';
import '../interfaces/i_local_cache.dart';
import '../models/tokens_pair.dart';

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// контроллер, который принимает события для репозитория аутентификации
class _AuthenticateController extends ChangeNotifier
    implements IAuthenticateController {
  _AuthenticateController({
    required ILocalCache localCache,
  })  : _localCache = localCache,
        _status = _initialAuthenticateStatus;

  // ---------------------------------------------------------------------------
  // зависимости
  late final ILocalCache _localCache;

  // ---------------------------------------------------------------------------
  // значения по-умолчанию
  static const AuthenticateStatus _initialAuthenticateStatus =
      AuthenticateStatus.notAuthorized;

  // ---------------------------------------------------------------------------
  // состояния
  late AuthenticateStatus _status;

  // ---------------------------------------------------------------------------
  @override
  AuthenticateStatus get status => _status;

  // ---------------------------------------------------------------------------
  // принимает событие о том, что токены успешно обновлены
  // получает свежие токены
  @override
  Future<void> onAccessTokensUpdated(
      String accessToken, String refreshToken) async {
    await _localCache.setAuthTokens(
        tokens:
            TokensPair(accessToken: accessToken, refreshToken: refreshToken));

    // меняем состояние
    _status = AuthenticateStatus.authorized;

    // оповещаем об изменении
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // принимает событие о том, что аутентификация не удалась
  @override
  Future<void> onAuthenticateFailed() async {
    // очищаем токены
    await _localCache.deleteAuthTokens();

    // меняем состояние аутентификации
    _status = AuthenticateStatus.notAuthorized;

    // оповещаем об изменении
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // принимает событие о том, что удалоь авторизоваться
  // и получает токены
  @override
  Future<void> onAuthenticated(String accessToken, String refreshToken) async {
    await _localCache.setAuthTokens(
        tokens:
            TokensPair(accessToken: accessToken, refreshToken: refreshToken));

    // меняем состояние
    _status = AuthenticateStatus.authorized;

    // оповещаем об изменении
    notifyListeners();
  }
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// репозиторий аутентификации
class AuthenticateRepository implements IAuthenticateRepository {
  // ---------------------------------------------------------------------------
  AuthenticateRepository({
    required ILocalCache localCache,
    IAuthenticateController? controller,
  }) : _localCache = localCache {
    // создаём контроллер репозитория
    _controller = controller ?? _AuthenticateController(localCache: localCache);

    // подписываемся на изменения в контроллере
    _controller.addListener(_onControllerChanged);

    _authenticateStreamController =
        StreamController<AuthenticateStatus>.broadcast();
  }

  // ---------------------------------------------------------------------------
  // зависимости
  late final ILocalCache _localCache;

  // ---------------------------------------------------------------------------
  // подписки, стримы
  late final StreamController<AuthenticateStatus> _authenticateStreamController;

  // ---------------------------------------------------------------------------
  // переменные состояния
  late IAuthenticateController _controller;

  @override
  IAuthenticateController get controller => _controller;

  // ---------------------------------------------------------------------------
  // в контроллере аутентификации произошли изменения
  void _onControllerChanged() {
    if (!_authenticateStreamController.isClosed) {
      _authenticateStreamController.add(_controller.status);
    }
  }

  // ---------------------------------------------------------------------------
  // закрытие репозитория, закрытие стримов
  @override
  Future<void> close() async {
    // отписываемся от изменений в контроллере
    _controller.removeListener(_onControllerChanged);

    await _authenticateStreamController.close();
  }

  // ---------------------------------------------------------------------------
  // подписка на изменения в репозитории
  @override
  AuthenticateSubscription subscribe(Function(AuthenticateStatus) listener) {
    return _authenticateStreamController.stream.listen(listener);
  }

  // ---------------------------------------------------------------------------
  // чтение кешированных токенов
  @override
  Future<TokensPair?> getCachedTokens() => _localCache.getAuthTokens();

  // ---------------------------------------------------------------------------
  // выход из системы с очисткой токенов
  @override
  Future<void> logout() async {
    await controller.onAuthenticateFailed();
  }
// ---------------------------------------------------------------------------
}
