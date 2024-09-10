// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  Dripped dripped(
    _i3.AccountId32 value0,
    _i3.AccountId32 value1,
    BigInt value2,
  ) {
    return Dripped(
      value0,
      value1,
      value2,
    );
  }

  FaucetCreated faucetCreated(
    _i3.AccountId32 value0,
    List<int> value1,
  ) {
    return FaucetCreated(
      value0,
      value1,
    );
  }

  ReserveAmountUpdated reserveAmountUpdated(BigInt value0) {
    return ReserveAmountUpdated(value0);
  }

  FaucetDissolved faucetDissolved(_i3.AccountId32 value0) {
    return FaucetDissolved(value0);
  }

  FaucetClosed faucetClosed(_i3.AccountId32 value0) {
    return FaucetClosed(value0);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Dripped._decode(input);
      case 1:
        return FaucetCreated._decode(input);
      case 2:
        return ReserveAmountUpdated._decode(input);
      case 3:
        return FaucetDissolved._decode(input);
      case 4:
        return FaucetClosed._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Dripped:
        (value as Dripped).encodeTo(output);
        break;
      case FaucetCreated:
        (value as FaucetCreated).encodeTo(output);
        break;
      case ReserveAmountUpdated:
        (value as ReserveAmountUpdated).encodeTo(output);
        break;
      case FaucetDissolved:
        (value as FaucetDissolved).encodeTo(output);
        break;
      case FaucetClosed:
        (value as FaucetClosed).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Dripped:
        return (value as Dripped)._sizeHint();
      case FaucetCreated:
        return (value as FaucetCreated)._sizeHint();
      case ReserveAmountUpdated:
        return (value as ReserveAmountUpdated)._sizeHint();
      case FaucetDissolved:
        return (value as FaucetDissolved)._sizeHint();
      case FaucetClosed:
        return (value as FaucetClosed)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// faucet dripped | facuet account, receiver account, balance
class Dripped extends Event {
  const Dripped(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Dripped._decode(_i1.Input input) {
    return Dripped(
      const _i1.U8ArrayCodec(32).decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 value0;

  /// T::AccountId
  final _i3.AccountId32 value1;

  /// BalanceOf<T>
  final BigInt value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Dripped': [
          value0.toList(),
          value1.toList(),
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
    size = size + const _i3.AccountId32Codec().sizeHint(value1);
    size = size + _i1.U128Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Dripped &&
          _i4.listsEqual(
            other.value0,
            value0,
          ) &&
          _i4.listsEqual(
            other.value1,
            value1,
          ) &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// faucet created
class FaucetCreated extends Event {
  const FaucetCreated(
    this.value0,
    this.value1,
  );

  factory FaucetCreated._decode(_i1.Input input) {
    return FaucetCreated(
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 value0;

  /// FaucetNameType
  final List<int> value1;

  @override
  Map<String, List<List<int>>> toJson() => {
        'FaucetCreated': [
          value0.toList(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
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
      other is FaucetCreated &&
          _i4.listsEqual(
            other.value0,
            value0,
          ) &&
          _i4.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// reserve amount updated
class ReserveAmountUpdated extends Event {
  const ReserveAmountUpdated(this.value0);

  factory ReserveAmountUpdated._decode(_i1.Input input) {
    return ReserveAmountUpdated(_i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'ReserveAmountUpdated': value0};

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
      other is ReserveAmountUpdated && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// faucet dissolved
class FaucetDissolved extends Event {
  const FaucetDissolved(this.value0);

  factory FaucetDissolved._decode(_i1.Input input) {
    return FaucetDissolved(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 value0;

  @override
  Map<String, List<int>> toJson() => {'FaucetDissolved': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is FaucetDissolved &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

/// faucet closed
class FaucetClosed extends Event {
  const FaucetClosed(this.value0);

  factory FaucetClosed._decode(_i1.Input input) {
    return FaucetClosed(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 value0;

  @override
  Map<String, List<int>> toJson() => {'FaucetClosed': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FaucetClosed &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
