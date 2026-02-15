import 'dart:ffi';
import 'dart:io' show Platform;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

// ---------------------------------------------------------------------------
// Native type definitions
// ---------------------------------------------------------------------------

final class FfiProofOutput extends Struct {
  @Array(32)
  external Array<Uint8> commitment;

  @Array(32)
  external Array<Uint8> nullifier;

  external Pointer<Uint8> proofPtr;

  @Size()
  external int proofLen;
}

final class FfiTestSetup extends Struct {
  external Pointer<Uint8> pkPtr;

  @Size()
  external int pkLen;

  external Pointer<Uint8> vkPtr;

  @Size()
  external int vkLen;
}

// ---------------------------------------------------------------------------
// Native function signatures (C types)
// ---------------------------------------------------------------------------

typedef _DeriveZkSecretC = Void Function(Pointer<Uint8>, Size, Pointer<Uint8>);
typedef _Blake2C = Void Function(Pointer<Uint8>, Size, Pointer<Uint8>);
typedef _ComputeCommitmentC = Void Function(Pointer<Uint8>, Pointer<Uint8>);

typedef _GenerateProofC = Pointer<FfiProofOutput> Function(
  Pointer<Uint8>,
  Size,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
);

typedef _VerifyProofC = Int32 Function(
  Pointer<Uint8>,
  Size,
  Pointer<Uint8>,
  Size,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
);

typedef _GenerateTestSetupC = Pointer<FfiTestSetup> Function(Uint64);
typedef _FreeProofOutputC = Void Function(Pointer<FfiProofOutput>);
typedef _FreeTestSetupC = Void Function(Pointer<FfiTestSetup>);
typedef _LastErrorC = Pointer<Utf8> Function();
typedef _FreeStringC = Void Function(Pointer<Utf8>);

// ---------------------------------------------------------------------------
// Dart function signatures
// ---------------------------------------------------------------------------

typedef _DeriveZkSecretDart = void Function(Pointer<Uint8>, int, Pointer<Uint8>);
typedef _Blake2Dart = void Function(Pointer<Uint8>, int, Pointer<Uint8>);
typedef _ComputeCommitmentDart = void Function(Pointer<Uint8>, Pointer<Uint8>);

typedef _GenerateProofDart = Pointer<FfiProofOutput> Function(
  Pointer<Uint8>,
  int,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
);

typedef _VerifyProofDart = int Function(
  Pointer<Uint8>,
  int,
  Pointer<Uint8>,
  int,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
  Pointer<Uint8>,
);

typedef _GenerateTestSetupDart = Pointer<FfiTestSetup> Function(int);
typedef _FreeProofOutputDart = void Function(Pointer<FfiProofOutput>);
typedef _FreeTestSetupDart = void Function(Pointer<FfiTestSetup>);
typedef _LastErrorDart = Pointer<Utf8> Function();
typedef _FreeStringDart = void Function(Pointer<Utf8>);

// ---------------------------------------------------------------------------
// Library loading
// ---------------------------------------------------------------------------

/// Override path for the native library (set before first use in tests).
String? nativeLibraryOverride;

DynamicLibrary _openLibrary() {
  if (nativeLibraryOverride != null) return DynamicLibrary.open(nativeLibraryOverride!);
  if (Platform.isAndroid) return DynamicLibrary.open('libew_zk_prover.so');
  if (Platform.isIOS) return DynamicLibrary.process();
  if (Platform.isLinux) return DynamicLibrary.open('libew_zk_prover.so');
  throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
}

// ---------------------------------------------------------------------------
// Bindings singleton
// ---------------------------------------------------------------------------

class ZkProverBindings {
  factory ZkProverBindings() => _instance ??= ZkProverBindings._(_openLibrary());

