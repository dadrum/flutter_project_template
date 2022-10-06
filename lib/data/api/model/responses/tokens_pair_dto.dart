import 'package:json_annotation/json_annotation.dart';

part 'generated/tokens_pair_dto.g.dart';

@JsonSerializable()
class TokensPairDto {
  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  TokensPairDto({
    required this.token,
    required this.refreshToken,
  });

  static TokensPairDto fromJson(Object json) =>
      _$TokensPairDtoFromJson(json as Map<String, dynamic>);
}
