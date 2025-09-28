// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  Fractionalize fractionalize({
    required int nftCollectionId,
    required int nftId,
    required int assetId,
    required _i3.MultiAddress beneficiary,
    required BigInt fractions,
  }) {
    return Fractionalize(
      nftCollectionId: nftCollectionId,
      nftId: nftId,
      assetId: assetId,
      beneficiary: beneficiary,
      fractions: fractions,
    );
  }

  Unify unify({
    required int nftCollectionId,
    required int nftId,
    required int assetId,
    required _i3.MultiAddress beneficiary,
  }) {
    return Unify(
      nftCollectionId: nftCollectionId,
      nftId: nftId,
      assetId: assetId,
      beneficiary: beneficiary,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Fractionalize._decode(input);
      case 1:
        return Unify._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Fractionalize:
        (value as Fractionalize).encodeTo(output);
        break;
      case Unify:
        (value as Unify).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Fractionalize:
        return (value as Fractionalize)._sizeHint();
      case Unify:
        return (value as Unify)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

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
class Fractionalize extends Call {
  const Fractionalize({
    required this.nftCollectionId,
    required this.nftId,
    required this.assetId,
    required this.beneficiary,
    required this.fractions,
  });

  factory Fractionalize._decode(_i1.Input input) {
    return Fractionalize(
      nftCollectionId: _i1.U32Codec.codec.decode(input),
      nftId: _i1.U32Codec.codec.decode(input),
      assetId: _i1.U32Codec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
      fractions: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::NftCollectionId
  final int nftCollectionId;

  /// T::NftId
  final int nftId;

  /// AssetIdOf<T>
  final int assetId;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  /// AssetBalanceOf<T>
  final BigInt fractions;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'fractionalize': {
          'nftCollectionId': nftCollectionId,
          'nftId': nftId,
          'assetId': assetId,
          'beneficiary': beneficiary.toJson(),
          'fractions': fractions,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(nftCollectionId);
    size = size + _i1.U32Codec.codec.sizeHint(nftId);
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    size = size + _i1.U128Codec.codec.sizeHint(fractions);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nftCollectionId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nftId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      beneficiary,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      fractions,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Fractionalize &&
          other.nftCollectionId == nftCollectionId &&
          other.nftId == nftId &&
          other.assetId == assetId &&
          other.beneficiary == beneficiary &&
          other.fractions == fractions;

  @override
  int get hashCode => Object.hash(
        nftCollectionId,
        nftId,
        assetId,
        beneficiary,
        fractions,
      );
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
class Unify extends Call {
  const Unify({
    required this.nftCollectionId,
    required this.nftId,
    required this.assetId,
    required this.beneficiary,
  });

  factory Unify._decode(_i1.Input input) {
    return Unify(
      nftCollectionId: _i1.U32Codec.codec.decode(input),
      nftId: _i1.U32Codec.codec.decode(input),
      assetId: _i1.U32Codec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::NftCollectionId
  final int nftCollectionId;

  /// T::NftId
  final int nftId;

  /// AssetIdOf<T>
  final int assetId;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'unify': {
          'nftCollectionId': nftCollectionId,
          'nftId': nftId,
          'assetId': assetId,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(nftCollectionId);
    size = size + _i1.U32Codec.codec.sizeHint(nftId);
    size = size + _i1.U32Codec.codec.sizeHint(assetId);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nftCollectionId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nftId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      assetId,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Unify &&
          other.nftCollectionId == nftCollectionId &&
          other.nftId == nftId &&
          other.assetId == assetId &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        nftCollectionId,
        nftId,
        assetId,
        beneficiary,
      );
}
