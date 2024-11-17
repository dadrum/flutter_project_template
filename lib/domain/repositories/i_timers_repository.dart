import 'dart:async';

import '../entities/in_app_timer.dart';

// -----------------------------------------------------------------------------
class TimerEvent {
  TimerEvent({
    required this.timerType,
    required this.timesLeft,
  });

  final InAppTimers timerType;
  final int? timesLeft;
}

// -----------------------------------------------------------------------------
typedef TimersSubscription = StreamSubscription<TimerEvent>;

// -----------------------------------------------------------------------------
/// repository for global timers
abstract class IGlobalTimersRepository {
  /// the remaining number of seconds
  int? getTimerCounter(InAppTimers timerType);

  /// starting the Timer
  /// returns the number of seconds with which the timer will be initiated
  int startTimer({required InAppTimers timerType, int timeout});

  /// reads the timeout start date from the cache and updates the value
  /// the remaining time. Relevant on iPhones after a status change
  /// application works
  void restoreTimers();

  /// reset the timer
  Future<void> dropTimer(InAppTimers timerType);

  /// reset all timers. It is called for example when the user's account is logged out or deleted
  void dropAllTimers();

  /// closing the repository, closing streams
  Future<void> close();

  /// subscribing to changes in the repository
  TimersSubscription subscribe(Function(TimerEvent) listener);
}
