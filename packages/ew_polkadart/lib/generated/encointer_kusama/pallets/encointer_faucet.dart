// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/encointer_primitives/faucet/faucet.dart' as _i3;
import '../types/frame_support/pallet_id.dart' as _i6;
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
}

class Constants {
  Constants();

  final _i6.PalletId palletId = const <int>[
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
