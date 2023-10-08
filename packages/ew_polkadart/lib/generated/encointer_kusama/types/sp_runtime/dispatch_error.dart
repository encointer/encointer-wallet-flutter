// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import 'module_error.dart' as _i3;
import 'token_error.dart' as _i4;
import '../sp_arithmetic/arithmetic_error.dart' as _i5;
import 'transactional_error.dart' as _i6;

abstract class DispatchError {
  const DispatchError();

  factory DispatchError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $DispatchErrorCodec codec = $DispatchErrorCodec();

  static const $DispatchError values = $DispatchError();

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

class $DispatchError {
  const $DispatchError();

  Other other() {
    return const Other();
  }

  CannotLookup cannotLookup() {
    return const CannotLookup();
  }

  BadOrigin badOrigin() {
    return const BadOrigin();
  }

  Module module({required _i3.ModuleError value0}) {
    return Module(
      value0: value0,
    );
  }

  ConsumerRemaining consumerRemaining() {
    return const ConsumerRemaining();
  }

  NoProviders noProviders() {
    return const NoProviders();
  }

  TooManyConsumers tooManyConsumers() {
    return const TooManyConsumers();
  }

  Token token({required _i4.TokenError value0}) {
    return Token(
      value0: value0,
    );
  }

  Arithmetic arithmetic({required _i5.ArithmeticError value0}) {
    return Arithmetic(
      value0: value0,
    );
  }

  Transactional transactional({required _i6.TransactionalError value0}) {
    return Transactional(
      value0: value0,
    );
  }

  Exhausted exhausted() {
    return const Exhausted();
  }

  Corruption corruption() {
    return const Corruption();
  }

  Unavailable unavailable() {
    return const Unavailable();
  }

  RootNotAllowed rootNotAllowed() {
    return const RootNotAllowed();
  }
}

class $DispatchErrorCodec with _i1.Codec<DispatchError> {
  const $DispatchErrorCodec();

  @override
  DispatchError decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Other();
      case 1:
        return const CannotLookup();
      case 2:
        return const BadOrigin();
      case 3:
        return Module._decode(input);
      case 4:
        return const ConsumerRemaining();
      case 5:
        return const NoProviders();
      case 6:
        return const TooManyConsumers();
      case 7:
        return Token._decode(input);
      case 8:
        return Arithmetic._decode(input);
      case 9:
        return Transactional._decode(input);
      case 10:
        return const Exhausted();
      case 11:
        return const Corruption();
      case 12:
        return const Unavailable();
      case 13:
        return const RootNotAllowed();
      default:
        throw Exception('DispatchError: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    DispatchError value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Other:
        (value as Other).encodeTo(output);
        break;
      case CannotLookup:
        (value as CannotLookup).encodeTo(output);
        break;
      case BadOrigin:
        (value as BadOrigin).encodeTo(output);
        break;
      case Module:
        (value as Module).encodeTo(output);
        break;
      case ConsumerRemaining:
        (value as ConsumerRemaining).encodeTo(output);
        break;
      case NoProviders:
        (value as NoProviders).encodeTo(output);
        break;
      case TooManyConsumers:
        (value as TooManyConsumers).encodeTo(output);
        break;
      case Token:
        (value as Token).encodeTo(output);
        break;
      case Arithmetic:
        (value as Arithmetic).encodeTo(output);
        break;
      case Transactional:
        (value as Transactional).encodeTo(output);
        break;
      case Exhausted:
        (value as Exhausted).encodeTo(output);
        break;
      case Corruption:
        (value as Corruption).encodeTo(output);
        break;
      case Unavailable:
        (value as Unavailable).encodeTo(output);
        break;
      case RootNotAllowed:
        (value as RootNotAllowed).encodeTo(output);
        break;
      default:
        throw Exception(
            'DispatchError: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(DispatchError value) {
    switch (value.runtimeType) {
      case Other:
        return 1;
      case CannotLookup:
        return 1;
      case BadOrigin:
        return 1;
      case Module:
        return (value as Module)._sizeHint();
      case ConsumerRemaining:
        return 1;
      case NoProviders:
        return 1;
      case TooManyConsumers:
        return 1;
      case Token:
        return (value as Token)._sizeHint();
      case Arithmetic:
        return (value as Arithmetic)._sizeHint();
      case Transactional:
        return (value as Transactional)._sizeHint();
      case Exhausted:
        return 1;
      case Corruption:
        return 1;
      case Unavailable:
        return 1;
      case RootNotAllowed:
        return 1;
      default:
        throw Exception(
            'DispatchError: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Other extends DispatchError {
  const Other();

  @override
  Map<String, dynamic> toJson() => {'Other': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }
}

class CannotLookup extends DispatchError {
  const CannotLookup();

  @override
  Map<String, dynamic> toJson() => {'CannotLookup': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }
}

class BadOrigin extends DispatchError {
  const BadOrigin();

  @override
  Map<String, dynamic> toJson() => {'BadOrigin': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }
}

class Module extends DispatchError {
  const Module({required this.value0});

  factory Module._decode(_i1.Input input) {
    return Module(
      value0: _i3.ModuleError.codec.decode(input),
    );
  }

  final _i3.ModuleError value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Module': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ModuleError.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.ModuleError.codec.encodeTo(
      value0,
      output,
    );
  }
}

class ConsumerRemaining extends DispatchError {
  const ConsumerRemaining();

  @override
  Map<String, dynamic> toJson() => {'ConsumerRemaining': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }
}

class NoProviders extends DispatchError {
  const NoProviders();

  @override
  Map<String, dynamic> toJson() => {'NoProviders': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }
}

class TooManyConsumers extends DispatchError {
  const TooManyConsumers();

  @override
  Map<String, dynamic> toJson() => {'TooManyConsumers': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }
}

class Token extends DispatchError {
  const Token({required this.value0});

  factory Token._decode(_i1.Input input) {
    return Token(
      value0: _i4.TokenError.codec.decode(input),
    );
  }

  final _i4.TokenError value0;

  @override
  Map<String, String> toJson() => {'Token': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.TokenError.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i4.TokenError.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Arithmetic extends DispatchError {
  const Arithmetic({required this.value0});

  factory Arithmetic._decode(_i1.Input input) {
    return Arithmetic(
      value0: _i5.ArithmeticError.codec.decode(input),
    );
  }

  final _i5.ArithmeticError value0;

  @override
  Map<String, String> toJson() => {'Arithmetic': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.ArithmeticError.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i5.ArithmeticError.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Transactional extends DispatchError {
  const Transactional({required this.value0});

  factory Transactional._decode(_i1.Input input) {
    return Transactional(
      value0: _i6.TransactionalError.codec.decode(input),
    );
  }

  final _i6.TransactionalError value0;

  @override
  Map<String, String> toJson() => {'Transactional': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.TransactionalError.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i6.TransactionalError.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Exhausted extends DispatchError {
  const Exhausted();

  @override
  Map<String, dynamic> toJson() => {'Exhausted': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }
}

class Corruption extends DispatchError {
  const Corruption();

  @override
  Map<String, dynamic> toJson() => {'Corruption': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
  }
}

class Unavailable extends DispatchError {
  const Unavailable();

  @override
  Map<String, dynamic> toJson() => {'Unavailable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
  }
}

class RootNotAllowed extends DispatchError {
  const RootNotAllowed();

  @override
  Map<String, dynamic> toJson() => {'RootNotAllowed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
  }
}
