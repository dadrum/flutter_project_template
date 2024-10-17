part of 'app_logger_bloc.dart';

@freezed
class AppLoggerState with _$AppLoggerState {
  /// основное состояние экрана
  const factory AppLoggerState.screenState({
    required Iterable<String> logsStack,
  }) = _ScreenState;
}