  ZkProverBindings._(DynamicLibrary lib)
      : deriveZkSecret = lib.lookupFunction<_DeriveZkSecretC, _DeriveZkSecretDart>('ffi_derive_zk_secret'),
        blake2_256 = lib.lookupFunction<_Blake2C, _Blake2Dart>('ffi_blake2_256'),
        computeCommitment = lib.lookupFunction<_ComputeCommitmentC, _ComputeCommitmentDart>('ffi_compute_commitment'),
        generateProof = lib.lookupFunction<_GenerateProofC, _GenerateProofDart>('ffi_generate_proof'),
        verifyProof = lib.lookupFunction<_VerifyProofC, _VerifyProofDart>('ffi_verify_proof'),
        generateTestSetup = lib.lookupFunction<_GenerateTestSetupC, _GenerateTestSetupDart>('ffi_generate_test_setup'),
        freeProofOutput = lib.lookupFunction<_FreeProofOutputC, _FreeProofOutputDart>('ffi_free_proof_output'),
        freeTestSetup = lib.lookupFunction<_FreeTestSetupC, _FreeTestSetupDart>('ffi_free_test_setup'),
        lastError = lib.lookupFunction<_LastErrorC, _LastErrorDart>('ffi_last_error'),
        freeString = lib.lookupFunction<_FreeStringC, _FreeStringDart>('ffi_free_string');

  /// Allow overriding the library for tests.
  factory ZkProverBindings.fromLibrary(DynamicLibrary lib) => ZkProverBindings._(lib);

  static ZkProverBindings? _instance;

  final _DeriveZkSecretDart deriveZkSecret;
  final _Blake2Dart blake2_256;
  final _ComputeCommitmentDart computeCommitment;
  final _GenerateProofDart generateProof;
  final _VerifyProofDart verifyProof;
  final _GenerateTestSetupDart generateTestSetup;
  final _FreeProofOutputDart freeProofOutput;
  final _FreeTestSetupDart freeTestSetup;
  final _LastErrorDart lastError;
  final _FreeStringDart freeString;

  /// Read and clear the last FFI error, or return null.
  String? getLastError() {
    final ptr = lastError();
    if (ptr == nullptr) return null;
    try {
      return ptr.toDartString();
    } finally {
      freeString(ptr);
    }
  }
}

// ---------------------------------------------------------------------------
// High-level helpers
// ---------------------------------------------------------------------------

Pointer<Uint8> _allocCopy(Uint8List data) {
  final ptr = malloc<Uint8>(data.length);
  ptr.asTypedList(data.length).setAll(0, data);
  return ptr;
}

Uint8List _arrayToList(Array<Uint8> arr) {
  final list = Uint8List(32);
  for (var i = 0; i < 32; i++) {
    list[i] = arr[i];
  }
  return list;
}

Uint8List callDeriveZkSecret(ZkProverBindings b, Uint8List seed) {
  final seedPtr = _allocCopy(seed);
  final outPtr = malloc<Uint8>(32);
  try {
    b.deriveZkSecret(seedPtr, seed.length, outPtr);
    return Uint8List.fromList(outPtr.asTypedList(32));
  } finally {
    malloc.free(seedPtr);
    malloc.free(outPtr);
  }
}

Uint8List callBlake2_256(ZkProverBindings b, Uint8List data) {
  final dataPtr = _allocCopy(data);
  final outPtr = malloc<Uint8>(32);
  try {
    b.blake2_256(dataPtr, data.length, outPtr);
    return Uint8List.fromList(outPtr.asTypedList(32));
  } finally {
    malloc.free(dataPtr);
    malloc.free(outPtr);
  }
}

Uint8List callComputeCommitment(ZkProverBindings b, Uint8List zkSecret) {
  assert(zkSecret.length == 32, 'zkSecret must be 32 bytes');
  final inPtr = _allocCopy(zkSecret);
  final outPtr = malloc<Uint8>(32);
  try {
    b.computeCommitment(inPtr, outPtr);
    return Uint8List.fromList(outPtr.asTypedList(32));
  } finally {
    malloc.free(inPtr);
    malloc.free(outPtr);
  }
}

