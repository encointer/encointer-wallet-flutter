// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../encointer_primitives/communities/community_identifier.dart' as _i2;

class ChargeAssetTxPayment {
  const ChargeAssetTxPayment({
    required this.tip,
    this.assetId,
  });

  factory ChargeAssetTxPayment.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BalanceOf<T>
  final BigInt tip;

  /// Option<ChargeAssetIdOf<T>>
  final _i2.CommunityIdentifier? assetId;

  static const $ChargeAssetTxPaymentCodec codec = $ChargeAssetTxPaymentCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'tip': tip,
        'assetId': assetId?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ChargeAssetTxPayment && other.tip == tip && other.assetId == assetId;

  @override
  int get hashCode => Object.hash(
        tip,
        assetId,
      );
}

class $ChargeAssetTxPaymentCodec with _i1.Codec<ChargeAssetTxPayment> {
  const $ChargeAssetTxPaymentCodec();

  @override
  void encodeTo(
    ChargeAssetTxPayment obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.tip,
      output,
    );
    const _i1.OptionCodec<_i2.CommunityIdentifier>(_i2.CommunityIdentifier.codec).encodeTo(
      obj.assetId,
      output,
    );
  }

  @override
  ChargeAssetTxPayment decode(_i1.Input input) {
    return ChargeAssetTxPayment(
      tip: _i1.CompactBigIntCodec.codec.decode(input),
      assetId: const _i1.OptionCodec<_i2.CommunityIdentifier>(_i2.CommunityIdentifier.codec).decode(input),
    );
  }

  @override
  int sizeHint(ChargeAssetTxPayment obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.tip);
    size = size + const _i1.OptionCodec<_i2.CommunityIdentifier>(_i2.CommunityIdentifier.codec).sizeHint(obj.assetId);
    return size;
  }
}
