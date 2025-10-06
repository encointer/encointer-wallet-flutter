// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

abstract class ExistenceReason {
  const ExistenceReason();

  factory ExistenceReason.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ExistenceReasonCodec codec = $ExistenceReasonCodec();

  static const $ExistenceReason values = $ExistenceReason();

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

class $ExistenceReason {
  const $ExistenceReason();

  Consumer consumer() {
    return Consumer();
  }

  Sufficient sufficient() {
    return Sufficient();
  }

  DepositHeld depositHeld(BigInt value0) {
    return DepositHeld(value0);
  }

  DepositRefunded depositRefunded() {
    return DepositRefunded();
  }

  DepositFrom depositFrom(
    _i3.AccountId32 value0,
    BigInt value1,
  ) {
    return DepositFrom(
      value0,
      value1,
    );
  }
}

class $ExistenceReasonCodec with _i1.Codec<ExistenceReason> {
  const $ExistenceReasonCodec();

  @override
  ExistenceReason decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Consumer();
      case 1:
        return const Sufficient();
      case 2:
        return DepositHeld._decode(input);
      case 3:
        return const DepositRefunded();
      case 4:
        return DepositFrom._decode(input);
      default:
        throw Exception('ExistenceReason: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ExistenceReason value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Consumer:
        (value as Consumer).encodeTo(output);
        break;
      case Sufficient:
        (value as Sufficient).encodeTo(output);
        break;
      case DepositHeld:
        (value as DepositHeld).encodeTo(output);
        break;
      case DepositRefunded:
        (value as DepositRefunded).encodeTo(output);
        break;
      case DepositFrom:
        (value as DepositFrom).encodeTo(output);
        break;
      default:
        throw Exception('ExistenceReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ExistenceReason value) {
    switch (value.runtimeType) {
      case Consumer:
        return 1;
      case Sufficient:
        return 1;
      case DepositHeld:
        return (value as DepositHeld)._sizeHint();
      case DepositRefunded:
        return 1;
      case DepositFrom:
        return (value as DepositFrom)._sizeHint();
      default:
        throw Exception('ExistenceReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Consumer extends ExistenceReason {
  const Consumer();

  @override
  Map<String, dynamic> toJson() => {'Consumer': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Consumer;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Sufficient extends ExistenceReason {
  const Sufficient();

  @override
  Map<String, dynamic> toJson() => {'Sufficient': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Sufficient;

  @override
  int get hashCode => runtimeType.hashCode;
}

class DepositHeld extends ExistenceReason {
  const DepositHeld(this.value0);

  factory DepositHeld._decode(_i1.Input input) {
    return DepositHeld(_i1.U128Codec.codec.decode(input));
  }

  /// Balance
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'DepositHeld': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
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
      other is DepositHeld && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class DepositRefunded extends ExistenceReason {
  const DepositRefunded();

  @override
  Map<String, dynamic> toJson() => {'DepositRefunded': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is DepositRefunded;

  @override
  int get hashCode => runtimeType.hashCode;
}

class DepositFrom extends ExistenceReason {
  const DepositFrom(
    this.value0,
    this.value1,
  );

  factory DepositFrom._decode(_i1.Input input) {
    return DepositFrom(
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U128Codec.codec.decode(input),
    );
  }

  /// AccountId
  final _i3.AccountId32 value0;

  /// Balance
  final BigInt value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'DepositFrom': [
          value0.toList(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
    size = size + _i1.U128Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DepositFrom &&
          _i4.listsEqual(
            other.value0,
            value0,
          ) &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}
