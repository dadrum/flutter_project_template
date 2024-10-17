import 'package:app_template/domain/extensions/iterable_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Iterable extensions Tests', () {
    // -------------------------------------------------------------------------
    test('firstWhereOrNull(bool Function(E) test)', () async {
      final numbers = [9, 3, 7, 5, 3, 1];
      final emptyNumbers = [];

      expect(
        numbers.firstWhereOrNull((e) => e == 3),
        3,
      );

      expect(
        numbers.firstWhereOrNull((e) => e == 7),
        7,
      );

      expect(
        numbers.firstWhereOrNull((e) => e == 4),
        isNull,
      );

      expect(
        emptyNumbers.firstWhereOrNull((e) => e == 4),
        isNull,
      );
    });
  });
}
