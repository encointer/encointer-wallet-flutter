// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../../sp_weights/weight_v2/weight.dart' as _i3;
import 'error.dart' as _i4;

abstract class Outcome {
  const Outcome();

  factory Outcome.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $OutcomeCodec codec = $OutcomeCodec();

  static const $Outcome values = $Outcome();

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

class $Outcome {
  const $Outcome();

  Complete complete({required _i3.Weight value0}) {
    return Complete(
      value0: value0,
    );
  }

  Incomplete incomplete({
    required _i3.Weight value0,
    required _i4.Error value1,
  }) {
    return Incomplete(
      value0: value0,
      value1: value1,
    );
  }

  Error error({required _i4.Error value0}) {
    return Error(
      value0: value0,
    );
  }
}

class $OutcomeCodec with _i1.Codec<Outcome> {
  const $OutcomeCodec();

  @override
  Outcome decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Complete._decode(input);
      case 1:
        return Incomplete._decode(input);
      case 2:
        return Error._decode(input);
      default:
        throw Exception('Outcome: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Outcome value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Complete:
        (value as Complete).encodeTo(output);
        break;
      case Incomplete:
        (value as Incomplete).encodeTo(output);
        break;
      case Error:
        (value as Error).encodeTo(output);
        break;
      default:
        throw Exception('Outcome: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Outcome value) {
    switch (value.runtimeType) {
      case Complete:
        return (value as Complete)._sizeHint();
      case Incomplete:
        return (value as Incomplete)._sizeHint();
      case Error:
        return (value as Error)._sizeHint();
      default:
        throw Exception('Outcome: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Complete extends Outcome {
  const Complete({required this.value0});

  factory Complete._decode(_i1.Input input) {
    return Complete(
      value0: _i3.Weight.codec.decode(input),
    );
  }

  final _i3.Weight value0;

  @override
  Map<String, Map<String, BigInt>> toJson() => {'Complete': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Weight.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Incomplete extends Outcome {
  const Incomplete({
    required this.value0,
    required this.value1,
  });

  factory Incomplete._decode(_i1.Input input) {
    return Incomplete(
      value0: _i3.Weight.codec.decode(input),
      value1: _i4.Error.codec.decode(input),
    );
  }

  final _i3.Weight value0;

  final _i4.Error value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'Incomplete': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(value0);
    size = size + _i4.Error.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.Weight.codec.encodeTo(
      value0,
      output,
    );
    _i4.Error.codec.encodeTo(
      value1,
      output,
    );
  }
}

class Error extends Outcome {
  const Error({required this.value0});

  factory Error._decode(_i1.Input input) {
    return Error(
      value0: _i4.Error.codec.decode(input),
    );
  }

  final _i4.Error value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Error': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i4.Error.codec.encodeTo(
      value0,
      output,
    );
  }
}
