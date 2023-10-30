import 'dart:io';

import 'package:dep_gen/dep_gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/api/http_client/request_exception.dart';
import '../../../../domain/interfaces/i_api_facade.dart';
import '../../../../domain/interfaces/i_authenticate_controller.dart';
import '../../../../domain/interfaces/i_local_cache.dart';
import '../../../../domain/models/tokens_pair.dart';

part 'events.dart';

part 'splash_bloc.freezed.dart';

part 'states.dart';

@DepGen()
class SplashBloc extends Bloc<SplashEvents, SplashStates> {
  // ---------------------------------------------------------------------------
  SplashBloc({
    @DepArg() required this.authenticateController,
    @DepArg() required this.localCache,
    @DepArg() required this.api,
  }) : super(const SplashStates.notInitialized()) {
    on<_EventInitialize>(onEventInitialize);
    add(const SplashEvents.initialize());
  }
  // ---------------------------------------------------------------------------
  final IAuthenticateController authenticateController;
  final IApiFacade api;
  final ILocalCache localCache;

  // ---------------------------------------------------------------------------
  Future<void> onEventInitialize(
      _EventInitialize event, Emitter<SplashStates> emitter) async {
    // determinate - is first app start ?
    final bool isFirstStart = await checkIsFirstAppStart(emitter);

    // get saved tokens
    final TokensPair? cachedTokens = await getCachedTokens(emitter);

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
      bool isFirstStart = await localCache.isFirstAppStart();
      if (!isFirstStart) {
        final selectedLocale = await localCache.getSavedLocale();
        if (selectedLocale == null) {
          // if there no any cached locale settings - set the first start flag
          isFirstStart = true;
        } else {
          if (!emitter.isDone) {
            emitter(SplashStates.initializeLocale(locale: selectedLocale));
          }
          // set api requests locale
          if (selectedLocale.isNotEmpty) {
            api.setLocale(selectedLocale);
          }
        }
      }
      return isFirstStart;
    } on Object catch (e, s) {
      Error.throwWithStackTrace(
          UnimplementedError('Check first app start exception with $e'), s);
    }
  }

  // ---------------------------------------------------------------------------
  // get saved tokens
  Future<TokensPair?> getCachedTokens(Emitter<SplashStates> emitter) async {
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
    TokensPair tokensPair,
    bool isFirstStart,
  ) async {
    try {
      final TokensPair newTokens =
          await api.refreshTokens(refreshToken: tokensPair.refreshToken);

      // cache new tokens
      await authenticateController.onAccessTokensUpdated(
        newTokens.accessToken,
        newTokens.refreshToken,
      );

      // update http-client
      await api.setTokens(newTokens.accessToken, newTokens.refreshToken);

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
