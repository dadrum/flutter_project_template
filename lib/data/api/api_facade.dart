import 'dart:convert';

import 'package:dio/dio.dart';

import '../../domain/interfaces/i_api_facade.dart';
import '../../domain/interfaces/i_authenticate_repository.dart';
import '../../domain/models/jwt_tokens.dart';
import 'http_client/http_client.dart';
import 'mapper/mapper.dart';
import 'model/requests/request_auth.dart';
import 'model/requests/request_refresh_tokens.dart';
import 'model/responses/tokens_pair_dto.dart';

typedef _Response = Response<Object?>?;
typedef _JsonObject = Map<String, Object?>;

class ApiFacade implements IApiFacade {
  ApiFacade({DioClient? customClient, ApiDataMapper? customMapper}) {
    httpClient = customClient ?? DioClient();
    mapper = customMapper ?? ApiDataMapper();
  }

  // ---------------------------------------------------------------------------
  late DioClient httpClient;

  @override
  ApiDataMapper? mapper;

  // ---------------------------------------------------------------------------
  @override
  void setAuthenticateController(IAuthenticateController controller) {
    httpClient.setAuthenticateController(controller);
  }

  // ---------------------------------------------------------------------------
  @override
  void removeAuthenticateController() {
    httpClient.removeAuthenticateController();
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> setTokens(String access, String refresh) async {
    httpClient.setTokens(access, refresh);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> setLocale(String locale) async {
    await httpClient.setLocaleSettings(locale);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> clearTokens() async {
    httpClient.clearTokens();
  }

  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // user authenticate
  @override
  Future<JwtTokens> auth({
    required String login,
    required String password,
  }) async {
    final _Response response = await httpClient.request(
      RequestAuth(login: login, password: password),
    );
    return mapper!.mapTokensPair(
      TokensPairDto.fromJson(
        jsonDecode('${response?.data}') as _JsonObject,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // update tokens pair by refresh token
  @override
  Future<JwtTokens> refreshTokens({required String refreshToken}) async {
    final _Response response = await httpClient.request(
      RequestRefreshTokens(refreshToken: refreshToken),
    );
    return mapper!.mapTokensPair(
      TokensPairDto.fromJson(
        jsonDecode('${response?.data}') as _JsonObject,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
