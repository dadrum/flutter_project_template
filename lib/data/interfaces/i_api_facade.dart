import '../../../data/api/mapper/mapper.dart';

import '../../domain/entities/jwt_tokens.dart';
import '../../domain/repositories/i_authenticate_repository.dart';

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
  Future<JwtTokens> auth({required String login, required String password});

  // update tokens pair by refresh token
  Future<JwtTokens> refreshTokens({required String refreshToken});
}
