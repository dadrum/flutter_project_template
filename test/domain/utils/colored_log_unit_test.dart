import 'dart:async';

import 'package:app_template/domain/utils/colored_log.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CLog Tests', () {
    setUp(() {});

    test('Test grey log', () {
      _testLogColor(CLog.instance.grey, 'Test grey', 128, 128, 128);
    });

    test('Test red log', () {
      _testLogColor(CLog.instance.red, 'Test red', 255, 0, 0);
    });

    test('Test green log', () {
      _testLogColor(CLog.instance.green, 'Test green', 0, 255, 0);
    });

    test('Test blue log', () {
      _testLogColor(CLog.instance.blue, 'Test blue', 0, 0, 255);
    });

    test('Test RGB color calculation', () {
      final clog = CLog.instance;
      expect(clog.getRGBColor(r: 128, g: 128, b: 128), equals(102));
      expect(clog.getRGBColor(r: 255, g: 0, b: 0), equals(196));
      expect(clog.getRGBColor(r: 0, g: 255, b: 0), equals(46));
      expect(clog.getRGBColor(r: 0, g: 0, b: 255), equals(21));
    });
  });
}

// Auxiliary function for testing output
void _testLogColor(
    Function(String) logFunction, String message, int r, int g, int b) {
  final expectedColorCode = _getExpectedColorCode(r, g, b);
  final expectedOutput = '\x1B[38;5;${expectedColorCode}m$message\x1B[0m';

  var printedOutput = '';

  // Interception of the output to the zone
  final ZoneSpecification spec =
      ZoneSpecification(print: (self, parent, zone, line) {
    printedOutput += line;
  });

  // We perform logging and check the output
  Zone.current.fork(specification: spec).run(() {
    logFunction(message);
  });

  expect(printedOutput, equals(expectedOutput));
}

// Getting the expected color code for comparison
int _getExpectedColorCode(int r, int g, int b) {
  return (((r.clamp(0, 255) / 255) * 5).toInt() * 36 +
          ((g.clamp(0, 255) / 255) * 5).toInt() * 6 +
          ((b.clamp(0, 255) / 255) * 5).toInt() +
          16)
      .clamp(0, 256);
}
