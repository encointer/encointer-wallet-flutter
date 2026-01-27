import 'package:ew_polkadart/generated/asset_hub_kusama/types/sp_core/crypto/account_id32.dart';
import 'package:polkadart/scale_codec.dart' show decodeHex;
import 'package:polkadart/substrate/substrate.dart' show StorageHasher, StorageMap;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show encodeHex;
import 'package:test/test.dart';

void main() {
  group('test hasher', () {
    test('TwoxxHasher with 32-byte AccountId', () {
      // This is the AccountId bytes that need to be hashed
      final accountId = decodeHex(
        '26be5a2c3b0c85d4f4783e2950a293b0c9f6026e5c5a897bbb9d0746a52de907',
      );

      final storageMap = StorageMap(
        prefix: 'Proxy',
        storage: 'Proxies',
        hasher: StorageHasher.twoxx64Concat(AccountId32Codec()),
        // Random codec, we do not care about the value.
        valueCodec: AccountId32Codec(),
      );

      // Expected output (from Polkadot.js)
      final module = '1809d78346727a0ef58c0fa03bafa323';
      final method = '1d885dcfb277f185f2d8e62a5f290c85';
      final twox64ConcatAccountId32 = '427611b5147e9bca26be5a2c3b0c85d4f4783e2950a293b0c9f6026e5c5a897bbb9d0746a52de907';
      final expectedHash = decodeHex(module + method + twox64ConcatAccountId32);

      final key = storageMap.hashedKeyFor(accountId);

      expect(
        encodeHex(key),
        encodeHex(expectedHash),
        reason: 'Twox64 hash of 32-byte AccountId should match PJS',
      );
    });
  });
}
