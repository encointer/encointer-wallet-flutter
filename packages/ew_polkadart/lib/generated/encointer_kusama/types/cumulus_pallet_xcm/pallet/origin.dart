// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../../polkadot_parachain_primitives/primitives/id.dart' as _i3;

abstract class Origin {
  const Origin();

  factory Origin.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $OriginCodec codec = $OriginCodec();

  static const $Origin values = $Origin();

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

class $Origin {
  const $Origin();

  Relay relay() {
    return Relay();
  }

  SiblingParachain siblingParachain(_i3.Id value0) {
    return SiblingParachain(value0);
  }
}

class $OriginCodec with _i1.Codec<Origin> {
  const $OriginCodec();

  @override
  Origin decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Relay();
      case 1:
        return SiblingParachain._decode(input);
      default:
        throw Exception('Origin: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Origin value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Relay:
        (value as Relay).encodeTo(output);
        break;
      case SiblingParachain:
        (value as SiblingParachain).encodeTo(output);
        break;
      default:
        throw Exception('Origin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Origin value) {
    switch (value.runtimeType) {
      case Relay:
        return 1;
      case SiblingParachain:
        return (value as SiblingParachain)._sizeHint();
      default:
        throw Exception('Origin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

class Relay extends Origin {
  const Relay();

  @override
  Map<String, dynamic> toJson() => {'Relay': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Relay;

  @override
  int get hashCode => runtimeType.hashCode;
}

class SiblingParachain extends Origin {
  const SiblingParachain(this.value0);

  factory SiblingParachain._decode(_i1.Input input) {
    return SiblingParachain(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'SiblingParachain': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is SiblingParachain && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