/// Proof generation result from FFI.
class FfiProofResult {
  const FfiProofResult({required this.commitment, required this.nullifier, required this.proofBytes});
  final Uint8List commitment;
  final Uint8List nullifier;
  final Uint8List proofBytes;
}

FfiProofResult callGenerateProof(
  ZkProverBindings b, {
  required Uint8List provingKey,
  required Uint8List zkSecret,
  required Uint8List nonce,
  required Uint8List recipientHash,
  required Uint8List amount,
  required Uint8List assetHash,
}) {
  final pkPtr = _allocCopy(provingKey);
  final secretPtr = _allocCopy(zkSecret);
  final noncePtr = _allocCopy(nonce);
  final recipientPtr = _allocCopy(recipientHash);
  final amountPtr = _allocCopy(amount);
  final assetPtr = _allocCopy(assetHash);

  try {
    final resultPtr = b.generateProof(
      pkPtr,
      provingKey.length,
      secretPtr,
      noncePtr,
      recipientPtr,
      amountPtr,
      assetPtr,
    );

    if (resultPtr == nullptr) {
      final error = b.getLastError() ?? 'Unknown proof generation error';
      throw StateError(error);
    }

    try {
      final result = resultPtr.ref;
      return FfiProofResult(
        commitment: _arrayToList(result.commitment),
        nullifier: _arrayToList(result.nullifier),
        proofBytes: Uint8List.fromList(result.proofPtr.asTypedList(result.proofLen)),
      );
    } finally {
      b.freeProofOutput(resultPtr);
    }
  } finally {
    malloc.free(pkPtr);
    malloc.free(secretPtr);
    malloc.free(noncePtr);
    malloc.free(recipientPtr);
    malloc.free(amountPtr);
    malloc.free(assetPtr);
  }
}

bool callVerifyProof(
  ZkProverBindings b, {
  required Uint8List verifyingKey,
  required Uint8List proofBytes,
  required Uint8List commitment,
  required Uint8List recipientHash,
  required Uint8List amount,
  required Uint8List assetHash,
  required Uint8List nullifier,
}) {
  final vkPtr = _allocCopy(verifyingKey);
  final proofPtr = _allocCopy(proofBytes);
  final commitPtr = _allocCopy(commitment);
  final recipientPtr = _allocCopy(recipientHash);
  final amountPtr = _allocCopy(amount);
  final assetPtr = _allocCopy(assetHash);
  final nullPtr = _allocCopy(nullifier);

  try {
    return b.verifyProof(
          vkPtr,
          verifyingKey.length,
          proofPtr,
          proofBytes.length,
          commitPtr,
          recipientPtr,
          amountPtr,
          assetPtr,
          nullPtr,
        ) ==
        1;
  } finally {
    malloc.free(vkPtr);
    malloc.free(proofPtr);
    malloc.free(commitPtr);
    malloc.free(recipientPtr);
    malloc.free(amountPtr);
    malloc.free(assetPtr);
    malloc.free(nullPtr);
  }
}

/// Test setup result from FFI.
class FfiTestSetupResult {
  const FfiTestSetupResult({required this.provingKey, required this.verifyingKey});
  final Uint8List provingKey;
  final Uint8List verifyingKey;
}

FfiTestSetupResult callGenerateTestSetup(ZkProverBindings b, int seed) {
  final resultPtr = b.generateTestSetup(seed);
  if (resultPtr == nullptr) {
    throw StateError('Failed to generate test setup');
  }
  try {
    final result = resultPtr.ref;
    return FfiTestSetupResult(
      provingKey: Uint8List.fromList(result.pkPtr.asTypedList(result.pkLen)),
      verifyingKey: Uint8List.fromList(result.vkPtr.asTypedList(result.vkLen)),
    );
  } finally {
    b.freeTestSetup(resultPtr);
  }
}
