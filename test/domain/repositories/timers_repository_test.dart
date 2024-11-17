import 'dart:async';

import 'package:app_template/data/local_cache/local_cache.dart';
import 'package:app_template/data/repositories/timers_repository.dart';
import 'package:app_template/domain/entities/in_app_timer.dart';
import 'package:app_template/domain/repositories/i_timers_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LocalCache>()])
import 'timers_repository_test.mocks.dart';

void main() {
  group('GlobalTimersRepository', () {
    late IGlobalTimersRepository timersRepository;
    late MockLocalCache mockLocalCache;
    late StreamController<TimerEvent> streamController;

    setUp(() {
      mockLocalCache = MockLocalCache();
      timersRepository = GlobalTimersRepository(mockLocalCache);
      streamController = StreamController<TimerEvent>.broadcast();
    });

    tearDown(() async {
      await timersRepository.close();
      await streamController.close();
    });

    // ---------------------------------------------------------------------------
    test('startTimer should initialize the timer with default timeout', () {
      // When
      final timeout = timersRepository.startTimer(
        timerType: InAppTimers.registrationPinCodeRequestTimeout,
      );

      // Then
      expect(timeout, GlobalTimersRepository.defaultTimeout);
      verify(mockLocalCache.saveTimerEndTime(
        InAppTimers.registrationPinCodeRequestTimeout,
        any,
      )).called(1);
    });

    // ---------------------------------------------------------------------------
    test('startTimer should notify when timer is ticking', () async {
      final events = <TimerEvent>[];
      timersRepository
        ..subscribe(events.add)
        ..startTimer(
            timerType: InAppTimers.registrationPinCodeRequestTimeout,
            timeout: 2);

      // Then
      await Future.delayed(const Duration(seconds: 3));
      expect(events.length, 2);
      expect(
        events.first.timerType,
        InAppTimers.registrationPinCodeRequestTimeout,
      );
      expect(events.last.timesLeft, isNull);
    });

    // ---------------------------------------------------------------------------
    test('dropTimer should cancel the active timer and notify subscribers',
        () async {
      final events = <TimerEvent>[];
      timersRepository
        ..subscribe(events.add)
        ..startTimer(timerType: InAppTimers.restorePinCodeRequestTimeout);
      // We wait a little for the timer to start ticking
      await Future.delayed(const Duration(seconds: 1));
      await timersRepository
          .dropTimer(InAppTimers.restorePinCodeRequestTimeout);
      await Future.delayed(const Duration(seconds: 1));

      // Then
      expect(
          timersRepository
              .getTimerCounter(InAppTimers.restorePinCodeRequestTimeout),
          isNull);
      // the timer managed to tick once
      expect(events.length, 1);
      expect(events.last.timesLeft, GlobalTimersRepository.defaultTimeout - 1);
    });

    // ---------------------------------------------------------------------------
    test('dropAllTimers should cancel all active timers', () async {
      final events = <TimerEvent>[];
      timersRepository
        ..subscribe(events.add)
        ..startTimer(timerType: InAppTimers.restorePinCodeRequestTimeout)
        ..startTimer(timerType: InAppTimers.registrationPinCodeRequestTimeout);
      // We wait a little for the timer to start ticking
      await Future.delayed(const Duration(seconds: 1));
      timersRepository.dropAllTimers();
      await Future.delayed(const Duration(seconds: 1));

      // Then
      expect(
          timersRepository
              .getTimerCounter(InAppTimers.restorePinCodeRequestTimeout),
          isNull);
      expect(
          timersRepository
              .getTimerCounter(InAppTimers.registrationPinCodeRequestTimeout),
          isNull);
      // the timers managed to tick twice
      expect(events.length, 2);
    });

    // ---------------------------------------------------------------------------
    test('restoreTimers should continue active timers', () async {
      // Given
      final futureTime = DateTime.now().add(const Duration(seconds: 3));
      when(mockLocalCache
              .getTimerEndTime(InAppTimers.registrationPinCodeRequestTimeout))
          .thenAnswer((_) async => futureTime);

      final events = <TimerEvent>[];
      timersRepository
        ..subscribe(events.add)

        // When
        ..restoreTimers();

      // Then
      // We are waiting for the restored timer to end
      await Future.delayed(const Duration(seconds: 4));
      expect(events.length, 3); // Event every second and timer completion
      expect(events.last.timesLeft, isNull);
    });

    // ---------------------------------------------------------------------------
    test('subscribe should allow listeners to receive timer events', () async {
      // Given
      final events = <TimerEvent>[];
      timersRepository
        ..subscribe(events.add)

        // When
        ..startTimer(
            timerType: InAppTimers.registrationPinCodeRequestTimeout,
            timeout: 2);

      // Then
      await Future.delayed(const Duration(seconds: 3));
      // two ticks and completion
      expect(events.length, 2);
      // The timer has ended
      expect(events.last.timesLeft, isNull);
    });
  });
}
