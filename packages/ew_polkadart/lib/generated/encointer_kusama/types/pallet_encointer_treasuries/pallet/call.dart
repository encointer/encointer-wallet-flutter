// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../../encointer_primitives/communities/community_identifier.dart' as _i3;

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

  SwapNative swapNative({
    required _i3.CommunityIdentifier cid,
    required BigInt desiredNativeAmount,
  }) {
    return SwapNative(
      cid: cid,
      desiredNativeAmount: desiredNativeAmount,
    );
  }

  SwapAsset swapAsset({
    required _i3.CommunityIdentifier cid,
    required BigInt desiredAssetAmount,
  }) {
    return SwapAsset(
      cid: cid,
      desiredAssetAmount: desiredAssetAmount,
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
        return SwapNative._decode(input);
      case 1:
        return SwapAsset._decode(input);
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
      case SwapNative:
        (value as SwapNative).encodeTo(output);
        break;
      case SwapAsset:
        (value as SwapAsset).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SwapNative:
        return (value as SwapNative)._sizeHint();
      case SwapAsset:
        return (value as SwapAsset)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

/// swap native tokens for community currency subject to an existing swap option for the
/// sender account.
class SwapNative extends Call {
  const SwapNative({
    required this.cid,
    required this.desiredNativeAmount,
  });

  factory SwapNative._decode(_i1.Input input) {
    return SwapNative(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      desiredNativeAmount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier cid;

  /// BalanceOf<T>
  final BigInt desiredNativeAmount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'swap_native': {
          'cid': cid.toJson(),
          'desiredNativeAmount': desiredNativeAmount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U128Codec.codec.sizeHint(desiredNativeAmount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      desiredNativeAmount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapNative && other.cid == cid && other.desiredNativeAmount == desiredNativeAmount;

  @override
  int get hashCode => Object.hash(
        cid,
        desiredNativeAmount,
      );
}

/// swap native tokens for community currency subject to an existing swap option for the
/// sender account.
class SwapAsset extends Call {
  const SwapAsset({
    required this.cid,
    required this.desiredAssetAmount,
  });

  factory SwapAsset._decode(_i1.Input input) {
    return SwapAsset(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      desiredAssetAmount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier cid;

  /// BalanceOf<T>
  final BigInt desiredAssetAmount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'swap_asset': {
          'cid': cid.toJson(),
          'desiredAssetAmount': desiredAssetAmount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U128Codec.codec.sizeHint(desiredAssetAmount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      desiredAssetAmount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SwapAsset && other.cid == cid && other.desiredAssetAmount == desiredAssetAmount;

  @override
  int get hashCode => Object.hash(
        cid,
        desiredAssetAmount,
      );
}
