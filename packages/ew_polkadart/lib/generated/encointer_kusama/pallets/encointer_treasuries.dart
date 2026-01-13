// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i9;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i3;
import '../types/encointer_primitives/treasuries/swap_asset_option.dart' as _i6;
import '../types/encointer_primitives/treasuries/swap_native_option.dart' as _i5;
import '../types/frame_support/pallet_id.dart' as _i11;
import '../types/pallet_encointer_treasuries/pallet/call.dart' as _i10;
import '../types/sp_core/crypto/account_id32.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, _i5.SwapNativeOption> _swapNativeOptions =
      const _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, _i5.SwapNativeOption>(
    prefix: 'EncointerTreasuries',
    storage: 'SwapNativeOptions',
    valueCodec: _i5.SwapNativeOption.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, _i6.SwapAssetOption> _swapAssetOptions =
      const _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, _i6.SwapAssetOption>(
    prefix: 'EncointerTreasuries',
    storage: 'SwapAssetOptions',
    valueCodec: _i6.SwapAssetOption.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  _i7.Future<_i5.SwapNativeOption?> swapNativeOptions(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2, {
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

  _i7.Future<_i6.SwapAssetOption?> swapAssetOptions(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _swapAssetOptions.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _swapAssetOptions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `swapNativeOptions`.
  _i8.Uint8List swapNativeOptionsKey(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _swapNativeOptions.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `swapAssetOptions`.
  _i8.Uint8List swapAssetOptionsKey(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _swapAssetOptions.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `swapNativeOptions`.
  _i8.Uint8List swapNativeOptionsMapPrefix(_i3.CommunityIdentifier key1) {
    final hashedKey = _swapNativeOptions.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `swapAssetOptions`.
  _i8.Uint8List swapAssetOptionsMapPrefix(_i3.CommunityIdentifier key1) {
    final hashedKey = _swapAssetOptions.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// swap native tokens for community currency subject to an existing swap option for the
  /// sender account.
  _i9.EncointerTreasuries swapNative({
    required _i3.CommunityIdentifier cid,
    required BigInt desiredNativeAmount,
  }) {
    return _i9.EncointerTreasuries(_i10.SwapNative(
      cid: cid,
      desiredNativeAmount: desiredNativeAmount,
    ));
  }

  /// swap native tokens for community currency subject to an existing swap option for the
  /// sender account.
  _i9.EncointerTreasuries swapAsset({
    required _i3.CommunityIdentifier cid,
    required BigInt desiredAssetAmount,
  }) {
    return _i9.EncointerTreasuries(_i10.SwapAsset(
      cid: cid,
      desiredAssetAmount: desiredAssetAmount,
    ));
  }
}

class Constants {
  Constants();

  /// The treasuries' pallet id, used for deriving sovereign account IDs per community.
  final _i11.PalletId palletId = const <int>[
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
