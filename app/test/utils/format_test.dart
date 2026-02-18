import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/utils/format.dart';

void main() {
  group('Fmt.dateTime', () {
    test('formats afternoon time in 24h format', () {
      final dt = DateTime(2024, 3, 30, 15, 13);
      expect(Fmt.dateTime(dt), '2024-03-30 15:13');
    });

    test('formats morning time with leading zero', () {
      final dt = DateTime(2024, 3, 30, 9, 5);
      expect(Fmt.dateTime(dt), '2024-03-30 09:05');
    });

    test('formats midnight correctly', () {
      final dt = DateTime(2024, 3, 30);
      expect(Fmt.dateTime(dt), '2024-03-30 00:00');
    });
  });
}
