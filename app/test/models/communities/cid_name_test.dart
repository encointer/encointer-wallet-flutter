import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseListIntOrReturnInput works', () {
    test('returns input for valid string', () {
      expect(parseListIntOrReturnInput('Leu Zurich'), 'Leu Zurich');
    });

    test('decodes list of int correctly', () {
      expect(parseListIntOrReturnInput('65,100,114,105,97,110,97'), 'Adriana');
    });
  });
}
