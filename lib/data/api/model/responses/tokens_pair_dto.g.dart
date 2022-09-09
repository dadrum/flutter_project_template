// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_pair_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensPairDto _$TokensPairDtoFromJson(Map<String, dynamic> json) =>
    TokensPairDto(
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$TokensPairDtoToJson(TokensPairDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh_token': instance.refreshToken,
    };
