import 'package:flutter/foundation.dart';

class CLog {
  CLog._internal();

  static final CLog _instance = CLog._internal();

  static CLog get instance => _instance;

  // ---------------------------------------------------------------------------
  void grey(String text) {
    final color = getRGBColor(r: 128, g: 128, b: 128);
    if (kDebugMode) {
      print('\x1B[38;5;${color}m' + text + '\x1B[0m');
    }
  }

  // ---------------------------------------------------------------------------
  void red(String text) {
    final color = getRGBColor(r: 255, g: 0, b: 0);
    if (kDebugMode) {
      print('\x1B[38;5;${color}m' + text + '\x1B[0m');
    }
  }

  // ---------------------------------------------------------------------------
  void green(String text) {
    final color = getRGBColor(r: 0, g: 255, b: 0);
    if (kDebugMode) {
      print('\x1B[38;5;${color}m' + text + '\x1B[0m');
    }
  }

  // ---------------------------------------------------------------------------
  void blue(String text) {
    final color = getRGBColor(r: 0, g: 0, b: 255);
    if (kDebugMode) {
      print('\x1B[38;5;${color}m' + text + '\x1B[0m');
    }
  }

  // ---------------------------------------------------------------------------
  @visibleForTesting
  num getRGBColor({num r = 255, num g = 255, num b = 255}) {
    return (((r.clamp(0, 255) / 255) * 5).toInt() * 36 +
            ((g.clamp(0, 255) / 255) * 5).toInt() * 6 +
            ((b.clamp(0, 255) / 255) * 5).toInt() +
            16)
        .clamp(0, 256);
  }
}
