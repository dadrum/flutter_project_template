import 'dart:io';

import 'package:dep_gen/dep_gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/api/http_client/request_exception.dart';
import '../../../../domain/entities/jwt_tokens.dart';
import '../../../../domain/use_cases/authenticate/delete_auth_tokens_use_case.dart';
import '../../../../domain/use_cases/authenticate/get_cached_tokens_use_case.dart';
import '../../../../domain/use_cases/authenticate/refresh_tokens_use_case.dart';
import '../../../../domain/use_cases/authenticate/set_tokens_use_case.dart';
import '../../../../domain/use_cases/local_cache/is_first_app_start_use_case.dart';

part 'events.dart';
part 'splash_bloc.freezed.dart';
part 'states.dart';

@DepGen()
class SplashBloc extends Bloc<SplashEvents, SplashStates> {
  // ---------------------------------------------------------------------------
  SplashBloc({
    @DepArg() required GetCachedTokensUseCase getCachedTokensUseCase,
    @DepArg() required IsFirstAppStartUseCase isFirstAppStartUseCase,
    @DepArg() required RefreshTokensUseCase refreshTokensUseCase,
    @DepArg() required DeleteAuthTokensUseCase deleteAuthTokensUseCase,
    @DepArg() required SetTokensUseCase setTokensUseCase,
  })  : _getCachedTokensUseCase = getCachedTokensUseCase,
        _isFirstAppStartUseCase = isFirstAppStartUseCase,
        _refreshTokensUseCase = refreshTokensUseCase,
        _deleteAuthTokensUseCase = deleteAuthTokensUseCase,
        _setTokensUseCase = setTokensUseCase,
        super(const SplashStates.notInitialized()) {
    on<_EventInitialize>(onEventInitialize);
    add(const SplashEvents.initialize());
  }

  // ---------------------------------------------------------------------------
  /// use cases
  final IsFirstAppStartUseCase _isFirstAppStartUseCase;

  final GetCachedTokensUseCase _getCachedTokensUseCase;
  final SetTokensUseCase _setTokensUseCase;
  final DeleteAuthTokensUseCase _deleteAuthTokensUseCase;
  final RefreshTokensUseCase _refreshTokensUseCase;

  // final IAuthenticateRepository authenticateRepository;
  // final IApiFacade api;
  // final ILocalCache localCache;

  // ---------------------------------------------------------------------------
  Future<void> onEventInitialize(
      _EventInitialize event, Emitter<SplashStates> emitter) async {
    // determinate - is first app start ?
    final bool isFirstStart = await checkIsFirstAppStart(emitter);

    // get saved tokens
    final JwtTokens? cachedTokens = await getCachedTokens(emitter);

    if (cachedTokens == null) {
      emitter(SplashStates.initializationCompleted(isFirstStart: isFirstStart));
      return;
    }

    // update token and dependencies
    await updateTokens(emitter, cachedTokens, isFirstStart);
  }

  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // determinate - is first app start ?
  Future<bool> checkIsFirstAppStart(Emitter<SplashStates> emitter) async {
    try {
      final isFirstStart = await _isFirstAppStartUseCase();
      return isFirstStart;
    } on Object catch (e, s) {
      Error.throwWithStackTrace(
          UnimplementedError('Check first app start exception with $e'), s);
    }
  }

  // ---------------------------------------------------------------------------
  // get saved tokens
  Future<JwtTokens?> getCachedTokens(Emitter<SplashStates> emitter) async {
    try {
      return await _getCachedTokensUseCase();
    } on Object catch (e, s) {
      Error.throwWithStackTrace(
          UnimplementedError('Get local tokens in splash. $e'), s);
    }
  }

  // ---------------------------------------------------------------------------
  // update token and dependencies
  Future<void> updateTokens(
    Emitter<SplashStates> emitter,
    JwtTokens tokensPair,
    bool isFirstStart,
  ) async {
    try {
      final JwtTokens newTokens =
          await _refreshTokensUseCase(refreshToken: tokensPair.refresh);

      // update http-client
      await _setTokensUseCase(
        accessToken: newTokens.access,
        refreshToken: newTokens.refresh,
      );

      // set state with initialization complete
      if (!emitter.isDone) {
        emitter(
            SplashStates.initializationCompleted(isFirstStart: isFirstStart));
      }
    } on RequestException catch (e, s) {
      switch (e.httpStatusCode) {
        case HttpStatus.unauthorized:
        case HttpStatus.forbidden:
          // on check tokens fail
          await _deleteAuthTokensUseCase();
          if (!emitter.isDone) {
            emitter(SplashStates.initializationCompleted(
                isFirstStart: isFirstStart));
          }
        default:
          // on bad on unsuccessful request
          Error.throwWithStackTrace(
            UnimplementedError('Update tokens error on initialization. $e'),
            s,
          );
      }
    } on Object {
      rethrow;
    }
  }
}
