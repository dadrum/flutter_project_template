import 'dart:async';

import 'package:flutter/foundation.dart';

import '../interfaces/i_authenticate_repository.dart';
import '../interfaces/i_local_cache.dart';
import '../models/jwt_tokens.dart';

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// the controller that receives events for the authentication repository
class AuthenticateController extends ChangeNotifier
    implements IAuthenticateController {
  AuthenticateController({
    required ILocalCache localCache,
  })  : _localCache = localCache,
        _status = _initialAuthenticateStatus;

  // ---------------------------------------------------------------------------
  // dependencies
  late final ILocalCache _localCache;

  // ---------------------------------------------------------------------------
  // default values
  static const AuthenticateStatus _initialAuthenticateStatus =
      AuthenticateStatus.notAuthorized;

  // ---------------------------------------------------------------------------
  // states
  late AuthenticateStatus _status;

  // ---------------------------------------------------------------------------
  @override
  AuthenticateStatus get status => _status;

  // ---------------------------------------------------------------------------
  // accepts the event that the tokens have been successfully updated
  // receives fresh tokens
  @override
  Future<void> onAuthenticated(
    String accessToken,
    String refreshToken,
  ) async {
    await _localCache.setAuthTokens(
      tokens: JwtTokens(
        access: accessToken,
        refresh: refreshToken,
      ),
    );

    // changing the state
    _status = AuthenticateStatus.authorized;

    // we inform you about the change
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // accepts the event that authentication failed
  @override
  Future<void> onAuthenticateCanceled() async {
    // clearing tokens
    await _localCache.deleteAuthTokens();

    // changing the authentication status
    _status = AuthenticateStatus.notAuthorized;

    // we inform you about the change
    notifyListeners();
  }
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// authentication repository
class AuthenticateRepository implements IAuthenticateRepository {
  // ---------------------------------------------------------------------------
  AuthenticateRepository({
    required ILocalCache localCache,
    IAuthenticateController? controller,
  }) : _localCache = localCache {
    // creating a repository controller
    _controller = controller ?? AuthenticateController(localCache: localCache);

    // subscribing to changes in the controller
    _controller.addListener(_onControllerChanged);

    _authenticateStreamController =
        StreamController<AuthenticateStatus>.broadcast();
  }

  // ---------------------------------------------------------------------------
  // dependencies
  late final ILocalCache _localCache;

  // ---------------------------------------------------------------------------
  // subscriptions, streams
  late final StreamController<AuthenticateStatus> _authenticateStreamController;

  // ---------------------------------------------------------------------------
  // state variables
  late IAuthenticateController _controller;

  @override
  IAuthenticateController get controller => _controller;

  // ---------------------------------------------------------------------------
  // there have been changes in the authentication controller
  void _onControllerChanged() {
    if (!_authenticateStreamController.isClosed) {
      _authenticateStreamController.add(_controller.status);
    }
  }

  // ---------------------------------------------------------------------------
  // closing the repository, closing streams
  @override
  Future<void> close() async {
    // unsubscribe from changes in the controller
    _controller.removeListener(_onControllerChanged);

    await _authenticateStreamController.close();
  }

  // ---------------------------------------------------------------------------
  // subscribing to changes in the repository
  @override
  AuthenticateSubscription subscribe(Function(AuthenticateStatus) listener) {
    return _authenticateStreamController.stream.listen(listener);
  }

  // ---------------------------------------------------------------------------
  // reading cached tokens
  @override
  Future<JwtTokens?> getCachedTokens() => _localCache.getAuthTokens();

  // ---------------------------------------------------------------------------
  // logging out with token clearing
  @override
  Future<void> logout() async {
    await controller.onAuthenticateCanceled();
  }
// ---------------------------------------------------------------------------
}
