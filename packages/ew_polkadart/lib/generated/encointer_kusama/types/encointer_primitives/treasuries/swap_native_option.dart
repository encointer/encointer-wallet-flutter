// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../../substrate_fixed/fixed_u128.dart' as _i3;
import '../communities/community_identifier.dart' as _i2;

class SwapNativeOption {
  const SwapNativeOption({
    required this.cid,
    required this.nativeAllowance,
    this.rate,
    required this.doBurn,
    this.validFrom,
    this.validUntil,
  });

  factory SwapNativeOption.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CommunityIdentifier
  final _i2.CommunityIdentifier cid;

  /// NativeBalance
  final BigInt nativeAllowance;

  /// Option<BalanceType>
  final _i3.FixedU128? rate;

  /// bool
  final bool doBurn;

  /// Option<Moment>
  final BigInt? validFrom;

  /// Option<Moment>
  final BigInt? validUntil;

  static const $SwapNativeOptionCodec codec = $SwapNativeOptionCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'cid': cid.toJson(),
        'nativeAllowance': nativeAllowance,
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
      other is SwapNativeOption &&
          other.cid == cid &&
          other.nativeAllowance == nativeAllowance &&
          other.rate == rate &&
          other.doBurn == doBurn &&
          other.validFrom == validFrom &&
          other.validUntil == validUntil;

  @override
  int get hashCode => Object.hash(
        cid,
        nativeAllowance,
        rate,
        doBurn,
        validFrom,
        validUntil,
      );
}

class $SwapNativeOptionCodec with _i1.Codec<SwapNativeOption> {
  const $SwapNativeOptionCodec();

  @override
  void encodeTo(
    SwapNativeOption obj,
    _i1.Output output,
  ) {
    _i2.CommunityIdentifier.codec.encodeTo(
      obj.cid,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.nativeAllowance,
      output,
    );
    const _i1.OptionCodec<_i3.FixedU128>(_i3.FixedU128.codec).encodeTo(
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
  SwapNativeOption decode(_i1.Input input) {
    return SwapNativeOption(
      cid: _i2.CommunityIdentifier.codec.decode(input),
      nativeAllowance: _i1.U128Codec.codec.decode(input),
      rate: const _i1.OptionCodec<_i3.FixedU128>(_i3.FixedU128.codec).decode(input),
      doBurn: _i1.BoolCodec.codec.decode(input),
      validFrom: const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).decode(input),
      validUntil: const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(SwapNativeOption obj) {
    int size = 0;
    size = size + _i2.CommunityIdentifier.codec.sizeHint(obj.cid);
    size = size + _i1.U128Codec.codec.sizeHint(obj.nativeAllowance);
    size = size + const _i1.OptionCodec<_i3.FixedU128>(_i3.FixedU128.codec).sizeHint(obj.rate);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.doBurn);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).sizeHint(obj.validFrom);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).sizeHint(obj.validUntil);
    return size;
  }

  @override
  bool isSizeZero() =>
      _i2.CommunityIdentifier.codec.isSizeZero() &&
      _i1.U128Codec.codec.isSizeZero() &&
      const _i1.OptionCodec<_i3.FixedU128>(_i3.FixedU128.codec).isSizeZero() &&
      _i1.BoolCodec.codec.isSizeZero() &&
      const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).isSizeZero() &&
      const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).isSizeZero();
}
