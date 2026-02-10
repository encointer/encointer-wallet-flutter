// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class Imbalance {
  const Imbalance({required this.amount});

  factory Imbalance.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// B
  final BigInt amount;

  static const $ImbalanceCodec codec = $ImbalanceCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {'amount': amount};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Imbalance && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;
}

class $ImbalanceCodec with _i1.Codec<Imbalance> {
  const $ImbalanceCodec();

  @override
  void encodeTo(
    Imbalance obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
  }

  @override
  Imbalance decode(_i1.Input input) {
    return Imbalance(amount: _i1.U128Codec.codec.decode(input));
  }

  @override
  int sizeHint(Imbalance obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    return size;
  }
}
