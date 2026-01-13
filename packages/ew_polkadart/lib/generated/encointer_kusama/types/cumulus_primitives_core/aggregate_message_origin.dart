// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../polkadot_parachain_primitives/primitives/id.dart' as _i3;

abstract class AggregateMessageOrigin {
  const AggregateMessageOrigin();

  factory AggregateMessageOrigin.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AggregateMessageOriginCodec codec = $AggregateMessageOriginCodec();

  static const $AggregateMessageOrigin values = $AggregateMessageOrigin();

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

class $AggregateMessageOrigin {
  const $AggregateMessageOrigin();

  Here here() {
    return Here();
  }

  Parent parent() {
    return Parent();
  }

  Sibling sibling(_i3.Id value0) {
    return Sibling(value0);
  }
}

class $AggregateMessageOriginCodec with _i1.Codec<AggregateMessageOrigin> {
  const $AggregateMessageOriginCodec();

  @override
  AggregateMessageOrigin decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Here();
      case 1:
        return const Parent();
      case 2:
        return Sibling._decode(input);
      default:
        throw Exception('AggregateMessageOrigin: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AggregateMessageOrigin value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Here:
        (value as Here).encodeTo(output);
        break;
      case Parent:
        (value as Parent).encodeTo(output);
        break;
      case Sibling:
        (value as Sibling).encodeTo(output);
        break;
      default:
        throw Exception('AggregateMessageOrigin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AggregateMessageOrigin value) {
    switch (value.runtimeType) {
      case Here:
        return 1;
      case Parent:
        return 1;
      case Sibling:
        return (value as Sibling)._sizeHint();
      default:
        throw Exception('AggregateMessageOrigin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

class Here extends AggregateMessageOrigin {
  const Here();

  @override
  Map<String, dynamic> toJson() => {'Here': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Here;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Parent extends AggregateMessageOrigin {
  const Parent();

  @override
  Map<String, dynamic> toJson() => {'Parent': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Parent;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Sibling extends AggregateMessageOrigin {
  const Sibling(this.value0);

  factory Sibling._decode(_i1.Input input) {
    return Sibling(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'Sibling': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
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
      other is Sibling && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
