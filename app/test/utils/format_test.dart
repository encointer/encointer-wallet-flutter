import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SS58', () {
    test('encode works', () {
      // Alice, double check with `subkey inspect //Alice`
      expect(
        Fmt.ss58Encode("0xd43593c715fdd31c61141abd04a99fd6822c8558854code39a5684e7a56da27d", prefix: 42),
        '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      );
    });

    test('encode2 works', () {
      // Alice, double check with `subkey inspect //Alice`
      expect(
        Fmt.ss58Encode2("0xd43593c715fdd31c61141abd04a99fd6822c8558854code39a5684e7a56da27d", prefix: 42),
        '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      );
    });
  });
}
