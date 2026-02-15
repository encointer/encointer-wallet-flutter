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

    // 3. Build and submit registerOfflineIdentity extrinsic
    final api = webApi;
    final call = api.encointer.encointerKusama.tx.encointerOfflinePayment
        .registerOfflineIdentity(commitment: commitment.toList());

    final xt = await TxBuilder(api.provider).createSignedExtrinsicWithEncodedCall(keyringAccount.pair, call.encode());

    final report = await EWAuthorApi(api.provider).submitAndWatchExtrinsicWithReport(OpaqueExtrinsic(xt));
    Log.d('register: extrinsic in block ${report.blockHash}, events: ${report.events.length}', _logTarget);

    if (report.isExtrinsicFailed) {
      Log.e('register: extrinsic failed: ${report.dispatchError}', _logTarget);
      throw StateError('Offline identity registration failed on-chain');
    }

    // 4. Store zkSecret in SecureStorage
    final secretKey = _zkSecretKey(pubKey);
    Log.d('register: storing zkSecret with key=$secretKey', _logTarget);
    await _secureStorage.write(key: secretKey, value: jsonEncode(zkSecret.toList()));

    // 5. Fetch and store genesis hash for cross-chain replay protection
    final genesisHex = (await api.provider.send('chain_getBlockHash', [0])).result as String;
    final genesisBytes = _hexToBytes(genesisHex.replaceFirst('0x', ''));
    await _secureStorage.write(key: _genesisHashKey(pubKey), value: jsonEncode(genesisBytes.toList()));

    // Verify storage
    final stored = await _secureStorage.read(key: secretKey);
    Log.d('register: verify stored=${stored != null}, key=$secretKey', _logTarget);

    Log.d('register: offline identity registered for $pubKey', _logTarget);
  }

  static Uint8List _hexToBytes(String hex) {
    return Uint8List.fromList(List<int>.generate(hex.length ~/ 2, (i) {
      return int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }));
  }
}
