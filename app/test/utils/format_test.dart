import 'dart:typed_data';

import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SS58', () {
    // Alice pubKey, double check with `subkey inspect //Alice`
    const alice = '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d';

    group('Encode', () {
      test('ss58Encode works for prefix 2', () {
        // Prefix of the encointer kusama-parachain (production) and rococo-parachain (testnet).
        // Reproduce with `subkey inspect //Alice -n kusama`
        expect(Fmt.ss58Encode(alice, prefix: 2), 'HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');
      });

      test('ss58Encode works for prefix 42', () {
        // Prefix of the other encointer testnets.
        // Reproduce with `subkey inspect //Alice`
        expect(Fmt.ss58Encode(alice), '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      });

      test('ss58Encode fails for prefix >= 64', () {
        try {
          Fmt.ss58Encode(alice, prefix: 64);
        } catch (e) {
          expect(e.toString(), 'Exception: prefixes >= 64 are currently not supported');
        }
      });
    });

    group('Decode', () {
      test('ss58Decode works for prefix 2', () {
        final result = Fmt.ss58Decode('HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');
        expect(result.prefix, 2);
        expect(result.pubKey, alice);
      });

      test('ss58Decode works for prefix 42', () {
        final result = Fmt.ss58Decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
        expect(result.prefix, 42);
        expect(result.pubKey, alice);
      });

      test('ss58Decode fails for wrong checksum', () {
        try {
          // Replaced last letter: Y -> Q
          Fmt.ss58Decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQQ');
        } catch (e) {
          expect(e.toString(), 'Exception: Invalid checksum: [29, 25] != [29, 33]');
        }
      });

      test('ss58Decode fails for prefix too big', () {
        try {
          // Removed last letter. I don't really know how to trigger specific prefixes.
          Fmt.ss58Decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQ');
        } catch (e) {
          expect(e.toString(), 'Exception: prefixes >= 64 are currently not supported');
        }
      });

      // I could not find out how to trigger wrong length yet...
    });

    test('blake2bWithSs58Pre works', () {
      final hello = Uint8List.fromList('hello'.codeUnits);
      final hash = Fmt.blake2WithSs58Pre(hello);
      expect(hash, rustHelloHashWithPrefix);
    });

    test('SS58PRE matches rust value', () {
      expect(
        Fmt.ss58Prefix,
        // Corresponds to rust's: `const PREFIX: &[u8] = b"SS58PRE";`
        List<int>.from([83, 83, 53, 56, 80, 82, 69]),
      );
    });
  });
}

/// This is the value obtained by the following rust function:
///
/// ```rust
/// const PREFIX: &[u8] = b"SS58PRE";
///
/// fn blake2b(data: &[u8]) -> Vec<u8> {
///     use blake2::{Blake2b512, Digest};
///
///     let mut ctx = Blake2b512::new();
///     ctx.update(PREFIX);
///     ctx.update(data);
///     ctx.finalize().to_vec()
/// }
///
/// blake2b(b"hello")
/// ```
final rustHelloHashWithPrefix = List<int>.from([
  88,
  202,
  6,
  102,
  51,
  141,
  3,
  199,
  32,
  83,
  28,
  81,
  100,
  25,
  199,
  244,
  15,
  229,
  18,
  218,
  73,
  28,
  53,
  88,
  44,
  37,
  167,
  97,
  168,
  74,
  163,
  176,
  12,
  174,
  194,
  191,
  48,
  186,
  230,
  104,
  194,
  149,
  101,
  217,
  8,
  150,
  232,
  70,
  164,
  72,
  101,
  229,
  6,
  87,
  151,
  185,
  173,
  118,
  38,
  146,
  30,
  102,
  65,
  187
]);
