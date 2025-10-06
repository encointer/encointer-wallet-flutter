// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  NftFractionalized nftFractionalized({
    required int nftCollection,
    required int nft,
    required BigInt fractions,
    required int asset,
    required _i3.AccountId32 beneficiary,
  }) {
    return NftFractionalized(
      nftCollection: nftCollection,
      nft: nft,
      fractions: fractions,
      asset: asset,
      beneficiary: beneficiary,
    );
  }

  NftUnified nftUnified({
    required int nftCollection,
    required int nft,
    required int asset,
    required _i3.AccountId32 beneficiary,
  }) {
    return NftUnified(
      nftCollection: nftCollection,
      nft: nft,
      asset: asset,
      beneficiary: beneficiary,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return NftFractionalized._decode(input);
      case 1:
        return NftUnified._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case NftFractionalized:
        (value as NftFractionalized).encodeTo(output);
        break;
      case NftUnified:
        (value as NftUnified).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case NftFractionalized:
        return (value as NftFractionalized)._sizeHint();
      case NftUnified:
        return (value as NftUnified)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// An NFT was successfully fractionalized.
class NftFractionalized extends Event {
  const NftFractionalized({
    required this.nftCollection,
    required this.nft,
    required this.fractions,
    required this.asset,
    required this.beneficiary,
  });

  factory NftFractionalized._decode(_i1.Input input) {
    return NftFractionalized(
      nftCollection: _i1.U32Codec.codec.decode(input),
      nft: _i1.U32Codec.codec.decode(input),
      fractions: _i1.U128Codec.codec.decode(input),
      asset: _i1.U32Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::NftCollectionId
  final int nftCollection;

  /// T::NftId
  final int nft;

  /// AssetBalanceOf<T>
  final BigInt fractions;

  /// AssetIdOf<T>
  final int asset;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NftFractionalized': {
          'nftCollection': nftCollection,
          'nft': nft,
          'fractions': fractions,
          'asset': asset,
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(nftCollection);
    size = size + _i1.U32Codec.codec.sizeHint(nft);
    size = size + _i1.U128Codec.codec.sizeHint(fractions);
    size = size + _i1.U32Codec.codec.sizeHint(asset);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nftCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nft,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      fractions,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      asset,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is NftFractionalized &&
          other.nftCollection == nftCollection &&
          other.nft == nft &&
          other.fractions == fractions &&
          other.asset == asset &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        nftCollection,
        nft,
        fractions,
        asset,
        beneficiary,
      );
}

/// An NFT was successfully returned back.
class NftUnified extends Event {
  const NftUnified({
    required this.nftCollection,
    required this.nft,
    required this.asset,
    required this.beneficiary,
  });

  factory NftUnified._decode(_i1.Input input) {
    return NftUnified(
      nftCollection: _i1.U32Codec.codec.decode(input),
      nft: _i1.U32Codec.codec.decode(input),
      asset: _i1.U32Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::NftCollectionId
  final int nftCollection;

  /// T::NftId
  final int nft;

  /// AssetIdOf<T>
  final int asset;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NftUnified': {
          'nftCollection': nftCollection,
          'nft': nft,
          'asset': asset,
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(nftCollection);
    size = size + _i1.U32Codec.codec.sizeHint(nft);
    size = size + _i1.U32Codec.codec.sizeHint(asset);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nftCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      nft,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      asset,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is NftUnified &&
          other.nftCollection == nftCollection &&
          other.nft == nft &&
          other.asset == asset &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        nftCollection,
        nft,
        asset,
        beneficiary,
      );
}
