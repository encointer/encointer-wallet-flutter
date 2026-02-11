// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i7;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i8;
import '../types/encointer_primitives/faucet/faucet.dart' as _i3;
import '../types/frame_support/pallet_id.dart' as _i10;
import '../types/pallet_encointer_faucet/pallet/call.dart' as _i9;
import '../types/sp_core/crypto/account_id32.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32, _i3.Faucet> _faucets = const _i1.StorageMap<_i2.AccountId32, _i3.Faucet>(
    prefix: 'EncointerFaucet',
    storage: 'Faucets',
    valueCodec: _i3.Faucet.codec,
    hasher: _i1.StorageHasher.identity(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<BigInt> _reserveAmount = const _i1.StorageValue<BigInt>(
    prefix: 'EncointerFaucet',
    storage: 'ReserveAmount',
    valueCodec: _i4.U128Codec.codec,
  );

  _i5.Future<_i3.Faucet?> faucets(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _faucets.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _faucets.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i5.Future<BigInt> reserveAmount({_i1.BlockHash? at}) async {
    final hashedKey = _reserveAmount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reserveAmount.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i5.Future<List<_i3.Faucet?>> multiFaucets(
    List<_i2.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _faucets.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _faucets.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `faucets`.
  _i6.Uint8List faucetsKey(_i2.AccountId32 key1) {
    final hashedKey = _faucets.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `reserveAmount`.
  _i6.Uint8List reserveAmountKey() {
    final hashedKey = _reserveAmount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `faucets`.
  _i6.Uint8List faucetsMapPrefix() {
    final hashedKey = _faucets.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i7.EncointerFaucet createFaucet({
    required List<int> name,
    required BigInt amount,
    List<_i8.CommunityIdentifier>? whitelist,
    required BigInt dripAmount,
  }) {
    return _i7.EncointerFaucet(_i9.CreateFaucet(
      name: name,
      amount: amount,
      whitelist: whitelist,
      dripAmount: dripAmount,
    ));
  }

  _i7.EncointerFaucet drip({
    required _i2.AccountId32 faucetAccount,
    required _i8.CommunityIdentifier cid,
    required int cindex,
  }) {
    return _i7.EncointerFaucet(_i9.Drip(
      faucetAccount: faucetAccount,
      cid: cid,
      cindex: cindex,
    ));
  }

  _i7.EncointerFaucet dissolveFaucet({
    required _i2.AccountId32 faucetAccount,
    required _i2.AccountId32 beneficiary,
  }) {
    return _i7.EncointerFaucet(_i9.DissolveFaucet(
      faucetAccount: faucetAccount,
      beneficiary: beneficiary,
    ));
  }

  _i7.EncointerFaucet closeFaucet({required _i2.AccountId32 faucetAccount}) {
    return _i7.EncointerFaucet(_i9.CloseFaucet(faucetAccount: faucetAccount));
  }

  _i7.EncointerFaucet setReserveAmount({required BigInt reserveAmount}) {
    return _i7.EncointerFaucet(_i9.SetReserveAmount(reserveAmount: reserveAmount));
  }
}

class Constants {
  Constants();

  /// The treasury's pallet id, used for deriving its sovereign account ID.
  final _i10.PalletId palletId = const <int>[
    101,
    99,
    116,
    114,
    102,
    99,
    116,
    48,
  ];
}
