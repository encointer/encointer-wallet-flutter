// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'price_direction.dart' as _i2;

class PriceWithDirection {
  const PriceWithDirection({
    required this.amount,
    required this.direction,
  });

  factory PriceWithDirection.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Amount
  final BigInt amount;

  /// PriceDirection
  final _i2.PriceDirection direction;

  static const $PriceWithDirectionCodec codec = $PriceWithDirectionCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'direction': direction.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PriceWithDirection && other.amount == amount && other.direction == direction;

  @override
  int get hashCode => Object.hash(
        amount,
        direction,
      );
}

class $PriceWithDirectionCodec with _i1.Codec<PriceWithDirection> {
  const $PriceWithDirectionCodec();

  @override
  void encodeTo(
    PriceWithDirection obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
    _i2.PriceDirection.codec.encodeTo(
      obj.direction,
      output,
    );
  }

  @override
  PriceWithDirection decode(_i1.Input input) {
    return PriceWithDirection(
      amount: _i1.U128Codec.codec.decode(input),
      direction: _i2.PriceDirection.codec.decode(input),
    );
  }

  @override
  int sizeHint(PriceWithDirection obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    size = size + _i2.PriceDirection.codec.sizeHint(obj.direction);
    return size;
  }
}
