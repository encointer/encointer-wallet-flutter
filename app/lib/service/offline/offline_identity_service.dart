import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_builder.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_log/ew_log.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:ew_zk_prover/ew_zk_prover.dart';

const _logTarget = 'OfflineIdentityService';

/// Manages offline identity registration for ZK e-cash payments.
///
/// On first enable:
/// 1. Derives zk_secret from account seed (Blake2)
/// 2. Computes Poseidon commitment
/// 3. Submits `registerOfflineIdentity(commitment)` extrinsic
/// 4. Stores zk_secret in secure storage
class OfflineIdentityService {
  OfflineIdentityService(this._secureStorage);

  final SecureStorageInterface _secureStorage;

  static String _zkSecretKey(String pubKey) => 'offline_zk_secret_$pubKey';
  static String _genesisHashKey(String pubKey) => 'offline_genesis_hash_$pubKey';
  static const _provingKeyStorageKey = 'offline_proving_key';

  /// Whether the given account has a stored zk_secret (i.e., has registered offline identity).
  Future<bool> isRegistered(String pubKey) async {
    final secret = await _secureStorage.read(key: _zkSecretKey(pubKey));
    return secret != null;
  }

  /// Load the stored zk_secret for the given account.
  Future<Uint8List?> loadZkSecret(String pubKey) async {
    final key = _zkSecretKey(pubKey);
    Log.d('loadZkSecret: key=$key', _logTarget);
    final encoded = await _secureStorage.read(key: key);
    Log.d('loadZkSecret: found=${encoded != null}', _logTarget);
    if (encoded == null) return null;
    return Uint8List.fromList(List<int>.from(jsonDecode(encoded) as List));
  }

  /// Load the stored genesis hash for the given account's chain.
  Future<Uint8List?> loadGenesisHash(String pubKey) async {
    final encoded = await _secureStorage.read(key: _genesisHashKey(pubKey));
    if (encoded == null) return null;
    return Uint8List.fromList(List<int>.from(jsonDecode(encoded) as List));
  }

  /// Register an offline identity for the current account.
  Future<void> register(BuildContext context) async {
    final store = context.read<AppStore>();
    final pubKey = store.account.currentAccountPubKey;
    if (pubKey == null) {
      Log.e('No current account', _logTarget);
      return;
    }
    Log.d('register: pubKey=$pubKey', _logTarget);

    final keyringAccount = store.account.getKeyringAccount(pubKey);

    // 1. Derive zkSecret from the account's mnemonic/seed
    final seed = Uint8List.fromList(utf8.encode(keyringAccount.uri));
    final zkSecret = ZkProver.deriveZkSecret(seed);
    Log.d('register: derived zkSecret (${zkSecret.length} bytes)', _logTarget);

    // 2. Compute Poseidon commitment
    final commitment = ZkProver.computeCommitment(zkSecret);
    Log.d('register: computed commitment (${commitment.length} bytes)', _logTarget);

    // 3. Store zkSecret and genesis hash first (deterministic, always correct for this account)
    final api = webApi;
    await _secureStorage.write(key: _zkSecretKey(pubKey), value: jsonEncode(zkSecret.toList()));
    final genesisHex = (await api.provider.send('chain_getBlockHash', [0])).result as String;
    final genesisBytes = _hexToBytes(genesisHex.replaceFirst('0x', ''));
    await _secureStorage.write(key: _genesisHashKey(pubKey), value: jsonEncode(genesisBytes.toList()));
    Log.d('register: stored zkSecret and genesis hash', _logTarget);

    // 4. Submit registerOfflineIdentity extrinsic (may fail if already registered — that's OK)
    try {
      final call = api.encointer.encointerKusama.tx.encointerOfflinePayment
          .registerOfflineIdentity(commitment: commitment.toList());
      final xt =
          await TxBuilder(api.provider).createSignedExtrinsicWithEncodedCall(keyringAccount.pair, call.encode());
      final report = await EWAuthorApi(api.provider).submitAndWatchExtrinsicWithReport(OpaqueExtrinsic(xt));
      Log.d('register: extrinsic in block ${report.blockHash}, events: ${report.events.length}', _logTarget);
      if (report.isExtrinsicFailed) {
        Log.e('register: extrinsic failed: ${report.dispatchError}', _logTarget);
      }
    } on Exception catch (e) {
      // Tolerate failures — commitment may already be registered on-chain
      Log.d('register: extrinsic submission failed (may be duplicate): $e', _logTarget);
    }

    // 5. Eagerly cache the proving key while we're still online
    try {
      await loadProvingKey();
    } on Exception catch (e) {
      Log.d('register: could not cache proving key (VK may not be set yet): $e', _logTarget);
    }

    Log.d('register: offline identity registered for $pubKey', _logTarget);
  }

  /// Load the proving key: static cache → secure storage → network fetch + validate.
  ///
  /// The network fetch only happens when online (e.g., during registration).
  /// Once cached in storage, the PK is available offline.
  Future<Uint8List> loadProvingKey() async {
    // 1. Static (in-memory) cache
    if (_cachedProvingKey != null) return _cachedProvingKey!;

    // 2. Secure storage cache
    final stored = await _secureStorage.read(key: _provingKeyStorageKey);
    if (stored != null) {
      _cachedProvingKey = Uint8List.fromList(List<int>.from(jsonDecode(stored) as List));
      Log.d('loadProvingKey: loaded from storage (${_cachedProvingKey!.length} bytes)', _logTarget);
      return _cachedProvingKey!;
    }

    // 3. Fetch VK from chain, generate PK, validate, persist
    final api = webApi;
    final vkBytes = await api.encointer.encointerKusama.query.encointerOfflinePayment.verificationKey();
    if (vkBytes == null) {
      throw StateError('No verification key set on-chain. Set one via set_verification_key first.');
    }
    final onChainVk = Uint8List.fromList(vkBytes);
    Log.d('loadProvingKey: fetched on-chain VK (${onChainVk.length} bytes)', _logTarget);

    // TODO(production): load PK from bundled asset instead of generating.
    final setup = ZkProver.generateTestSetup(0xDEADBEEFCAFEBABE);
    if (!_bytesEqual(setup.verifyingKey, onChainVk)) {
      throw StateError('Generated VK does not match on-chain VK. Wrong trusted setup seed.');
    }

    _cachedProvingKey = setup.provingKey;
    await _secureStorage.write(key: _provingKeyStorageKey, value: jsonEncode(_cachedProvingKey!.toList()));
    Log.d('loadProvingKey: VK validated, PK cached+stored (${_cachedProvingKey!.length} bytes)', _logTarget);
    return _cachedProvingKey!;
  }

  static Uint8List? _cachedProvingKey;

  static bool _bytesEqual(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static Uint8List _hexToBytes(String hex) {
    return Uint8List.fromList(List<int>.generate(hex.length ~/ 2, (i) {
      return int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }));
  }
}
