import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/jwt_tokens.dart';

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

  /// accepts the event that you can log in
  /// and receives tokens
  Future<void> onAuthenticated(String accessToken, String refreshToken);

  /// accepts the event that authentication failed
  Future<void> onAuthenticateCanceled();

  /// accepts the event that the tokens have been successfully updated
  /// receives fresh tokens
  Future<void> onAccessTokensUpdated(String accessToken, String refreshToken);

  /// adding a listener to changes in the controller
  void addListener(VoidCallback listener);

  /// deleting the listener for changes in the controller
  void removeListener(VoidCallback listener);
}

// -----------------------------------------------------------------------------
/// authentication repository
abstract class IAuthenticateRepository {
  IAuthenticateController get controller;

  /// closing the repository, closing streams
  Future<void> close();

  /// subscribing to changes in the repository
  AuthenticateSubscription subscribe(Function(AuthenticateStatus) listener);

  /// reading cached tokens
  Future<JwtTokens?> getCachedTokens();

  /// logging out with token clearing
  Future<void> logout();
}
