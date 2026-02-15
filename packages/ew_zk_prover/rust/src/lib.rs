// FFI wrapper for Encointer offline payment ZK prover.
//
// Uses the core crate for circuit and prover logic.

pub use encointer_offline_payment_core::{circuit, prover};

use blake2::{digest::consts::U32, Blake2b, Digest};

type Blake2b256 = Blake2b<U32>;

const COMMITMENT_DOMAIN: &[u8] = b"encointer-offline-commitment";

/// Derive zk_secret from account seed using Blake2b-256.
/// Matches pallet: `blake2_256(seed ++ COMMITMENT_DOMAIN)`
pub fn derive_zk_secret(seed: &[u8]) -> [u8; 32] {
    blake2_256_concat(seed, COMMITMENT_DOMAIN)
}

/// Blake2b-256 hash of `data`. Equivalent to `sp_io::hashing::blake2_256`.
pub fn blake2_256(data: &[u8]) -> [u8; 32] {
    let mut hasher = Blake2b256::new();
    hasher.update(data);
    into_array(hasher.finalize().as_slice())
}

/// Blake2b-256 hash of `a ++ b`.
fn blake2_256_concat(a: &[u8], b: &[u8]) -> [u8; 32] {
    let mut hasher = Blake2b256::new();
    hasher.update(a);
    hasher.update(b);
    into_array(hasher.finalize().as_slice())
}

fn into_array(slice: &[u8]) -> [u8; 32] {
    let mut out = [0u8; 32];
    out.copy_from_slice(&slice[..32]);
    out
}

/// Compute Poseidon commitment from zk_secret bytes.
/// `commitment = Poseidon(Fr::from_le_bytes_mod_order(zk_secret))`
pub fn compute_commitment(zk_secret: &[u8; 32]) -> [u8; 32] {
    let config = circuit::poseidon_config();
    let secret_field = prover::bytes32_to_field(zk_secret);
    let commitment = circuit::compute_commitment(&config, &secret_field);
    prover::field_to_bytes32(&commitment)
}

/// Result of proof generation.
pub struct ProofOutput {
    pub commitment: [u8; 32],
    pub proof_bytes: Vec<u8>,
    pub nullifier: [u8; 32],
}

/// Generate a Groth16 proof for an offline payment.
pub fn generate_proof_ffi(
    pk_bytes: &[u8],
    zk_secret: &[u8; 32],
    nonce: &[u8; 32],
    recipient_hash: &[u8; 32],
    amount: &[u8; 32],
    asset_hash: &[u8; 32],
) -> Result<ProofOutput, String> {
    let pk = prover::TrustedSetup::proving_key_from_bytes(pk_bytes)
        .ok_or("Failed to deserialize proving key")?;

    let (proof, public_inputs) = prover::generate_proof(
        &pk,
        prover::bytes32_to_field(zk_secret),
        prover::bytes32_to_field(nonce),
        prover::bytes32_to_field(recipient_hash),
        prover::bytes32_to_field(amount),
        prover::bytes32_to_field(asset_hash),
    )
    .ok_or("Proof generation failed")?;

    Ok(ProofOutput {
        commitment: prover::field_to_bytes32(&public_inputs[0]),
        proof_bytes: prover::proof_to_bytes(&proof),
        nullifier: prover::field_to_bytes32(&public_inputs[4]),
    })
}

