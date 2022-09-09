part of 'splash_bloc.dart';

@freezed
class SplashStates with _$SplashStates {
  // splash not initialized yet
  const factory SplashStates.notInitialized() = _StateNotInitialized;

  // initialization completed
  const factory SplashStates.initializationCompleted({
    required bool isFirstStart,
  }) = _StateInitializationCompleted;

  // have to initialize locale settings
  const factory SplashStates.initializeLocale({
    required String locale,
  }) = _StateInitializeLocale;
}
