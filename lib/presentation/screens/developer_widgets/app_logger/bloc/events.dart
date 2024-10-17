part of 'app_logger_bloc.dart';

@freezed
class AppLoggerEvent with _$AppLoggerEvent {
  /// запрошено обновление логов
  const factory AppLoggerEvent.onUpdateRequested() = _EventOnUpdateRequested;

  /// запрошена очистка логов
  const factory AppLoggerEvent.onClearRequested() = _EventOnClearRequested;
}
