// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/encointer_node_notee_runtime/runtime_call.dart' as _i7;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i2;
import '../types/encointer_primitives/treasuries/swap_native_option.dart' as _i4;
import '../types/frame_support/pallet_id.dart' as _i9;
import '../types/pallet_encointer_treasuries/pallet/call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i3.AccountId32, _i4.SwapNativeOption> _swapNativeOptions =
      const _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i3.AccountId32, _i4.SwapNativeOption>(
    prefix: 'EncointerTreasuries',
    storage: 'SwapNativeOptions',
    valueCodec: _i4.SwapNativeOption.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i2.CommunityIdentifier.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  _i5.Future<_i4.SwapNativeOption?> swapNativeOptions(
    _i2.CommunityIdentifier key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _swapNativeOptions.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _swapNativeOptions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `swapNativeOptions`.
  _i6.Uint8List swapNativeOptionsKey(
    _i2.CommunityIdentifier key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _swapNativeOptions.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `swapNativeOptions`.
  _i6.Uint8List swapNativeOptionsMapPrefix(_i2.CommunityIdentifier key1) {
    final hashedKey = _swapNativeOptions.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// swap native tokens for community currency subject to an existing swap option for the
  /// sender account.
  _i7.EncointerTreasuries swapNative({
    required _i2.CommunityIdentifier cid,
    required BigInt desiredNativeAmount,
  }) {
    return _i7.EncointerTreasuries(_i8.SwapNative(
      cid: cid,
      desiredNativeAmount: desiredNativeAmount,
    ));
  }
}

class Constants {
  Constants();

  /// The treasuries' pallet id, used for deriving sovereign account IDs per community.
  final _i9.PalletId palletId = const <int>[
    116,
    114,
    115,
    114,
    121,
    115,
    73,
    100,
  ];
}
