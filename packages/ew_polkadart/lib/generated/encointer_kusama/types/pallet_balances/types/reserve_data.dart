// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class ReserveData {
  const ReserveData({
    required this.id,
    required this.amount,
  });

  factory ReserveData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final List<int> id;

  final BigInt amount;

  static const $ReserveDataCodec codec = $ReserveDataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'id': id.toList(),
        'amount': amount,
      };
}

class $ReserveDataCodec with _i1.Codec<ReserveData> {
  const $ReserveDataCodec();

  @override
  void encodeTo(
    ReserveData obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(8).encodeTo(
      obj.id,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
  }

  @override
  ReserveData decode(_i1.Input input) {
    return ReserveData(
      id: const _i1.U8ArrayCodec(8).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ReserveData obj) {
    int size = 0;
    size = size + const _i1.U8ArrayCodec(8).sizeHint(obj.id);
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    return size;
  }
}
