import 'dart:io';
import 'dart:typed_data';

import 'package:ew_zk_prover/ew_zk_prover.dart';
import 'package:flutter_test/flutter_test.dart';

/// Rust TEST_SETUP_SEED constant (0xDEADBEEF_CAFEBABE).
const _testSetupSeed = 0xDEADBEEFCAFEBABE;

/// Resolve the native library path relative to the package root.
/// Works whether CWD is the workspace root or the package directory.
String _resolveNativeLibPath() {
  final cwd = Directory.current.path;
  final fromPackage = '$cwd/native/linux/libew_zk_prover.so';
  if (File(fromPackage).existsSync()) return fromPackage;
  return '$cwd/packages/ew_zk_prover/native/linux/libew_zk_prover.so';
}

void main() {
  final nativeLib = _resolveNativeLibPath();
  final hasNativeLib = File(nativeLib).existsSync();

  setUpAll(() {
    if (!hasNativeLib) {
      // Native library not built — skip all tests.
      // Build with: cd packages/ew_zk_prover/rust && cargo build --release
      return;
    }
    nativeLibraryOverride = nativeLib;
  });

  group('ZkProver FFI', skip: hasNativeLib ? null : 'Native library not built', () {
    group('deriveZkSecret', () {
      test('is deterministic', () {
        final seed = Uint8List.fromList('test-seed'.codeUnits);
        final s1 = ZkProver.deriveZkSecret(seed);
        final s2 = ZkProver.deriveZkSecret(seed);
        expect(s1, equals(s2));
        expect(s1, isNot(equals(Uint8List(32))));
      });

      test('different seeds produce different secrets', () {
        final s1 = ZkProver.deriveZkSecret(Uint8List.fromList('seed-a'.codeUnits));
        final s2 = ZkProver.deriveZkSecret(Uint8List.fromList('seed-b'.codeUnits));
        expect(s1, isNot(equals(s2)));
      });
    });

    group('blake2_256', () {
      test('is deterministic', () {
        final data = Uint8List.fromList('hello'.codeUnits);
        final h1 = ZkProver.blake2_256(data);
        final h2 = ZkProver.blake2_256(data);
        expect(h1, equals(h2));
        expect(h1, isNot(equals(Uint8List(32))));
      });

      test('different inputs produce different hashes', () {
        final h1 = ZkProver.blake2_256(Uint8List.fromList('a'.codeUnits));
        final h2 = ZkProver.blake2_256(Uint8List.fromList('b'.codeUnits));
        expect(h1, isNot(equals(h2)));
      });
    });

    group('computeCommitment', () {
      test('is deterministic', () {
        final zkSecret = ZkProver.deriveZkSecret(Uint8List.fromList('test-seed'.codeUnits));
        final c1 = ZkProver.computeCommitment(zkSecret);
        final c2 = ZkProver.computeCommitment(zkSecret);
        expect(c1, equals(c2));
        expect(c1, isNot(equals(Uint8List(32))));
      });
    });

    group('end-to-end proof cycle', () {
      test('generate and verify proof', () async {
        final setup = ZkProver.generateTestSetup(_testSetupSeed);

        final zkSecret = ZkProver.deriveZkSecret(Uint8List.fromList('alice-seed'.codeUnits));
        final nonce = ZkProver.blake2_256(Uint8List.fromList('nonce-1'.codeUnits));
        final recipientHash = ZkProver.blake2_256(Uint8List.fromList('bob-address'.codeUnits));
        final assetHash = ZkProver.blake2_256(Uint8List.fromList('community-id'.codeUnits));

        final amount = Uint8List(32);
        final amountView = ByteData.sublistView(amount);
        amountView.setUint64(0, 1000, Endian.little);

        final result = await ZkProver.generateProof(ProofInput(
          provingKey: setup.provingKey,
          zkSecret: zkSecret,
          nonce: nonce,
          recipientHash: recipientHash,
          amount: amount,
          assetHash: assetHash,
        ));

        expect(result.proofBytes, isNotEmpty);
        expect(result.commitment, isNot(equals(Uint8List(32))));
        expect(result.nullifier, isNot(equals(Uint8List(32))));

        final valid = await ZkProver.verifyProof(
          verifyingKey: setup.verifyingKey,
          proofBytes: result.proofBytes,
          commitment: result.commitment,
          recipientHash: recipientHash,
          amount: amount,
          assetHash: assetHash,
          nullifier: result.nullifier,
        );
        expect(valid, isTrue);
      });

      test('wrong commitment fails verification', () async {
        final setup = ZkProver.generateTestSetup(_testSetupSeed);

        final zkSecret = ZkProver.deriveZkSecret(Uint8List.fromList('alice-seed'.codeUnits));
        final nonce = ZkProver.blake2_256(Uint8List.fromList('nonce-1'.codeUnits));
        final recipientHash = ZkProver.blake2_256(Uint8List.fromList('bob-address'.codeUnits));
        final assetHash = ZkProver.blake2_256(Uint8List.fromList('community-id'.codeUnits));

        final amount = Uint8List(32);
        final amountView = ByteData.sublistView(amount);
        amountView.setUint64(0, 1000, Endian.little);

        final result = await ZkProver.generateProof(ProofInput(
          provingKey: setup.provingKey,
          zkSecret: zkSecret,
          nonce: nonce,
          recipientHash: recipientHash,
          amount: amount,
          assetHash: assetHash,
        ));

        final wrongCommitment = Uint8List(32)..fillRange(0, 32, 0xAB);

        final valid = await ZkProver.verifyProof(
          verifyingKey: setup.verifyingKey,
          proofBytes: result.proofBytes,
          commitment: wrongCommitment,
          recipientHash: recipientHash,
          amount: amount,
          assetHash: assetHash,
          nullifier: result.nullifier,
        );
        expect(valid, isFalse);
      });
    });
  }); // ZkProver FFI
}
