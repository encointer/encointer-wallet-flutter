// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i5;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i8;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i9;
import '../types/encointer_primitives/faucet/faucet.dart' as _i4;
import '../types/frame_support/pallet_id.dart' as _i11;
import '../types/pallet_encointer_faucet/pallet/call.dart' as _i10;
import '../types/sp_core/crypto/account_id32.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<_i3.AccountId32, _i4.Faucet> _faucets = const _i2.StorageMap<_i3.AccountId32, _i4.Faucet>(
    prefix: 'EncointerFaucet',
    storage: 'Faucets',
    valueCodec: _i4.Faucet.codec,
    hasher: _i2.StorageHasher.identity(_i3.AccountId32Codec()),
  );

  final _i2.StorageValue<BigInt> _reserveAmount = const _i2.StorageValue<BigInt>(
    prefix: 'EncointerFaucet',
    storage: 'ReserveAmount',
    valueCodec: _i5.U128Codec.codec,
  );

  _i6.Future<_i4.Faucet?> faucets(
    _i3.AccountId32 key1, {
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

  _i6.Future<BigInt> reserveAmount({_i1.BlockHash? at}) async {
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

  _i6.Future<List<_i4.Faucet?>> multiFaucets(
    List<_i3.AccountId32> keys, {
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
  _i7.Uint8List faucetsKey(_i3.AccountId32 key1) {
    final hashedKey = _faucets.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `reserveAmount`.
  _i7.Uint8List reserveAmountKey() {
    final hashedKey = _reserveAmount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `faucets`.
  _i7.Uint8List faucetsMapPrefix() {
    final hashedKey = _faucets.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i8.EncointerFaucet createFaucet({
    required List<int> name,
    required BigInt amount,
    List<_i9.CommunityIdentifier>? whitelist,
    required BigInt dripAmount,
  }) {
    return _i8.EncointerFaucet(_i10.CreateFaucet(
      name: name,
      amount: amount,
      whitelist: whitelist,
      dripAmount: dripAmount,
    ));
  }

  _i8.EncointerFaucet drip({
    required _i3.AccountId32 faucetAccount,
    required _i9.CommunityIdentifier cid,
    required int cindex,
  }) {
    return _i8.EncointerFaucet(_i10.Drip(
      faucetAccount: faucetAccount,
      cid: cid,
      cindex: cindex,
    ));
  }

  _i8.EncointerFaucet dissolveFaucet({
    required _i3.AccountId32 faucetAccount,
    required _i3.AccountId32 beneficiary,
  }) {
    return _i8.EncointerFaucet(_i10.DissolveFaucet(
      faucetAccount: faucetAccount,
      beneficiary: beneficiary,
    ));
  }

  _i8.EncointerFaucet closeFaucet({required _i3.AccountId32 faucetAccount}) {
    return _i8.EncointerFaucet(_i10.CloseFaucet(faucetAccount: faucetAccount));
  }

  _i8.EncointerFaucet setReserveAmount({required BigInt reserveAmount}) {
    return _i8.EncointerFaucet(_i10.SetReserveAmount(reserveAmount: reserveAmount));
  }
}

class Constants {
  Constants();

  /// The treasury's pallet id, used for deriving its sovereign account ID.
  final _i11.PalletId palletId = const <int>[
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
