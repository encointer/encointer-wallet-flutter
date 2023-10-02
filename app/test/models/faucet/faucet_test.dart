import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/models/faucet/faucet.dart';

void main() {
  group('faucet', () {
    test('Can parse js value', () async {
      const faucetJson = '''
      {
        "creator": "5HdLw7t5LjjZ9vSeFiYRbcJf6uFX9xqzv3QappFBy9P8pR9e",
        "dripAmount": 5000000000000,
        "name": "0x466175636574466f724d7942756464696573",
        "purposeId": 1,
        "whitelist": [{
          "digest": "0xbaa9744a",
          "geohash": "0x6535647674"
        }, {
          "digest": "0x2b2f978b",
          "geohash": "0x6470636d35"
        }]
      }''';

      final faucet = Faucet.fromJson(jsonDecode(faucetJson) as Map<String, dynamic>);

      expect(faucet.creator, '5HdLw7t5LjjZ9vSeFiYRbcJf6uFX9xqzv3QappFBy9P8pR9e');
      expect(faucet.dripAmount, 5000000000000);
      expect(faucet.purposeId, 1);

      final cid0 = CommunityIdentifier.fromJson(jsonDecode('''
      {
        "digest": "0xbaa9744a",
        "geohash": "0x6535647674"
      }''') as Map<String, dynamic>);

      expect(faucet.whitelist![0], cid0);
    });
  });
}
