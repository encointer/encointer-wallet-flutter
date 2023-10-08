// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class AssignmentParams {
  const AssignmentParams({
    required this.m,
    required this.s1,
    required this.s2,
  });

  factory AssignmentParams.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt m;

  final BigInt s1;

  final BigInt s2;

  static const $AssignmentParamsCodec codec = $AssignmentParamsCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'm': m,
        's1': s1,
        's2': s2,
      };
}

class $AssignmentParamsCodec with _i1.Codec<AssignmentParams> {
  const $AssignmentParamsCodec();

  @override
  void encodeTo(
    AssignmentParams obj,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      obj.m,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.s1,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.s2,
      output,
    );
  }

  @override
  AssignmentParams decode(_i1.Input input) {
    return AssignmentParams(
      m: _i1.U64Codec.codec.decode(input),
      s1: _i1.U64Codec.codec.decode(input),
      s2: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AssignmentParams obj) {
    int size = 0;
    size = size + _i1.U64Codec.codec.sizeHint(obj.m);
    size = size + _i1.U64Codec.codec.sizeHint(obj.s1);
    size = size + _i1.U64Codec.codec.sizeHint(obj.s2);
    return size;
  }
}
