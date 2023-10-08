// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

abstract class NetworkId {
  const NetworkId();

  factory NetworkId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $NetworkIdCodec codec = $NetworkIdCodec();

  static const $NetworkId values = $NetworkId();

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

class $NetworkId {
  const $NetworkId();

  Any any() {
    return const Any();
  }

  Named named({required List<int> value0}) {
    return Named(
      value0: value0,
    );
  }

  Polkadot polkadot() {
    return const Polkadot();
  }

  Kusama kusama() {
    return const Kusama();
  }
}

class $NetworkIdCodec with _i1.Codec<NetworkId> {
  const $NetworkIdCodec();

  @override
  NetworkId decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Any();
      case 1:
        return Named._decode(input);
      case 2:
        return const Polkadot();
      case 3:
        return const Kusama();
      default:
        throw Exception('NetworkId: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    NetworkId value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Any:
        (value as Any).encodeTo(output);
        break;
      case Named:
        (value as Named).encodeTo(output);
        break;
      case Polkadot:
        (value as Polkadot).encodeTo(output);
        break;
      case Kusama:
        (value as Kusama).encodeTo(output);
        break;
      default:
        throw Exception(
            'NetworkId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(NetworkId value) {
    switch (value.runtimeType) {
      case Any:
        return 1;
      case Named:
        return (value as Named)._sizeHint();
      case Polkadot:
        return 1;
      case Kusama:
        return 1;
      default:
        throw Exception(
            'NetworkId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Any extends NetworkId {
  const Any();

  @override
  Map<String, dynamic> toJson() => {'Any': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }
}

class Named extends NetworkId {
  const Named({required this.value0});

  factory Named._decode(_i1.Input input) {
    return Named(
      value0: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Named': value0};

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

class Polkadot extends NetworkId {
  const Polkadot();

  @override
  Map<String, dynamic> toJson() => {'Polkadot': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }
}

class Kusama extends NetworkId {
  const Kusama();

  @override
  Map<String, dynamic> toJson() => {'Kusama': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }
}
