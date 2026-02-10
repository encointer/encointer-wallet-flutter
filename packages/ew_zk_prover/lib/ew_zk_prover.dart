/// Dart FFI bindings for the Encointer ZK prover (arkworks Groth16).
library;

import 'dart:isolate';
import 'dart:typed_data';

import 'package:ew_zk_prover/src/ffi_bindings.dart';

export 'package:ew_zk_prover/src/ffi_bindings.dart' show ZkProverBindings, nativeLibraryOverride;

/// Result of a ZK proof generation.
class ProofResult {
  const ProofResult({
    required this.proofBytes,
    required this.commitment,
    required this.nullifier,
  });

  final Uint8List proofBytes;
  final Uint8List commitment;
  final Uint8List nullifier;
}

/// Input parameters for proof generation.
class ProofInput {
  const ProofInput({
    required this.provingKey,
    required this.zkSecret,
    required this.nonce,
    required this.recipientHash,
    required this.amount,
    required this.cidHash,
  });

  final Uint8List provingKey;
  final Uint8List zkSecret;
  final Uint8List nonce;
  final Uint8List recipientHash;
  final Uint8List amount;
  final Uint8List cidHash;
}

/// ZK prover for Encointer offline payments.
///
/// Wraps the Rust native library via dart:ffi.
class ZkProver {
  /// Derive zk_secret from account seed.
  ///
  /// Computes: `blake2_256(seed || "encointer-offline-commitment")`
  static Uint8List deriveZkSecret(Uint8List seed) {
    return callDeriveZkSecret(ZkProverBindings(), seed);
  }

  /// Compute Poseidon commitment from zk_secret.
  static Uint8List computeCommitment(Uint8List zkSecret) {
    return callComputeCommitment(ZkProverBindings(), zkSecret);
  }

  /// Generate a Groth16 proof for an offline payment.
  ///
  /// Runs in a separate isolate since proof generation takes several seconds.
  static Future<ProofResult> generateProof(ProofInput input) async {
    final libPath = nativeLibraryOverride;
    final result = await Isolate.run(() {
      nativeLibraryOverride = libPath;
      return callGenerateProof(
        ZkProverBindings(),
        provingKey: input.provingKey,
        zkSecret: input.zkSecret,
        nonce: input.nonce,
        recipientHash: input.recipientHash,
        amount: input.amount,
        cidHash: input.cidHash,
      );
    });
    return ProofResult(
      proofBytes: result.proofBytes,
      commitment: result.commitment,
      nullifier: result.nullifier,
    );
  }

  /// Verify a proof locally (optional, for seller confidence).
  ///
  /// Runs in a separate isolate since verification is CPU-intensive.
  static Future<bool> verifyProof({
    required Uint8List verifyingKey,
    required Uint8List proofBytes,
    required Uint8List commitment,
    required Uint8List recipientHash,
    required Uint8List amount,
    required Uint8List cidHash,
    required Uint8List nullifier,
  }) async {
    final libPath = nativeLibraryOverride;
    return Isolate.run(() {
      nativeLibraryOverride = libPath;
      return callVerifyProof(
        ZkProverBindings(),
        verifyingKey: verifyingKey,
        proofBytes: proofBytes,
        commitment: commitment,
        recipientHash: recipientHash,
        amount: amount,
        cidHash: cidHash,
        nullifier: nullifier,
      );
    });
  }

  /// Blake2b-256 hash (matches Substrate's `sp_io::hashing::blake2_256`).
  static Uint8List blake2_256(Uint8List data) {
    return callBlake2_256(ZkProverBindings(), data);
  }

  /// Generate test trusted setup keys (deterministic, for testing only).
  static ({Uint8List provingKey, Uint8List verifyingKey}) generateTestSetup(int seed) {
    final result = callGenerateTestSetup(ZkProverBindings(), seed);
    return (provingKey: result.provingKey, verifyingKey: result.verifyingKey);
  }
}
