import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dep_gen/dep_gen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/interfaces/i_error_logger.dart';

part 'events.dart';

part 'states.dart';

part 'app_logger_bloc.freezed.dart';

@DepGen()
class AppLoggerBloc extends Bloc<AppLoggerEvent, AppLoggerState> {
  // ---------------------------------------------------------------------------
  AppLoggerBloc({
    @DepArg() required IErrorLogger errorLogger,
  })  : _errorLogger = errorLogger,
        super(const AppLoggerState.screenState(logsStack: [])) {
    // event handling
    on<AppLoggerEvent>(
      (event, emitter) => event.map(
        onUpdateRequested: (e) => _onUpdateRequested(emitter),
        onClearRequested: (e) => _onClearRequested(emitter),
      ),
    );

    add(const AppLoggerEvent.onUpdateRequested());
  }

  // DEPENDENCIES:
  // ---------------------------------------------------------------------------
  final IErrorLogger _errorLogger;

  //  STATES:
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// logs update requested
  Future<void> _onUpdateRequested(Emitter<AppLoggerState> emitter) async {
    emitter(AppLoggerState.screenState(
      logsStack: _errorLogger.getStack(),
    ));
  }

  // ---------------------------------------------------------------------------
  /// log cleanup requested
  Future<void> _onClearRequested(
    Emitter<AppLoggerState> emitter,
  ) async {
    _errorLogger.clearStack();

    emitter(AppLoggerState.screenState(
      logsStack: _errorLogger.getStack(),
    ));
  }
}
