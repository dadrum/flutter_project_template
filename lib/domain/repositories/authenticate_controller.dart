import 'dart:async';

import '../interfaces/i_authenticate_controller.dart';
import '../interfaces/i_local_cache.dart';
import '../models/tokens_pair.dart';

class AuthenticateController implements IAuthenticateController {
  AuthenticateController({required ILocalCache localCache})
      : _localCache = localCache {
    _authenticateStatusController =
        StreamController<AuthenticateStatus>.broadcast();
  }

  // ---------------------------------------------------------------------------
  // default known authenticate status
  static const AuthenticateStatus _initialAuthenticateStatus =
      AuthenticateStatus.notAuthorized;

  late final StreamController<AuthenticateStatus> _authenticateStatusController;

  late final ILocalCache _localCache;

  // last known authenticate status hidden var
  AuthenticateStatus? _lastKnownStatus;

  // last known authenticate status getter
  @override
  AuthenticateStatus get lastKnownStatus =>
      _lastKnownStatus ?? _initialAuthenticateStatus;

  // ---------------------------------------------------------------------------
  // on api tokens changed
  @override
  Future<void> onAccessTokensUpdated(
      String accessToken, String refreshToken) async {
    // cache tokens
    await _localCache.setAuthTokens(
        tokens:
            TokensPair(accessToken: accessToken, refreshToken: refreshToken));

    // memo last known status
    _lastKnownStatus = AuthenticateStatus.authorized;

    // notify about authenticate changes
    if (!_authenticateStatusController.isClosed) {
      _authenticateStatusController.add(AuthenticateStatus.authorized);
    }
  }

  // ---------------------------------------------------------------------------
  // on authenticate failed
  @override
  Future<void> onAuthenticateFailed() async {
    // clear tokens
    await _localCache.deleteAuthTokens();

    // memo last known status
    _lastKnownStatus = AuthenticateStatus.notAuthorized;

    if (!_authenticateStatusController.isClosed) {
      _authenticateStatusController.add(AuthenticateStatus.notAuthorized);
    }
  }

  // ---------------------------------------------------------------------------
  // on user authenticated
  @override
  Future<void> onAuthenticated(String accessToken, String refreshToken) async {
    // cache tokens
    await _localCache.setAuthTokens(
        tokens:
            TokensPair(accessToken: accessToken, refreshToken: refreshToken));

    // memo last known status
    _lastKnownStatus = AuthenticateStatus.authorized;

    // notify about authenticate changes
    if (!_authenticateStatusController.isClosed) {
      _authenticateStatusController.add(AuthenticateStatus.authorized);
    }
  }

  // ---------------------------------------------------------------------------
  // close controller, close stream
  @override
  Future<void> close() async {
    await _authenticateStatusController.close();
  }

  // ---------------------------------------------------------------------------
  // subscribe to authenticate state changes
  @override
  AuthenticateSubscription subscribe(Function(AuthenticateStatus) listener) {
    return _authenticateStatusController.stream.listen(listener);
  }

  // ---------------------------------------------------------------------------
  // read tokens, saved to local cache
  @override
  Future<TokensPair?> getCachedTokens() async {
    return await _localCache.getAuthTokens();
  }

// ---------------------------------------------------------------------------
}
