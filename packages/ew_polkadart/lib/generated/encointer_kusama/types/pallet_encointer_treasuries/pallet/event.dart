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

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  SpentNative spentNative({
    required _i3.AccountId32 treasury,
    required _i3.AccountId32 beneficiary,
    required BigInt amount,
  }) {
    return SpentNative(
      treasury: treasury,
      beneficiary: beneficiary,
      amount: amount,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SpentNative._decode(input);
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
      case SpentNative:
        (value as SpentNative).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case SpentNative:
        return (value as SpentNative)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// treasury spent native tokens from community `cid` to `beneficiary` amounting `amount`
class SpentNative extends Event {
  const SpentNative({
    required this.treasury,
    required this.beneficiary,
    required this.amount,
  });

  factory SpentNative._decode(_i1.Input input) {
    return SpentNative(
      treasury: const _i1.U8ArrayCodec(32).decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 treasury;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SpentNative': {
          'treasury': treasury.toList(),
          'beneficiary': beneficiary.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(treasury);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      treasury,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpentNative &&
          _i4.listsEqual(
            other.treasury,
            treasury,
          ) &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        treasury,
        beneficiary,
        amount,
      );
}