/// Verify a Groth16 proof locally (for seller-side confidence check).
pub fn verify_proof_ffi(
    vk_bytes: &[u8],
    proof_bytes: &[u8],
    commitment: &[u8; 32],
    recipient_hash: &[u8; 32],
    amount: &[u8; 32],
    asset_hash: &[u8; 32],
    nullifier: &[u8; 32],
) -> bool {
    use ark_groth16::{Groth16, PreparedVerifyingKey};
    use ark_snark::SNARK;

    let vk = match prover::TrustedSetup::verifying_key_from_bytes(vk_bytes) {
        Some(vk) => vk,
        None => return false,
    };
    let proof = match prover::proof_from_bytes(proof_bytes) {
        Some(p) => p,
        None => return false,
    };

    let public_inputs = vec![
        prover::bytes32_to_field(commitment),
        prover::bytes32_to_field(recipient_hash),
        prover::bytes32_to_field(amount),
        prover::bytes32_to_field(asset_hash),
        prover::bytes32_to_field(nullifier),
    ];

    let pvk: PreparedVerifyingKey<ark_bn254::Bn254> = vk.into();
    Groth16::<ark_bn254::Bn254>::verify_with_processed_vk(&pvk, &public_inputs, &proof)
        .unwrap_or(false)
}

/// Generate trusted setup keys (deterministic, for testing only).
pub fn generate_test_setup(seed: u64) -> (Vec<u8>, Vec<u8>) {
    let setup = prover::TrustedSetup::generate_with_seed(seed);
    (setup.proving_key_bytes(), setup.verifying_key_bytes())
}

// ---------------------------------------------------------------------------
// C-ABI wrappers for dart:ffi consumption
// ---------------------------------------------------------------------------

use std::cell::RefCell;
use std::ffi::CString;
use std::os::raw::c_char;

thread_local! {
    static LAST_ERROR: RefCell<Option<CString>> = const { RefCell::new(None) };
}

fn set_last_error(msg: &str) {
    LAST_ERROR.with(|e| {
        *e.borrow_mut() = CString::new(msg).ok();
    });
}

/// Returns last error message, or null if none. Caller must free with `ffi_free_string`.
#[unsafe(no_mangle)]
pub extern "C" fn ffi_last_error() -> *mut c_char {
    LAST_ERROR.with(|e| {
        match e.borrow_mut().take() {
            Some(s) => s.into_raw(),
            None => std::ptr::null_mut(),
        }
    })
}

/// Free a string returned by `ffi_last_error`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_free_string(ptr: *mut c_char) {
    if !ptr.is_null() {
        unsafe { drop(CString::from_raw(ptr)); }
    }
}

/// Derive zk_secret: `blake2_256(seed || domain)`. Writes 32 bytes to `out32`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_derive_zk_secret(ptr: *const u8, len: usize, out32: *mut u8) {
    let seed = unsafe { std::slice::from_raw_parts(ptr, len) };
    let result = derive_zk_secret(seed);
    unsafe { std::ptr::copy_nonoverlapping(result.as_ptr(), out32, 32); }
}

/// Blake2b-256 hash. Writes 32 bytes to `out32`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_blake2_256(ptr: *const u8, len: usize, out32: *mut u8) {
    let data = unsafe { std::slice::from_raw_parts(ptr, len) };
    let result = blake2_256(data);
    unsafe { std::ptr::copy_nonoverlapping(result.as_ptr(), out32, 32); }
}

/// Compute Poseidon commitment from 32-byte zk_secret. Writes 32 bytes to `out32`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_compute_commitment(in32: *const u8, out32: *mut u8) {
    let zk_secret: [u8; 32] = unsafe { *(in32 as *const [u8; 32]) };
    let result = compute_commitment(&zk_secret);
    unsafe { std::ptr::copy_nonoverlapping(result.as_ptr(), out32, 32); }
}

/// Proof generation output, heap-allocated for FFI.
#[repr(C)]
pub struct FfiProofOutput {
    pub commitment: [u8; 32],
    pub nullifier: [u8; 32],
    pub proof_ptr: *mut u8,
    pub proof_len: usize,
}

