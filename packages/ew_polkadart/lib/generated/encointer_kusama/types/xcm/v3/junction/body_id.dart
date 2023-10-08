// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

abstract class BodyId {
  const BodyId();

  factory BodyId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $BodyIdCodec codec = $BodyIdCodec();

  static const $BodyId values = $BodyId();

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

class $BodyId {
  const $BodyId();

  Unit unit() {
    return const Unit();
  }

  Moniker moniker({required List<int> value0}) {
    return Moniker(
      value0: value0,
    );
  }

  Index index({required BigInt value0}) {
    return Index(
      value0: value0,
    );
  }

  Executive executive() {
    return const Executive();
  }

  Technical technical() {
    return const Technical();
  }

  Legislative legislative() {
    return const Legislative();
  }

  Judicial judicial() {
    return const Judicial();
  }

  Defense defense() {
    return const Defense();
  }

  Administration administration() {
    return const Administration();
  }

  Treasury treasury() {
    return const Treasury();
  }
}

class $BodyIdCodec with _i1.Codec<BodyId> {
  const $BodyIdCodec();

  @override
  BodyId decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Unit();
      case 1:
        return Moniker._decode(input);
      case 2:
        return Index._decode(input);
      case 3:
        return const Executive();
      case 4:
        return const Technical();
      case 5:
        return const Legislative();
      case 6:
        return const Judicial();
      case 7:
        return const Defense();
      case 8:
        return const Administration();
      case 9:
        return const Treasury();
      default:
        throw Exception('BodyId: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    BodyId value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Unit:
        (value as Unit).encodeTo(output);
        break;
      case Moniker:
        (value as Moniker).encodeTo(output);
        break;
      case Index:
        (value as Index).encodeTo(output);
        break;
      case Executive:
        (value as Executive).encodeTo(output);
        break;
      case Technical:
        (value as Technical).encodeTo(output);
        break;
      case Legislative:
        (value as Legislative).encodeTo(output);
        break;
      case Judicial:
        (value as Judicial).encodeTo(output);
        break;
      case Defense:
        (value as Defense).encodeTo(output);
        break;
      case Administration:
        (value as Administration).encodeTo(output);
        break;
      case Treasury:
        (value as Treasury).encodeTo(output);
        break;
      default:
        throw Exception('BodyId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(BodyId value) {
    switch (value.runtimeType) {
      case Unit:
        return 1;
      case Moniker:
        return (value as Moniker)._sizeHint();
      case Index:
        return (value as Index)._sizeHint();
      case Executive:
        return 1;
      case Technical:
        return 1;
      case Legislative:
        return 1;
      case Judicial:
        return 1;
      case Defense:
        return 1;
      case Administration:
        return 1;
      case Treasury:
        return 1;
      default:
        throw Exception('BodyId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Unit extends BodyId {
  const Unit();

  @override
  Map<String, dynamic> toJson() => {'Unit': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }
}

class Moniker extends BodyId {
  const Moniker({required this.value0});

  factory Moniker._decode(_i1.Input input) {
    return Moniker(
      value0: const _i1.U8ArrayCodec(4).decode(input),
    );
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Moniker': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(4).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(4).encodeTo(
      value0,
      output,
    );
  }
}

class Index extends BodyId {
  const Index({required this.value0});

  factory Index._decode(_i1.Input input) {
    return Index(
      value0: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Index': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Executive extends BodyId {
  const Executive();

  @override
  Map<String, dynamic> toJson() => {'Executive': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }
}

class Technical extends BodyId {
  const Technical();

  @override
  Map<String, dynamic> toJson() => {'Technical': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }
}

class Legislative extends BodyId {
  const Legislative();

  @override
  Map<String, dynamic> toJson() => {'Legislative': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }
}

class Judicial extends BodyId {
  const Judicial();

  @override
  Map<String, dynamic> toJson() => {'Judicial': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }
}

class Defense extends BodyId {
  const Defense();

  @override
  Map<String, dynamic> toJson() => {'Defense': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }
}

class Administration extends BodyId {
  const Administration();

  @override
  Map<String, dynamic> toJson() => {'Administration': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }
}

class Treasury extends BodyId {
  const Treasury();

  @override
  Map<String, dynamic> toJson() => {'Treasury': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
  }
}
