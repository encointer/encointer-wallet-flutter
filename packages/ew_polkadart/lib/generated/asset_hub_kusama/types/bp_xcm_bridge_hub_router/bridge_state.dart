// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../sp_arithmetic/fixed_point/fixed_u128.dart' as _i2;

class BridgeState {
  const BridgeState({
    required this.deliveryFeeFactor,
    required this.isCongested,
  });

  factory BridgeState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// FixedU128
  final _i2.FixedU128 deliveryFeeFactor;

  /// bool
  final bool isCongested;

  static const $BridgeStateCodec codec = $BridgeStateCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'deliveryFeeFactor': deliveryFeeFactor,
        'isCongested': isCongested,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BridgeState && other.deliveryFeeFactor == deliveryFeeFactor && other.isCongested == isCongested;

  @override
  int get hashCode => Object.hash(
        deliveryFeeFactor,
        isCongested,
      );
}

class $BridgeStateCodec with _i1.Codec<BridgeState> {
  const $BridgeStateCodec();

  @override
  void encodeTo(
    BridgeState obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.deliveryFeeFactor,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.isCongested,
      output,
    );
  }

  @override
  BridgeState decode(_i1.Input input) {
    return BridgeState(
      deliveryFeeFactor: _i1.U128Codec.codec.decode(input),
      isCongested: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(BridgeState obj) {
    int size = 0;
    size = size + const _i2.FixedU128Codec().sizeHint(obj.deliveryFeeFactor);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.isCongested);
    return size;
  }
}