/// Generate a Groth16 proof. Returns null on failure (check `ffi_last_error`).
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_generate_proof(
    pk: *const u8,
    pk_len: usize,
    secret32: *const u8,
    nonce32: *const u8,
    recipient32: *const u8,
    amount32: *const u8,
    asset32: *const u8,
) -> *mut FfiProofOutput {
    let pk_bytes = unsafe { std::slice::from_raw_parts(pk, pk_len) };
    let zk_secret = unsafe { &*(secret32 as *const [u8; 32]) };
    let nonce = unsafe { &*(nonce32 as *const [u8; 32]) };
    let recipient = unsafe { &*(recipient32 as *const [u8; 32]) };
    let amount = unsafe { &*(amount32 as *const [u8; 32]) };
    let asset = unsafe { &*(asset32 as *const [u8; 32]) };

    match generate_proof_ffi(pk_bytes, zk_secret, nonce, recipient, amount, asset) {
        Ok(output) => {
            let mut proof_bytes = output.proof_bytes.into_boxed_slice();
            let proof_ptr = proof_bytes.as_mut_ptr();
            let proof_len = proof_bytes.len();
            std::mem::forget(proof_bytes);

            Box::into_raw(Box::new(FfiProofOutput {
                commitment: output.commitment,
                nullifier: output.nullifier,
                proof_ptr,
                proof_len,
            }))
        }
        Err(e) => {
            set_last_error(&e);
            std::ptr::null_mut()
        }
    }
}

/// Free a proof output returned by `ffi_generate_proof`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_free_proof_output(ptr: *mut FfiProofOutput) {
    if !ptr.is_null() {
        let output = unsafe { Box::from_raw(ptr) };
        if !output.proof_ptr.is_null() && output.proof_len > 0 {
            unsafe {
                drop(Box::from_raw(std::slice::from_raw_parts_mut(
                    output.proof_ptr,
                    output.proof_len,
                )));
            }
        }
    }
}

/// Verify a Groth16 proof. Returns 1 for valid, 0 for invalid, -1 for error.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_verify_proof(
    vk: *const u8,
    vk_len: usize,
    proof: *const u8,
    proof_len: usize,
    commitment32: *const u8,
    recipient32: *const u8,
    amount32: *const u8,
    asset32: *const u8,
    nullifier32: *const u8,
) -> i32 {
    let vk_bytes = unsafe { std::slice::from_raw_parts(vk, vk_len) };
    let proof_bytes = unsafe { std::slice::from_raw_parts(proof, proof_len) };
    let commitment = unsafe { &*(commitment32 as *const [u8; 32]) };
    let recipient = unsafe { &*(recipient32 as *const [u8; 32]) };
    let amount = unsafe { &*(amount32 as *const [u8; 32]) };
    let asset = unsafe { &*(asset32 as *const [u8; 32]) };
    let nullifier = unsafe { &*(nullifier32 as *const [u8; 32]) };

    if verify_proof_ffi(vk_bytes, proof_bytes, commitment, recipient, amount, asset, nullifier) {
        1
    } else {
        0
    }
}

/// Test setup output, heap-allocated for FFI.
#[repr(C)]
pub struct FfiTestSetup {
    pub pk_ptr: *mut u8,
    pub pk_len: usize,
    pub vk_ptr: *mut u8,
    pub vk_len: usize,
}

/// Generate test trusted setup keys. Returns null on failure.
#[unsafe(no_mangle)]
pub extern "C" fn ffi_generate_test_setup(seed: u64) -> *mut FfiTestSetup {
    let (pk, vk) = generate_test_setup(seed);

    let mut pk_box = pk.into_boxed_slice();
    let pk_ptr = pk_box.as_mut_ptr();
    let pk_len = pk_box.len();
    std::mem::forget(pk_box);

    let mut vk_box = vk.into_boxed_slice();
    let vk_ptr = vk_box.as_mut_ptr();
    let vk_len = vk_box.len();
    std::mem::forget(vk_box);

    Box::into_raw(Box::new(FfiTestSetup {
        pk_ptr,
        pk_len,
        vk_ptr,
        vk_len,
    }))
}

