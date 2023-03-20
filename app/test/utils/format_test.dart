import 'dart:typed_data';

import 'package:pointycastle/digests/blake2b.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SS58', () {
    test('encode works', () {
      // Alice, double check with `subkey inspect //Alice`
      expect(
        Fmt.ss58Encode('0xd43593c715fdd31c61141abd04a99fd6822c8558854code39a5684e7a56da27d'),
        '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      );
    });

    test('SS58PRE matches rust value', () {
      expect(
        Fmt.SS58PRE,
        // Corresponds to rust's: `const PREFIX: &[u8] = b"SS58PRE";`
        List<int>.from([83, 83, 53, 56, 80, 82, 69]),
      );
    });

    test('blake2b matches rust value', () {
      final hello = Uint8List.fromList('hello'.codeUnits);

      final blake2 = Blake2bDigest()
        ..init()
        ..update(hello, 0, hello.length);

      final hash = Uint8List(blake2.digestSize);
      blake2.doFinal(hash, 0);

      expect(hash, rustHelloHash);
    });

    test('blake2bWithSs58Pre works', () {
      final hello = Uint8List.fromList('hello'.codeUnits);
      final hash = Fmt.blake2WithSs58Pre(hello);
      expect(hash, rustHelloHashWithPrefix);
    });
  });
}

/// This is the value obtained by the following rust function:
///
/// ```rust
/// fn blake2(data: &[u8]) -> Vec<u8> {
///     use blake2::{Blake2b512, Digest};
///
///     let mut ctx = Blake2b512::new();
///     ctx.update(data);
///     ctx.finalize().to_vec()
/// }
/// ```
final rustHelloHash = List<int>.from([
  228,
  207,
  163,
  154,
  61,
  55,
  190,
  49,
  197,
  150,
  9,
  232,
  7,
  151,
  7,
  153,
  202,
  166,
  138,
  25,
  191,
  170,
  21,
  19,
  95,
  22,
  80,
  133,
  224,
  29,
  65,
  166,
  91,
  161,
  225,
  177,
  70,
  174,
  182,
  189,
  0,
  146,
  180,
  158,
  172,
  33,
  76,
  16,
  60,
  207,
  163,
  163,
  101,
  149,
  75,
  187,
  229,
  47,
  116,
  162,
  179,
  98,
  12,
  148
]);

/// This is the value obtained by the following rust function:
///
/// ```rust
/// const PREFIX: &[u8] = b"SS58PRE";
///
/// fn blake2(data: &[u8]) -> Vec<u8> {
///     use blake2::{Blake2b512, Digest};
///
///     let mut ctx = Blake2b512::new();
///     ctx.update(PREFIX);
///     ctx.update(data);
///     ctx.finalize().to_vec()
/// }
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
