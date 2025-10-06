// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class DestroyWitness {
  const DestroyWitness({
    required this.itemMetadatas,
    required this.itemConfigs,
    required this.attributes,
  });

  factory DestroyWitness.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final BigInt itemMetadatas;

  /// u32
  final BigInt itemConfigs;

  /// u32
  final BigInt attributes;

  static const $DestroyWitnessCodec codec = $DestroyWitnessCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'itemMetadatas': itemMetadatas,
        'itemConfigs': itemConfigs,
        'attributes': attributes,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DestroyWitness &&
          other.itemMetadatas == itemMetadatas &&
          other.itemConfigs == itemConfigs &&
          other.attributes == attributes;

  @override
  int get hashCode => Object.hash(
        itemMetadatas,
        itemConfigs,
        attributes,
      );
}

class $DestroyWitnessCodec with _i1.Codec<DestroyWitness> {
  const $DestroyWitnessCodec();

  @override
  void encodeTo(
    DestroyWitness obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.itemMetadatas,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.itemConfigs,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.attributes,
      output,
    );
  }

  @override
  DestroyWitness decode(_i1.Input input) {
    return DestroyWitness(
      itemMetadatas: _i1.CompactBigIntCodec.codec.decode(input),
      itemConfigs: _i1.CompactBigIntCodec.codec.decode(input),
      attributes: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(DestroyWitness obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.itemMetadatas);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.itemConfigs);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.attributes);
    return size;
  }
}
