// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/asset_hub_kusama_runtime/runtime_call.dart' as _i7;
import '../types/frame_support/pallet_id.dart' as _i10;
import '../types/pallet_nft_fractionalization/pallet/call.dart' as _i9;
import '../types/pallet_nft_fractionalization/types/details.dart' as _i3;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;
import '../types/tuples.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Tuple2<int, int>, _i3.Details> _nftToAsset =
      const _i1.StorageMap<_i2.Tuple2<int, int>, _i3.Details>(
    prefix: 'NftFractionalization',
    storage: 'NftToAsset',
    valueCodec: _i3.Details.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.Tuple2Codec<int, int>(
      _i4.U32Codec.codec,
      _i4.U32Codec.codec,
    )),
  );

  /// Keeps track of the corresponding NFT ID, asset ID and amount minted.
  _i5.Future<_i3.Details?> nftToAsset(
    _i2.Tuple2<int, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nftToAsset.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nftToAsset.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Keeps track of the corresponding NFT ID, asset ID and amount minted.
  _i5.Future<List<_i3.Details?>> multiNftToAsset(
    List<_i2.Tuple2<int, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _nftToAsset.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes.map((v) => _nftToAsset.decodeValue(v.key)).toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `nftToAsset`.
  _i6.Uint8List nftToAssetKey(_i2.Tuple2<int, int> key1) {
    final hashedKey = _nftToAsset.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nftToAsset`.
  _i6.Uint8List nftToAssetMapPrefix() {
    final hashedKey = _nftToAsset.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Lock the NFT and mint a new fungible asset.
  ///
  /// The dispatch origin for this call must be Signed.
  /// The origin must be the owner of the NFT they are trying to lock.
  ///
  /// `Deposit` funds of sender are reserved.
  ///
  /// - `nft_collection_id`: The ID used to identify the collection of the NFT.
  /// Is used within the context of `pallet_nfts`.
  /// - `nft_id`: The ID used to identify the NFT within the given collection.
  /// Is used within the context of `pallet_nfts`.
  /// - `asset_id`: The ID of the new asset. It must not exist.
  /// Is used within the context of `pallet_assets`.
  /// - `beneficiary`: The account that will receive the newly created asset.
  /// - `fractions`: The total issuance of the newly created asset class.
  ///
  /// Emits `NftFractionalized` event when successful.
  _i7.NftFractionalization fractionalize({
    required int nftCollectionId,
    required int nftId,
    required int assetId,
    required _i8.MultiAddress beneficiary,
    required BigInt fractions,
  }) {
    return _i7.NftFractionalization(_i9.Fractionalize(
      nftCollectionId: nftCollectionId,
      nftId: nftId,
      assetId: assetId,
      beneficiary: beneficiary,
      fractions: fractions,
    ));
  }

  /// Burn the total issuance of the fungible asset and return (unlock) the locked NFT.
  ///
  /// The dispatch origin for this call must be Signed.
  ///
  /// `Deposit` funds will be returned to `asset_creator`.
  ///
  /// - `nft_collection_id`: The ID used to identify the collection of the NFT.
  /// Is used within the context of `pallet_nfts`.
  /// - `nft_id`: The ID used to identify the NFT within the given collection.
  /// Is used within the context of `pallet_nfts`.
  /// - `asset_id`: The ID of the asset being returned and destroyed. Must match
  /// the original ID of the created asset, corresponding to the NFT.
  /// Is used within the context of `pallet_assets`.
  /// - `beneficiary`: The account that will receive the unified NFT.
  ///
  /// Emits `NftUnified` event when successful.
  _i7.NftFractionalization unify({
    required int nftCollectionId,
    required int nftId,
    required int assetId,
    required _i8.MultiAddress beneficiary,
  }) {
    return _i7.NftFractionalization(_i9.Unify(
      nftCollectionId: nftCollectionId,
      nftId: nftId,
      assetId: assetId,
      beneficiary: beneficiary,
    ));
  }
}

class Constants {
  Constants();

  /// The deposit paid by the user locking an NFT. The deposit is returned to the original NFT
  /// owner when the asset is unified and the NFT is unlocked.
  final BigInt deposit = BigInt.from(6729999930);

  /// The pallet's id, used for deriving its sovereign account ID.
  final _i10.PalletId palletId = const <int>[
    102,
    114,
    97,
    99,
    116,
    105,
    111,
    110,
  ];

  /// The newly created asset's symbol.
  final List<int> newAssetSymbol = const <int>[
    70,
    82,
    65,
    67,
  ];

  /// The newly created asset's name.
  final List<int> newAssetName = const <int>[
    70,
    114,
    97,
    99,
  ];

  /// The maximum length of a name or symbol stored on-chain.
  final int stringLimit = 50;
}
