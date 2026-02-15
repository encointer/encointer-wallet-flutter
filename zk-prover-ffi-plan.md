# Plan: Wire ZK Prover Native Library via dart:ffi

## Context

The `ew_zk_prover` Dart package has a complete public API (`ZkProver`, `ProofInput`, `ProofResult`) but all methods throw `UnimplementedError`. The Rust FFI crate at `packages/ew_zk_prover/rust` (symlink to `encointer-pallets/offline-payment/ffi/`) is fully implemented with 6 public functions. We need to bridge the two via manual `dart:ffi` — no flutter_rust_bridge.

## Steps

### 1. Add `extern "C"` wrappers to Rust lib.rs

**File:** `packages/ew_zk_prover/rust/src/lib.rs` (symlink to `/work/encointer-pallets/offline-payment/ffi/src/lib.rs`)

Append C-ABI wrappers for all 6 functions + memory management:

| Symbol | Signature |
|--------|-----------|
| `ffi_derive_zk_secret` | `(ptr, len, out32) -> void` |
| `ffi_blake2_256` | `(ptr, len, out32) -> void` |
| `ffi_compute_commitment` | `(in32, out32) -> void` |
| `ffi_generate_proof` | `(pk, pk_len, secret32, nonce32, recipient32, amount32, cid32) -> *mut FfiProofOutput` |
| `ffi_verify_proof` | `(vk, vk_len, proof, proof_len, commitment32, recipient32, amount32, cid32, nullifier32) -> i32` |
| `ffi_generate_test_setup` | `(seed: u64) -> *mut FfiTestSetup` |
| `ffi_free_proof_output` | `(*mut FfiProofOutput) -> void` |
| `ffi_free_test_setup` | `(*mut FfiTestSetup) -> void` |
| `ffi_last_error` | `() -> *mut c_char` |
| `ffi_free_string` | `(*mut c_char) -> void` |

Error handling: thread-local `LAST_ERROR` string, queried via `ffi_last_error`.

Variable-length outputs (`proof_bytes`, proving/verifying keys): Rust allocates via `Box::into_raw`, Dart reads via pointer+length, then calls the paired free function.

Also add `name = "ew_zk_prover"` to `[lib]` in Cargo.toml so the output is `libew_zk_prover.so`.

### 2. Cross-compilation setup

**Targets:**
- `rustup target add aarch64-linux-android armv7-linux-androideabi x86_64-linux-android aarch64-apple-ios aarch64-apple-ios-sim x86_64-apple-ios`

**Android:**
- Create `packages/ew_zk_prover/rust/.cargo/config.toml` with NDK linker paths (API 21, NDK 28.2)
- Build 3 ABIs → `.so` files in `packages/ew_zk_prover/android/src/main/jniLibs/{arm64-v8a,armeabi-v7a,x86_64}/`

**iOS:**
- Build `aarch64-apple-ios` (device) + `aarch64-apple-ios-sim` + `x86_64-apple-ios` (simulators) → `.a` static libs
- Create a universal simulator lib via `lipo` and an XCFramework via `xcodebuild -create-xcframework`
- Place at `packages/ew_zk_prover/ios/Frameworks/ew_zk_prover.xcframework`
- Update `ew_zk_prover.podspec` to vendor the xcframework

**Linux (host tests):**
- Build `x86_64-unknown-linux-gnu` → `libew_zk_prover.so` in `packages/ew_zk_prover/native/linux/`

### 3. Dart FFI bindings

**New file:** `packages/ew_zk_prover/lib/src/ffi_bindings.dart`

- `DynamicLibrary` loading per platform (Android: `.open('libew_zk_prover.so')`, Linux: relative path, iOS: `.process()` since statically linked)
- Native function typedefs + lookups for all 10 symbols
- `FfiProofOutput` and `FfiTestSetup` as `dart:ffi` `Struct` classes
- High-level methods that allocate buffers, call FFI, copy results, free native memory
- Uses `package:ffi` for `malloc`/`calloc`

### 4. Wire ZkProver stub to FFI

**File:** `packages/ew_zk_prover/lib/ew_zk_prover.dart`

- Replace all `throw UnimplementedError(...)` with FFI calls via `ffi_bindings.dart`
- Sync functions (`deriveZkSecret`, `computeCommitment`, `blake2_256`): direct FFI call
- Async functions (`generateProof`, `verifyProof`): wrap in `Isolate.run()` since proof gen ~5s
- Change `verifyProof` to take named individual Uint8List params (matches Rust API, no callsites to break)
- Add `generateTestSetup(int seed)` for testing

### 5. Package config updates

**`packages/ew_zk_prover/pubspec.yaml`:**
- Add `ffi: ^2.1.0` dependency
- Add `flutter.plugin.platforms` with `ffiPlugin: true` for android and ios

**`packages/ew_zk_prover/android/build.gradle`:**
- Ensure `jniLibs.srcDirs = ['src/main/jniLibs']` in sourceSets

**`packages/ew_zk_prover/ios/ew_zk_prover.podspec`:**
- Uncomment and update: vendor `Frameworks/ew_zk_prover.xcframework`
- Add `pod_target_xcconfig` for linker flags

### 6. Dart test on host

**New file:** `packages/ew_zk_prover/test/zk_prover_ffi_test.dart`

- `deriveZkSecret` determinism
- `blake2_256` determinism
- `computeCommitment` determinism
- End-to-end: `generateTestSetup` → `generateProof` → `verifyProof`

### 7. Rebuild APK

Verify the native libraries are bundled and the APK builds.

## Files to modify/create

| File | Action |
|------|--------|
| `packages/ew_zk_prover/rust/src/lib.rs` | Append extern "C" wrappers |
| `packages/ew_zk_prover/rust/Cargo.toml` | Add `name = "ew_zk_prover"` to [lib] |
| `packages/ew_zk_prover/rust/.cargo/config.toml` | New: NDK linker config |
| `packages/ew_zk_prover/lib/src/ffi_bindings.dart` | New: dart:ffi bindings |
| `packages/ew_zk_prover/lib/ew_zk_prover.dart` | Replace stubs with FFI calls |
| `packages/ew_zk_prover/pubspec.yaml` | Add ffi dep, ffiPlugin |
| `packages/ew_zk_prover/android/build.gradle` | jniLibs sourceSets |
| `packages/ew_zk_prover/ios/ew_zk_prover.podspec` | Vendor xcframework, linker flags |
| `packages/ew_zk_prover/test/zk_prover_ffi_test.dart` | New: FFI integration test |

## Verification

1. `cargo test` in the Rust crate (existing 19 tests still pass)
2. `cargo build --release` for all 7 targets succeeds (3 Android, 3 iOS, 1 Linux)
3. `flutter test packages/ew_zk_prover/test/zk_prover_ffi_test.dart` passes on host
4. `flutter build apk --split-per-abi --flavor dev` succeeds with .so bundled

Note: iOS cross-compilation (`aarch64-apple-ios`) requires macOS with Xcode. On this Linux host, the iOS targets/config will be set up but cannot be compiled. The build script will skip iOS when not on macOS. The podspec and pubspec config will be ready for macOS CI.
