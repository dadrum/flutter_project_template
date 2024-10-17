import 'dart:io';

import 'package:dep_gen/dep_gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/api/http_client/request_exception.dart';
import '../../../../domain/interfaces/i_api_facade.dart';
import '../../../../domain/interfaces/i_authenticate_repository.dart';
import '../../../../domain/interfaces/i_local_cache.dart';
import '../../../../domain/models/jwt_tokens.dart';

part 'events.dart';

part 'splash_bloc.freezed.dart';

part 'states.dart';

@DepGen()
class SplashBloc extends Bloc<SplashEvents, SplashStates> {
  // ---------------------------------------------------------------------------
  SplashBloc({
    @DepArg() required this.authenticateRepository,
    @DepArg() required this.localCache,
    @DepArg() required this.api,
  }) : super(const SplashStates.notInitialized()) {
    on<_EventInitialize>(onEventInitialize);
    add(const SplashEvents.initialize());
  }
  // ---------------------------------------------------------------------------
  final IAuthenticateRepository authenticateRepository;
  final IApiFacade api;
  final ILocalCache localCache;

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
      final isFirstStart = await localCache.isFirstAppStart();
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
      return await localCache.getAuthTokens();
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
          await api.refreshTokens(refreshToken: tokensPair.refresh);

      // cache new tokens
      await authenticateRepository.controller.onAccessTokensUpdated(
        newTokens.access,
        newTokens.refresh,
      );

      // update http-client
      await api.setTokens(newTokens.access, newTokens.refresh);

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
          await localCache.deleteAuthTokens();
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
