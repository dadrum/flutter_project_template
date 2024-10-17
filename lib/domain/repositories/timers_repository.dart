import 'dart:async';

import '../interfaces/i_local_cache.dart';
import '../interfaces/i_timers_repository.dart';
import '../models/in_app_timer.dart';

// -----------------------------------------------------------------------------
/// repository for global timers
class GlobalTimersRepository implements IGlobalTimersRepository {
  GlobalTimersRepository(ILocalCache localCache) {
    _timers = {};
    _counters = {};
    _localCache = localCache;
    _timersStreamController = StreamController<TimerEvent>.broadcast();
    restoreTimers();
  }

  // ---------------------------------------------------------------------------
  // default timeout, sec
  static const int defaultTimeout = 60;

  // ---------------------------------------------------------------------------
  late final ILocalCache _localCache;

  // active timers
  late Map<InAppTimers, Timer> _timers;

  // timeouts
  late Map<InAppTimers, int> _counters;

  // ---------------------------------------------------------------------------
  // subscriptions, streams
  late final StreamController<TimerEvent> _timersStreamController;

  // ---------------------------------------------------------------------------
  /// the remaining number of seconds
  @override
  int? getTimerCounter(InAppTimers timerType) => _counters[timerType];

  // ---------------------------------------------------------------------------
  /// starting the Timer
  /// returns the number of seconds with which the timer will be initiated
  @override
  int startTimer({
    required InAppTimers timerType,
    int timeout = defaultTimeout,
  }) {
    // deleting information about the timer
    _timers[timerType]?.cancel();
    _timers.remove(timerType);
    _counters.remove(timerType);

    final endTime = DateTime.now().add(Duration(seconds: timeout));
    _localCache.saveTimerEndTime(timerType, endTime);

    _addTimer(timerType, timeout);

    return timeout;
  }

  // ---------------------------------------------------------------------------
  /// reset the timer
  @override
  Future<void> dropTimer(InAppTimers timerType) async {
    // deleting information about the timer
    _timers[timerType]?.cancel();
    _timers.remove(timerType);
    _counters.remove(timerType);

    // removing the timer from the cache
    await _localCache.deleteTimerEndTime(timerType);
  }

  // ---------------------------------------------------------------------------
  /// reset all timers. It is called for example when the user's account is logged out or deleted
  @override
  void dropAllTimers() {
    InAppTimers.values.forEach(dropTimer);
  }

  // ---------------------------------------------------------------------------
  /// closing the repository, closing streams
  @override
  Future<void> close() async {
    await _timersStreamController.close();
  }

  // ---------------------------------------------------------------------------
  /// subscribing to changes in the repository
  @override
  TimersSubscription subscribe(Function(TimerEvent) listener) {
    return _timersStreamController.stream.listen(listener);
  }

  // ---------------------------------------------------------------------------
  /// reads the timeout start date from the cache and updates the value
  /// the remaining time. Relevant on iPhones after a status change
  /// application works
  @override
  void restoreTimers() {
    InAppTimers.values.forEach(_validateTimer);
  }

  // ---------------------------------------------------------------------------
  Future<void> _validateTimer(InAppTimers timerType) async {
    // deleting information about the timer
    _timers[timerType]?.cancel();
    _timers.remove(timerType);
    _counters.remove(timerType);

    final endDateTime = await _localCache.getTimerEndTime(timerType);

    // no such timer was found in the cache
    if (endDateTime == null) {
      _addEvent(timerType, null);
    } else {
      // the timer has been found, but it is already expired
      if (DateTime.now().isAfter(endDateTime)) {
        await _localCache.deleteTimerEndTime(timerType);
        _addEvent(timerType, null);
      } else {
        // An active timer has been found
        final inSeconds = endDateTime.difference(DateTime.now()).inSeconds;

        _addTimer(timerType, inSeconds);
      }
    }
  }

  // ---------------------------------------------------------------------------
  void _addTimer(InAppTimers timerType, int seconds) {
    _counters[timerType] = seconds;

    // adding a timer
    _timers[timerType]?.cancel();
    _timers[timerType] = Timer.periodic(const Duration(seconds: 1), (timer) {
      // reducing the seconds
      _counters[timerType] = _counters[timerType]! - 1;
      // if the countdown is over
      if (_counters[timerType]! <= 0) {
        _localCache.deleteTimerEndTime(timerType);
        timer.cancel();
        _timers.remove(timerType);
        _counters.remove(timerType);
        _addEvent(timerType, null);
      } else {
        _addEvent(timerType, _counters[timerType]);
      }
    });
  }

  // ---------------------------------------------------------------------------
  void _addEvent(InAppTimers timerType, int? value) {
    if (!_timersStreamController.isClosed) {
      _timersStreamController.add(TimerEvent(
        timerType: timerType,
        timesLeft: value,
      ));
    }
  }
}
