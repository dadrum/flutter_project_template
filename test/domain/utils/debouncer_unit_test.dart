import 'package:app_template/domain/utils/debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Debouncer Tests', () {
    late Debouncer<String> debouncer;
    late List<String?> callBackResults;
    const int debouncePeriod = 500;

    // -------------------------------------------------------------------------
    setUp(() {
      callBackResults = [];
      debouncer = Debouncer<String>(
        callBack: (value) => callBackResults.add(value),
        period: debouncePeriod,
      );
    });

    // -------------------------------------------------------------------------
    tearDown(() {
      // Releasing resources after each test
      debouncer.dispose();
    });

    // -------------------------------------------------------------------------
    test('onEvent cache value', () async {
      const testValue = 'test value';
      debouncer.onEvent(testValue);
      expect(debouncer.cachedObject, testValue);
    });

    // -------------------------------------------------------------------------
    test('onEvent triggers callback after delay', () async {
      debouncer.onEvent('test 1');
      expect(callBackResults.isEmpty, true);

      // We expect more time than the debounce period
      await Future.delayed(const Duration(milliseconds: debouncePeriod + 100));

      // We check that the callback was called
      expect(callBackResults.length, 1);
      expect(callBackResults.first, 'test 1');
    });

    // -------------------------------------------------------------------------
    test('onEvent resets the debounce timer on rapid events', () async {
      debouncer.onEvent('test 1');
      await Future.delayed(const Duration(milliseconds: debouncePeriod - 200));

      // The second call before the first one ends
      debouncer.onEvent('test 2');
      await Future.delayed(const Duration(milliseconds: debouncePeriod - 200));

      // We expect a callback after the second event, but not after the first
      expect(callBackResults.isEmpty, true);

      // We are waiting for the end of the second timer
      await Future.delayed(const Duration(milliseconds: debouncePeriod - 200));
      expect(callBackResults.length, 1);
      expect(callBackResults.first, 'test 2');
    });

    // -------------------------------------------------------------------------
    test('Callback triggers immediately on null for non-string types',
        () async {
      final debouncer = Debouncer<int>(
        callBack: (value) => callBackResults.add(value?.toString()),
        period: 500,
      )..onEvent(42);
      expect(callBackResults.isEmpty, true);

      // Passing `null` and waiting for an immediate call
      debouncer.onEvent(null);
      expect(callBackResults.length, 1);
      expect(callBackResults.first, null);
    });

    // -------------------------------------------------------------------------
    test('Callback triggers immediately when clearing non-empty string',
        () async {
      debouncer.onEvent('not empty');
      await Future.delayed(const Duration(milliseconds: 100));

      // We expect a call immediately when passing an empty string
      debouncer.onEvent('');
      expect(callBackResults.length, 1);
      expect(callBackResults.first, '');
    });

    // -------------------------------------------------------------------------
    test('dispose cancels the debounce timer', () async {
      debouncer
        ..onEvent('test dispose')
        ..dispose();

      // We expect more time than the debounce period
      await Future.delayed(const Duration(milliseconds: debouncePeriod + 100));

      // The callback should not be called, since dispose was called
      expect(callBackResults.isEmpty, true);
    });
  });
}
