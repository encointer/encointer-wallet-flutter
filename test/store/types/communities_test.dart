import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CommunityIdentifier', () {
    test('toFmtString works', () {
      var cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      expect('gbsuv7YXq9G', cid.toFmtString());
    });

    test('fromFmtString works', () {
      var cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      var cid2 = CommunityIdentifier.fromFmtString("gbsuv7YXq9G");

      expect(cid, cid2);
    });

    test('Object equality works', () {
      // test that we correctly overwrite `==` and `hashCode`

      var cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);
      var cid2 = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      expect(cid, cid2);
    });
  });
}