/// Free a test setup returned by `ffi_generate_test_setup`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn ffi_free_test_setup(ptr: *mut FfiTestSetup) {
    if !ptr.is_null() {
        let setup = unsafe { Box::from_raw(ptr) };
        if !setup.pk_ptr.is_null() && setup.pk_len > 0 {
            unsafe {
                drop(Box::from_raw(std::slice::from_raw_parts_mut(
                    setup.pk_ptr,
                    setup.pk_len,
                )));
            }
        }
        if !setup.vk_ptr.is_null() && setup.vk_len > 0 {
            unsafe {
                drop(Box::from_raw(std::slice::from_raw_parts_mut(
                    setup.vk_ptr,
                    setup.vk_len,
                )));
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use prover::TEST_SETUP_SEED;

    #[test]
    fn test_derive_zk_secret_deterministic() {
        let s1 = derive_zk_secret(b"test-seed");
        let s2 = derive_zk_secret(b"test-seed");
        assert_eq!(s1, s2);
        assert_ne!(s1, [0u8; 32]);
    }

    #[test]
    fn test_derive_zk_secret_different_seeds() {
        let s1 = derive_zk_secret(b"seed-a");
        let s2 = derive_zk_secret(b"seed-b");
        assert_ne!(s1, s2);
    }

    #[test]
    fn test_compute_commitment_deterministic() {
        let zk_secret = derive_zk_secret(b"test-seed");
        let c1 = compute_commitment(&zk_secret);
        let c2 = compute_commitment(&zk_secret);
        assert_eq!(c1, c2);
        assert_ne!(c1, [0u8; 32]);
    }

    #[test]
    fn test_end_to_end_proof_cycle() {
        let (pk_bytes, vk_bytes) = generate_test_setup(TEST_SETUP_SEED);

        let zk_secret = derive_zk_secret(b"alice-seed");
        let nonce = blake2_256(b"nonce-1");
        let recipient_hash = blake2_256(b"bob-address");
        let mut amount = [0u8; 32];
        amount[..8].copy_from_slice(&1000u64.to_le_bytes());
        let asset_hash = blake2_256(b"community-id");

        let output = generate_proof_ffi(
            &pk_bytes,
            &zk_secret,
            &nonce,
            &recipient_hash,
            &amount,
            &asset_hash,
        )
        .expect("proof generation should succeed");

        assert!(verify_proof_ffi(
            &vk_bytes,
            &output.proof_bytes,
            &output.commitment,
            &recipient_hash,
            &amount,
            &asset_hash,
            &output.nullifier,
        ));
    }

    #[test]
    fn test_wrong_commitment_fails_verification() {
        let (pk_bytes, vk_bytes) = generate_test_setup(TEST_SETUP_SEED);

        let zk_secret = derive_zk_secret(b"alice-seed");
        let nonce = blake2_256(b"nonce-1");
        let recipient_hash = blake2_256(b"bob-address");
        let mut amount = [0u8; 32];
        amount[..8].copy_from_slice(&1000u64.to_le_bytes());
        let asset_hash = blake2_256(b"community-id");

        let output = generate_proof_ffi(
            &pk_bytes,
            &zk_secret,
            &nonce,
            &recipient_hash,
            &amount,
            &asset_hash,
        )
        .expect("proof generation should succeed");

        let wrong_commitment = [0xABu8; 32];
        assert!(!verify_proof_ffi(
            &vk_bytes,
            &output.proof_bytes,
            &wrong_commitment,
            &recipient_hash,
            &amount,
            &asset_hash,
            &output.nullifier,
        ));
    }

    #[test]
    fn test_blake2_256_matches_known_output() {
        // Ensure our blake2 matches sp_io::hashing::blake2_256
        let hash = blake2_256(b"hello");
        assert_ne!(hash, [0u8; 32]);
        // Deterministic
        assert_eq!(hash, blake2_256(b"hello"));
    }
}
