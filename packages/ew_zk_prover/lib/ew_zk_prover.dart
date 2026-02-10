/// Dart bindings for the Encointer ZK prover (arkworks Groth16 via flutter_rust_bridge).
///
/// The native library is loaded via flutter_rust_bridge's generated code.
/// Until the Rust crate compiles (pending pallet dependency), this file
/// provides the public API surface that other Dart code can import and reference.
library;

import 'dart:typed_data';

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
/// Wraps the Rust FFI functions via flutter_rust_bridge.
/// Methods will throw until the native library is compiled with the pallet dependency.
class ZkProver {
  /// Derive zk_secret from account seed.
  ///
  /// Computes: `blake2_256(seed || "encointer-offline-commitment")`
  static Uint8List deriveZkSecret(Uint8List seed) {
    // TODO: Call Rust FFI via flutter_rust_bridge generated bindings.
    // return api.deriveZkSecret(seed: seed);
    throw UnimplementedError('ZkProver.deriveZkSecret: native library not yet compiled');
  }

  /// Compute Poseidon commitment from zk_secret.
  static Uint8List computeCommitment(Uint8List zkSecret) {
    // TODO: Call Rust FFI via flutter_rust_bridge generated bindings.
    // return api.computeCommitment(zkSecret: zkSecret);
    throw UnimplementedError('ZkProver.computeCommitment: native library not yet compiled');
  }

  /// Generate a Groth16 proof for an offline payment.
  static Future<ProofResult> generateProof(ProofInput input) async {
    // TODO: Call Rust FFI via flutter_rust_bridge generated bindings.
    // final result = await api.generateProof(...);
    // return ProofResult(proofBytes: result.proofBytes, ...);
    throw UnimplementedError('ZkProver.generateProof: native library not yet compiled');
  }

  /// Verify a proof locally (optional, for seller confidence).
  static Future<bool> verifyProof(Uint8List vkBytes, Uint8List proofBytes, List<Uint8List> publicInputs) async {
    // TODO: Call Rust FFI via flutter_rust_bridge generated bindings.
    // return api.verifyProof(vkBytes: vkBytes, proofBytes: proofBytes, ...);
    throw UnimplementedError('ZkProver.verifyProof: native library not yet compiled');
  }

  /// Blake2b-256 hash (matches Substrate's `sp_io::hashing::blake2_256`).
  static Uint8List blake2_256(Uint8List data) {
    // TODO: Call Rust FFI via flutter_rust_bridge generated bindings.
    // return api.blake2_256(data: data);
    throw UnimplementedError('ZkProver.blake2_256: native library not yet compiled');
  }
}
