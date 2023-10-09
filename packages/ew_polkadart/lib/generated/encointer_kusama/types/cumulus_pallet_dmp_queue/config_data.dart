// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../sp_weights/weight_v2/weight.dart' as _i2;

class ConfigData {
  const ConfigData({required this.maxIndividual});

  factory ConfigData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Weight
  final _i2.Weight maxIndividual;

  static const $ConfigDataCodec codec = $ConfigDataCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, BigInt>> toJson() => {'maxIndividual': maxIndividual.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ConfigData && other.maxIndividual == maxIndividual;

  @override
  int get hashCode => maxIndividual.hashCode;
}

class $ConfigDataCodec with _i1.Codec<ConfigData> {
  const $ConfigDataCodec();

  @override
  void encodeTo(
    ConfigData obj,
    _i1.Output output,
  ) {
    _i2.Weight.codec.encodeTo(
      obj.maxIndividual,
      output,
    );
  }

  @override
  ConfigData decode(_i1.Input input) {
    return ConfigData(maxIndividual: _i2.Weight.codec.decode(input));
  }

  @override
  int sizeHint(ConfigData obj) {
    int size = 0;
    size = size + _i2.Weight.codec.sizeHint(obj.maxIndividual);
    return size;
  }
}
