import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/tokens_pair.dart';

// допустимые состояния аутентификации пользователя
enum AuthenticateStatus {
  authorized,
  notAuthorized,
}

typedef AuthenticateSubscription = StreamSubscription<AuthenticateStatus>;

// -----------------------------------------------------------------------------
/// контроллер, который принимает события для репозитория аутентификации
abstract class IAuthenticateController {
  /// какой статус авторизации был последним
  AuthenticateStatus get status;

  /// принимает событие о том, что удалоь авторизоваться
  /// и получает токены
  Future<void> onAuthenticated(String accessToken, String refreshToken);

  /// принимает событие о том, что аутентификация не удалась
  Future<void> onAuthenticateFailed();

  /// принимает событие о том, что токены успешно обновлены
  /// получает свежие токены
  Future<void> onAccessTokensUpdated(String accessToken, String refreshToken);

  /// добавляем слушателя на изменения в контроллере
  void addListener(VoidCallback listener);

  /// удаляем слушателя изменений в контроллере
  void removeListener(VoidCallback listener);
}

// -----------------------------------------------------------------------------
/// репозиторий аутентификации
abstract class IAuthenticateRepository {
  IAuthenticateController get controller;

  /// закрытие репозитория, закрытие стримов
  Future<void> close();

  /// подписка на изменения в репозитории
  AuthenticateSubscription subscribe(Function(AuthenticateStatus) listener);

  /// чтение кешированных токенов
  Future<TokensPair?> getCachedTokens();

  /// выход из системы с очисткой токенов
  Future<void> logout();
}
