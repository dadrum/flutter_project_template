import '../../../domain/models/tokens_pair.dart';
import '../model/responses/tokens_pair_dto.dart';

// MAP RESPONSES
class ApiDataMapper {
  // ---------------------------------------------------------------------------
  TokensPair mapTokensPair(TokensPairDto dto) {
    return TokensPair(
      refreshToken: dto.refreshToken,
      accessToken: dto.token,
    );
  }
}
