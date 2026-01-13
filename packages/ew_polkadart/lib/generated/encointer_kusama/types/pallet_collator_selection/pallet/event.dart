// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
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

  NewInvulnerables newInvulnerables({required List<_i3.AccountId32> invulnerables}) {
    return NewInvulnerables(invulnerables: invulnerables);
  }

  InvulnerableAdded invulnerableAdded({required _i3.AccountId32 accountId}) {
    return InvulnerableAdded(accountId: accountId);
  }

  InvulnerableRemoved invulnerableRemoved({required _i3.AccountId32 accountId}) {
    return InvulnerableRemoved(accountId: accountId);
  }

  NewDesiredCandidates newDesiredCandidates({required int desiredCandidates}) {
    return NewDesiredCandidates(desiredCandidates: desiredCandidates);
  }

  NewCandidacyBond newCandidacyBond({required BigInt bondAmount}) {
    return NewCandidacyBond(bondAmount: bondAmount);
  }

  CandidateAdded candidateAdded({
    required _i3.AccountId32 accountId,
    required BigInt deposit,
  }) {
    return CandidateAdded(
      accountId: accountId,
      deposit: deposit,
    );
  }

  CandidateBondUpdated candidateBondUpdated({
    required _i3.AccountId32 accountId,
    required BigInt deposit,
  }) {
    return CandidateBondUpdated(
      accountId: accountId,
      deposit: deposit,
    );
  }

  CandidateRemoved candidateRemoved({required _i3.AccountId32 accountId}) {
    return CandidateRemoved(accountId: accountId);
  }

  CandidateReplaced candidateReplaced({
    required _i3.AccountId32 old,
    required _i3.AccountId32 new_,
    required BigInt deposit,
  }) {
    return CandidateReplaced(
      old: old,
      new_: new_,
      deposit: deposit,
    );
  }

  InvalidInvulnerableSkipped invalidInvulnerableSkipped({required _i3.AccountId32 accountId}) {
    return InvalidInvulnerableSkipped(accountId: accountId);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return NewInvulnerables._decode(input);
      case 1:
        return InvulnerableAdded._decode(input);
      case 2:
        return InvulnerableRemoved._decode(input);
      case 3:
        return NewDesiredCandidates._decode(input);
      case 4:
        return NewCandidacyBond._decode(input);
      case 5:
        return CandidateAdded._decode(input);
      case 6:
        return CandidateBondUpdated._decode(input);
      case 7:
        return CandidateRemoved._decode(input);
      case 8:
        return CandidateReplaced._decode(input);
      case 9:
        return InvalidInvulnerableSkipped._decode(input);
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
      case NewInvulnerables:
        (value as NewInvulnerables).encodeTo(output);
        break;
      case InvulnerableAdded:
        (value as InvulnerableAdded).encodeTo(output);
        break;
      case InvulnerableRemoved:
        (value as InvulnerableRemoved).encodeTo(output);
        break;
      case NewDesiredCandidates:
        (value as NewDesiredCandidates).encodeTo(output);
        break;
      case NewCandidacyBond:
        (value as NewCandidacyBond).encodeTo(output);
        break;
      case CandidateAdded:
        (value as CandidateAdded).encodeTo(output);
        break;
      case CandidateBondUpdated:
        (value as CandidateBondUpdated).encodeTo(output);
        break;
      case CandidateRemoved:
        (value as CandidateRemoved).encodeTo(output);
        break;
      case CandidateReplaced:
        (value as CandidateReplaced).encodeTo(output);
        break;
      case InvalidInvulnerableSkipped:
        (value as InvalidInvulnerableSkipped).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case NewInvulnerables:
        return (value as NewInvulnerables)._sizeHint();
      case InvulnerableAdded:
        return (value as InvulnerableAdded)._sizeHint();
      case InvulnerableRemoved:
        return (value as InvulnerableRemoved)._sizeHint();
      case NewDesiredCandidates:
        return (value as NewDesiredCandidates)._sizeHint();
      case NewCandidacyBond:
        return (value as NewCandidacyBond)._sizeHint();
      case CandidateAdded:
        return (value as CandidateAdded)._sizeHint();
      case CandidateBondUpdated:
        return (value as CandidateBondUpdated)._sizeHint();
      case CandidateRemoved:
        return (value as CandidateRemoved)._sizeHint();
      case CandidateReplaced:
        return (value as CandidateReplaced)._sizeHint();
      case InvalidInvulnerableSkipped:
        return (value as InvalidInvulnerableSkipped)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

/// New Invulnerables were set.
class NewInvulnerables extends Event {
  const NewInvulnerables({required this.invulnerables});

  factory NewInvulnerables._decode(_i1.Input input) {
    return NewInvulnerables(
        invulnerables: const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input));
  }

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> invulnerables;

  @override
  Map<String, Map<String, List<List<int>>>> toJson() => {
        'NewInvulnerables': {'invulnerables': invulnerables.map((value) => value.toList()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).sizeHint(invulnerables);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      invulnerables,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewInvulnerables &&
          _i4.listsEqual(
            other.invulnerables,
            invulnerables,
          );

  @override
  int get hashCode => invulnerables.hashCode;
}

/// A new Invulnerable was added.
class InvulnerableAdded extends Event {
  const InvulnerableAdded({required this.accountId});

  factory InvulnerableAdded._decode(_i1.Input input) {
    return InvulnerableAdded(accountId: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 accountId;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'InvulnerableAdded': {'accountId': accountId.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(accountId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      accountId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InvulnerableAdded &&
          _i4.listsEqual(
            other.accountId,
            accountId,
          );

  @override
  int get hashCode => accountId.hashCode;
}

/// An Invulnerable was removed.
class InvulnerableRemoved extends Event {
  const InvulnerableRemoved({required this.accountId});

  factory InvulnerableRemoved._decode(_i1.Input input) {
    return InvulnerableRemoved(accountId: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 accountId;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'InvulnerableRemoved': {'accountId': accountId.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(accountId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      accountId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InvulnerableRemoved &&
          _i4.listsEqual(
            other.accountId,
            accountId,
          );

  @override
  int get hashCode => accountId.hashCode;
}

/// The number of desired candidates was set.
class NewDesiredCandidates extends Event {
  const NewDesiredCandidates({required this.desiredCandidates});

  factory NewDesiredCandidates._decode(_i1.Input input) {
    return NewDesiredCandidates(desiredCandidates: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int desiredCandidates;

  @override
  Map<String, Map<String, int>> toJson() => {
        'NewDesiredCandidates': {'desiredCandidates': desiredCandidates}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(desiredCandidates);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      desiredCandidates,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewDesiredCandidates && other.desiredCandidates == desiredCandidates;

  @override
  int get hashCode => desiredCandidates.hashCode;
}

/// The candidacy bond was set.
class NewCandidacyBond extends Event {
  const NewCandidacyBond({required this.bondAmount});

  factory NewCandidacyBond._decode(_i1.Input input) {
    return NewCandidacyBond(bondAmount: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt bondAmount;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'NewCandidacyBond': {'bondAmount': bondAmount}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(bondAmount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      bondAmount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewCandidacyBond && other.bondAmount == bondAmount;

  @override
  int get hashCode => bondAmount.hashCode;
}

/// A new candidate joined.
class CandidateAdded extends Event {
  const CandidateAdded({
    required this.accountId,
    required this.deposit,
  });

  factory CandidateAdded._decode(_i1.Input input) {
    return CandidateAdded(
      accountId: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 accountId;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CandidateAdded': {
          'accountId': accountId.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(accountId);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      accountId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateAdded &&
          _i4.listsEqual(
            other.accountId,
            accountId,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        accountId,
        deposit,
      );
}

/// Bond of a candidate updated.
class CandidateBondUpdated extends Event {
  const CandidateBondUpdated({
    required this.accountId,
    required this.deposit,
  });

  factory CandidateBondUpdated._decode(_i1.Input input) {
    return CandidateBondUpdated(
      accountId: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 accountId;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CandidateBondUpdated': {
          'accountId': accountId.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(accountId);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      accountId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateBondUpdated &&
          _i4.listsEqual(
            other.accountId,
            accountId,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        accountId,
        deposit,
      );
}

/// A candidate was removed.
class CandidateRemoved extends Event {
  const CandidateRemoved({required this.accountId});

  factory CandidateRemoved._decode(_i1.Input input) {
    return CandidateRemoved(accountId: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 accountId;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'CandidateRemoved': {'accountId': accountId.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(accountId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      accountId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateRemoved &&
          _i4.listsEqual(
            other.accountId,
            accountId,
          );

  @override
  int get hashCode => accountId.hashCode;
}

/// An account was replaced in the candidate list by another one.
class CandidateReplaced extends Event {
  const CandidateReplaced({
    required this.old,
    required this.new_,
    required this.deposit,
  });

  factory CandidateReplaced._decode(_i1.Input input) {
    return CandidateReplaced(
      old: const _i1.U8ArrayCodec(32).decode(input),
      new_: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 old;

  /// T::AccountId
  final _i3.AccountId32 new_;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CandidateReplaced': {
          'old': old.toList(),
          'new': new_.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(old);
    size = size + const _i3.AccountId32Codec().sizeHint(new_);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      old,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      new_,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateReplaced &&
          _i4.listsEqual(
            other.old,
            old,
          ) &&
          _i4.listsEqual(
            other.new_,
            new_,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        old,
        new_,
        deposit,
      );
}

/// An account was unable to be added to the Invulnerables because they did not have keys
/// registered. Other Invulnerables may have been set.
class InvalidInvulnerableSkipped extends Event {
  const InvalidInvulnerableSkipped({required this.accountId});

  factory InvalidInvulnerableSkipped._decode(_i1.Input input) {
    return InvalidInvulnerableSkipped(accountId: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 accountId;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'InvalidInvulnerableSkipped': {'accountId': accountId.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(accountId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      accountId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InvalidInvulnerableSkipped &&
          _i4.listsEqual(
            other.accountId,
            accountId,
          );

  @override
  int get hashCode => accountId.hashCode;
}
