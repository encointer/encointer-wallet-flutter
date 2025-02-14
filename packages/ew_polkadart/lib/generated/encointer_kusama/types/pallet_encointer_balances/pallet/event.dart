// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../encointer_primitives/communities/community_identifier.dart' as _i3;
import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../substrate_fixed/fixed_u128.dart' as _i5;

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

  Endowed endowed({
    required _i3.CommunityIdentifier cid,
    required _i4.AccountId32 who,
    required _i5.FixedU128 balance,
  }) {
    return Endowed(
      cid: cid,
      who: who,
      balance: balance,
    );
  }

  Transferred transferred(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
    _i4.AccountId32 value2,
    _i5.FixedU128 value3,
  ) {
    return Transferred(
      value0,
      value1,
      value2,
      value3,
    );
  }

  Issued issued(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
    _i5.FixedU128 value2,
  ) {
    return Issued(
      value0,
      value1,
      value2,
    );
  }

  Burned burned(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
    _i5.FixedU128 value2,
  ) {
    return Burned(
      value0,
      value1,
      value2,
    );
  }

  FeeConversionFactorUpdated feeConversionFactorUpdated(BigInt value0) {
    return FeeConversionFactorUpdated(value0);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Endowed._decode(input);
      case 1:
        return Transferred._decode(input);
      case 2:
        return Issued._decode(input);
      case 3:
        return Burned._decode(input);
      case 4:
        return FeeConversionFactorUpdated._decode(input);
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
      case Endowed:
        (value as Endowed).encodeTo(output);
        break;
      case Transferred:
        (value as Transferred).encodeTo(output);
        break;
      case Issued:
        (value as Issued).encodeTo(output);
        break;
      case Burned:
        (value as Burned).encodeTo(output);
        break;
      case FeeConversionFactorUpdated:
        (value as FeeConversionFactorUpdated).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Endowed:
        return (value as Endowed)._sizeHint();
      case Transferred:
        return (value as Transferred)._sizeHint();
      case Issued:
        return (value as Issued)._sizeHint();
      case Burned:
        return (value as Burned)._sizeHint();
      case FeeConversionFactorUpdated:
        return (value as FeeConversionFactorUpdated)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Endowed a new account with a respective currency `[community_id, who, balance]`
class Endowed extends Event {
  const Endowed({
    required this.cid,
    required this.who,
    required this.balance,
  });

  factory Endowed._decode(_i1.Input input) {
    return Endowed(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      balance: _i5.FixedU128.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier cid;

  /// T::AccountId
  final _i4.AccountId32 who;

  /// BalanceType
  final _i5.FixedU128 balance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Endowed': {
          'cid': cid.toJson(),
          'who': who.toList(),
          'balance': balance.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i5.FixedU128.codec.sizeHint(balance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i5.FixedU128.codec.encodeTo(
      balance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Endowed &&
          other.cid == cid &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          other.balance == balance;

  @override
  int get hashCode => Object.hash(
        cid,
        who,
        balance,
      );
}

/// Token transfer success `[community_id, from, to, amount]`
class Transferred extends Event {
  const Transferred(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
  );

  factory Transferred._decode(_i1.Input input) {
    return Transferred(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i5.FixedU128.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  /// T::AccountId
  final _i4.AccountId32 value2;

  /// BalanceType
  final _i5.FixedU128 value3;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Transferred': [
          value0.toJson(),
          value1.toList(),
          value2.toList(),
          value3.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    size = size + const _i4.AccountId32Codec().sizeHint(value2);
    size = size + _i5.FixedU128.codec.sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value2,
      output,
    );
    _i5.FixedU128.codec.encodeTo(
      value3,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transferred &&
          other.value0 == value0 &&
          _i6.listsEqual(
            other.value1,
            value1,
          ) &&
          _i6.listsEqual(
            other.value2,
            value2,
          ) &&
          other.value3 == value3;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
      );
}

/// Token issuance success `[community_id, beneficiary, amount]`
class Issued extends Event {
  const Issued(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Issued._decode(_i1.Input input) {
    return Issued(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i5.FixedU128.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  /// BalanceType
  final _i5.FixedU128 value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Issued': [
          value0.toJson(),
          value1.toList(),
          value2.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    size = size + _i5.FixedU128.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    _i5.FixedU128.codec.encodeTo(
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
      other is Issued &&
          other.value0 == value0 &&
          _i6.listsEqual(
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

/// Token burn success `[community_id, who, amount]`
class Burned extends Event {
  const Burned(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Burned._decode(_i1.Input input) {
    return Burned(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i5.FixedU128.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  /// BalanceType
  final _i5.FixedU128 value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Burned': [
          value0.toJson(),
          value1.toList(),
          value2.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    size = size + _i5.FixedU128.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    _i5.FixedU128.codec.encodeTo(
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
      other is Burned &&
          other.value0 == value0 &&
          _i6.listsEqual(
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

/// fee conversion factor updated successfully
class FeeConversionFactorUpdated extends Event {
  const FeeConversionFactorUpdated(this.value0);

  factory FeeConversionFactorUpdated._decode(_i1.Input input) {
    return FeeConversionFactorUpdated(_i1.U128Codec.codec.decode(input));
  }

  /// FeeConversionFactorType
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'FeeConversionFactorUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
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
      other is FeeConversionFactorUpdated && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
