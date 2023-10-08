// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../../frame_system/limits/weights_per_class.dart' as _i2;
import 'dart:typed_data' as _i3;

class PerDispatchClass {
  const PerDispatchClass({
    required this.normal,
    required this.operational,
    required this.mandatory,
  });

  factory PerDispatchClass.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.WeightsPerClass normal;

  final _i2.WeightsPerClass operational;

  final _i2.WeightsPerClass mandatory;

  static const $PerDispatchClassCodec codec = $PerDispatchClassCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, Map<String, BigInt>?>> toJson() => {
        'normal': normal.toJson(),
        'operational': operational.toJson(),
        'mandatory': mandatory.toJson(),
      };
}

class $PerDispatchClassCodec with _i1.Codec<PerDispatchClass> {
  const $PerDispatchClassCodec();

  @override
  void encodeTo(
    PerDispatchClass obj,
    _i1.Output output,
  ) {
    _i2.WeightsPerClass.codec.encodeTo(
      obj.normal,
      output,
    );
    _i2.WeightsPerClass.codec.encodeTo(
      obj.operational,
      output,
    );
    _i2.WeightsPerClass.codec.encodeTo(
      obj.mandatory,
      output,
    );
  }

  @override
  PerDispatchClass decode(_i1.Input input) {
    return PerDispatchClass(
      normal: _i2.WeightsPerClass.codec.decode(input),
      operational: _i2.WeightsPerClass.codec.decode(input),
      mandatory: _i2.WeightsPerClass.codec.decode(input),
    );
  }

  @override
  int sizeHint(PerDispatchClass obj) {
    int size = 0;
    size = size + _i2.WeightsPerClass.codec.sizeHint(obj.normal);
    size = size + _i2.WeightsPerClass.codec.sizeHint(obj.operational);
    size = size + _i2.WeightsPerClass.codec.sizeHint(obj.mandatory);
    return size;
  }
}