import 'dart:async';

import '../models/tokens_pair.dart';

enum AuthenticateStatus {
  authorized,
  notAuthorized,
}

typedef AuthenticateSubscription = StreamSubscription<AuthenticateStatus>;

abstract class IAuthenticateController {

  AuthenticateStatus get lastKnownStatus;

  // on user authenticated
  Future<void> onAuthenticated(String accessToken, String refreshToken);

  // on authenticate failed
  Future<void> onAuthenticateFailed();

  // on api tokens changed
  Future<void> onAccessTokensUpdated(String accessToken, String refreshToken);

  // close controller, close stream
  Future<void> close();

  // subscribe to authenticate state changes
  AuthenticateSubscription subscribe(Function(AuthenticateStatus) listener);

  // read tokens, saved to local cache
  Future<TokensPair?> getCachedTokens();

}
