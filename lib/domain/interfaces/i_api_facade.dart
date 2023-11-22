import '../../../data/api/mapper/mapper.dart';

import '../models/tokens_pair.dart';
import 'i_authenticate_repository.dart';

abstract class IApiFacade {
  ApiDataMapper? mapper;

  // Http-client initialization
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  void setAuthenticateController(IAuthenticateController controller);

  // ---------------------------------------------------------------------------
  void removeAuthenticateController();

  // ---------------------------------------------------------------------------
  Future<void> clearTokens();

  // ---------------------------------------------------------------------------
  Future<void> setTokens(String access, String refresh);

  // ---------------------------------------------------------------------------
  Future<void> setLocale(String locale);

  // API methods
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------

  // user authenticate
  Future<TokensPair> auth({required String login, required String password});

  // update tokens pair by refresh token
  Future<TokensPair> refreshTokens({required String refreshToken});
}
