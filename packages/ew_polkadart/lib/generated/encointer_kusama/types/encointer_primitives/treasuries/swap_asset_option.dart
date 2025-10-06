// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_runtime_common/impls/versioned_locatable_asset.dart' as _i3;
import '../../substrate_fixed/fixed_u128.dart' as _i4;
import '../communities/community_identifier.dart' as _i2;

class SwapAssetOption {
  const SwapAssetOption({
    required this.cid,
    required this.assetId,
    required this.assetAllowance,
    this.rate,
    required this.doBurn,
    this.validFrom,
    this.validUntil,
  });

  factory SwapAssetOption.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CommunityIdentifier
  final _i2.CommunityIdentifier cid;

  /// AssetId
  final _i3.VersionedLocatableAsset assetId;

  /// NativeBalance
  final BigInt assetAllowance;

  /// Option<BalanceType>
  final _i4.FixedU128? rate;

  /// bool
  final bool doBurn;

  /// Option<Moment>
  final BigInt? validFrom;

  /// Option<Moment>
  final BigInt? validUntil;

  static const $SwapAssetOptionCodec codec = $SwapAssetOptionCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'cid': cid.toJson(),
        'assetId': assetId.toJson(),
        'assetAllowance': assetAllowance,
        'rate': rate?.toJson(),
        'doBurn': doBurn,
        'validFrom': validFrom,
        'validUntil': validUntil,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapAssetOption &&
          other.cid == cid &&
          other.assetId == assetId &&
          other.assetAllowance == assetAllowance &&
          other.rate == rate &&
          other.doBurn == doBurn &&
          other.validFrom == validFrom &&
          other.validUntil == validUntil;

  @override
  int get hashCode => Object.hash(
        cid,
        assetId,
        assetAllowance,
        rate,
        doBurn,
        validFrom,
        validUntil,
      );
}

class $SwapAssetOptionCodec with _i1.Codec<SwapAssetOption> {
  const $SwapAssetOptionCodec();

  @override
  void encodeTo(
    SwapAssetOption obj,
    _i1.Output output,
  ) {
    _i2.CommunityIdentifier.codec.encodeTo(
      obj.cid,
      output,
    );
    _i3.VersionedLocatableAsset.codec.encodeTo(
      obj.assetId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.assetAllowance,
      output,
    );
    const _i1.OptionCodec<_i4.FixedU128>(_i4.FixedU128.codec).encodeTo(
      obj.rate,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.doBurn,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).encodeTo(
      obj.validFrom,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).encodeTo(
      obj.validUntil,
      output,
    );
  }

  @override
  SwapAssetOption decode(_i1.Input input) {
    return SwapAssetOption(
      cid: _i2.CommunityIdentifier.codec.decode(input),
      assetId: _i3.VersionedLocatableAsset.codec.decode(input),
      assetAllowance: _i1.U128Codec.codec.decode(input),
      rate: const _i1.OptionCodec<_i4.FixedU128>(_i4.FixedU128.codec).decode(input),
      doBurn: _i1.BoolCodec.codec.decode(input),
      validFrom: const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).decode(input),
      validUntil: const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(SwapAssetOption obj) {
    int size = 0;
    size = size + _i2.CommunityIdentifier.codec.sizeHint(obj.cid);
    size = size + _i3.VersionedLocatableAsset.codec.sizeHint(obj.assetId);
    size = size + _i1.U128Codec.codec.sizeHint(obj.assetAllowance);
    size = size + const _i1.OptionCodec<_i4.FixedU128>(_i4.FixedU128.codec).sizeHint(obj.rate);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.doBurn);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).sizeHint(obj.validFrom);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).sizeHint(obj.validUntil);
    return size;
  }
}
