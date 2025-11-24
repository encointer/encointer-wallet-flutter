// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class MintType {
  const MintType();

  factory MintType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $MintTypeCodec codec = $MintTypeCodec();

  static const $MintType values = $MintType();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $MintType {
  const $MintType();

  Issuer issuer() {
    return Issuer();
  }

  Public public() {
    return Public();
  }

  HolderOf holderOf(int value0) {
    return HolderOf(value0);
  }
}

class $MintTypeCodec with _i1.Codec<MintType> {
  const $MintTypeCodec();

  @override
  MintType decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Issuer();
      case 1:
        return const Public();
      case 2:
        return HolderOf._decode(input);
      default:
        throw Exception('MintType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MintType value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Issuer:
        (value as Issuer).encodeTo(output);
        break;
      case Public:
        (value as Public).encodeTo(output);
        break;
      case HolderOf:
        (value as HolderOf).encodeTo(output);
        break;
      default:
        throw Exception('MintType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(MintType value) {
    switch (value.runtimeType) {
      case Issuer:
        return 1;
      case Public:
        return 1;
      case HolderOf:
        return (value as HolderOf)._sizeHint();
      default:
        throw Exception('MintType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Issuer extends MintType {
  const Issuer();

  @override
  Map<String, dynamic> toJson() => {'Issuer': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Issuer;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Public extends MintType {
  const Public();

  @override
  Map<String, dynamic> toJson() => {'Public': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Public;

  @override
  int get hashCode => runtimeType.hashCode;
}

class HolderOf extends MintType {
  const HolderOf(this.value0);

  factory HolderOf._decode(_i1.Input input) {
    return HolderOf(_i1.U32Codec.codec.decode(input));
  }

  /// CollectionId
  final int value0;

  @override
  Map<String, int> toJson() => {'HolderOf': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HolderOf && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
