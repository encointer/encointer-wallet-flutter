import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';

void main() {
  group('CommunityIdentifier', () {
    test('toFmtString works', () {
      final cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      expect('gbsuv7YXq9G', cid.toFmtString());
    });

    test('fromFmtString works', () {
      final cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      final cid2 = CommunityIdentifier.fromFmtString('gbsuv7YXq9G');

      expect(cid, cid2);
    });

    test('Object equality works', () {
      // test that we correctly overwrite `==`.

      final cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);
      final cid2 = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      expect(cid, cid2);
    });

    test('Object hashCode equality works', () {
      // test that we correctly overwrite `==` and `hashCode` in compatible manner
      // Failed before: #384

      final cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);
      final cid2 = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      final cidMap = <CommunityIdentifier, String>{};
      cidMap[cid] = 'Hello';

      expect(cidMap[cid2], 'Hello');
    });

    test('Json encode returns same value as received by JS', () {
      final orig = <String, dynamic>{'geohash': '0x73716d3176', 'digest': '0xf08c911c'};

      final parsed = CommunityIdentifier.fromJson(orig);

      expect(jsonEncode(parsed), jsonEncode(orig));
    });
  });
}
