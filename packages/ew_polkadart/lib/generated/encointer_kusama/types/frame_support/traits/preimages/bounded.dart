// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../../primitive_types/h256.dart' as _i3;

abstract class Bounded {
  const Bounded();

  factory Bounded.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $BoundedCodec codec = $BoundedCodec();

  static const $Bounded values = $Bounded();

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

class $Bounded {
  const $Bounded();

  Legacy legacy({required _i3.H256 hash}) {
    return Legacy(
      hash: hash,
    );
  }

  Inline inline({required List<int> value0}) {
    return Inline(
      value0: value0,
    );
  }

  Lookup lookup({
    required _i3.H256 hash,
    required int len,
  }) {
    return Lookup(
      hash: hash,
      len: len,
    );
  }
}

class $BoundedCodec with _i1.Codec<Bounded> {
  const $BoundedCodec();

  @override
  Bounded decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Legacy._decode(input);
      case 1:
        return Inline._decode(input);
      case 2:
        return Lookup._decode(input);
      default:
        throw Exception('Bounded: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Bounded value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Legacy:
        (value as Legacy).encodeTo(output);
        break;
      case Inline:
        (value as Inline).encodeTo(output);
        break;
      case Lookup:
        (value as Lookup).encodeTo(output);
        break;
      default:
        throw Exception(
            'Bounded: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Bounded value) {
    switch (value.runtimeType) {
      case Legacy:
        return (value as Legacy)._sizeHint();
      case Inline:
        return (value as Inline)._sizeHint();
      case Lookup:
        return (value as Lookup)._sizeHint();
      default:
        throw Exception(
            'Bounded: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Legacy extends Bounded {
  const Legacy({required this.hash});

  factory Legacy._decode(_i1.Input input) {
    return Legacy(
      hash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Legacy': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }
}

class Inline extends Bounded {
  const Inline({required this.value0});

  factory Inline._decode(_i1.Input input) {
    return Inline(
      value0: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Inline': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Lookup extends Bounded {
  const Lookup({
    required this.hash,
    required this.len,
  });

  factory Lookup._decode(_i1.Input input) {
    return Lookup(
      hash: const _i1.U8ArrayCodec(32).decode(input),
      len: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.H256 hash;

  final int len;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Lookup': {
          'hash': hash.toList(),
          'len': len,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(hash);
    size = size + _i1.U32Codec.codec.sizeHint(len);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      len,
      output,
    );
  }
}
