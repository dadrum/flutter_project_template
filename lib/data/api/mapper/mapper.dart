import '../../../domain/models/jwt_tokens.dart';
import '../model/responses/tokens_pair_dto.dart';

// MAP RESPONSES
class ApiDataMapper {
  // ---------------------------------------------------------------------------
  JwtTokens mapTokensPair(TokensPairDto dto) => JwtTokens(
        refresh: dto.refreshToken,
        access: dto.token,
      );
}
