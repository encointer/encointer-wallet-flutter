// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  SetInvulnerables setInvulnerables({required List<_i3.AccountId32> new_}) {
    return SetInvulnerables(new_: new_);
  }

  SetDesiredCandidates setDesiredCandidates({required int max}) {
    return SetDesiredCandidates(max: max);
  }

  SetCandidacyBond setCandidacyBond({required BigInt bond}) {
    return SetCandidacyBond(bond: bond);
  }

  RegisterAsCandidate registerAsCandidate() {
    return RegisterAsCandidate();
  }

  LeaveIntent leaveIntent() {
    return LeaveIntent();
  }

  AddInvulnerable addInvulnerable({required _i3.AccountId32 who}) {
    return AddInvulnerable(who: who);
  }

  RemoveInvulnerable removeInvulnerable({required _i3.AccountId32 who}) {
    return RemoveInvulnerable(who: who);
  }

  UpdateBond updateBond({required BigInt newDeposit}) {
    return UpdateBond(newDeposit: newDeposit);
  }

  TakeCandidateSlot takeCandidateSlot({
    required BigInt deposit,
    required _i3.AccountId32 target,
  }) {
    return TakeCandidateSlot(
      deposit: deposit,
      target: target,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SetInvulnerables._decode(input);
      case 1:
        return SetDesiredCandidates._decode(input);
      case 2:
        return SetCandidacyBond._decode(input);
      case 3:
        return const RegisterAsCandidate();
      case 4:
        return const LeaveIntent();
      case 5:
        return AddInvulnerable._decode(input);
      case 6:
        return RemoveInvulnerable._decode(input);
      case 7:
        return UpdateBond._decode(input);
      case 8:
        return TakeCandidateSlot._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case SetInvulnerables:
        (value as SetInvulnerables).encodeTo(output);
        break;
      case SetDesiredCandidates:
        (value as SetDesiredCandidates).encodeTo(output);
        break;
      case SetCandidacyBond:
        (value as SetCandidacyBond).encodeTo(output);
        break;
      case RegisterAsCandidate:
        (value as RegisterAsCandidate).encodeTo(output);
        break;
      case LeaveIntent:
        (value as LeaveIntent).encodeTo(output);
        break;
      case AddInvulnerable:
        (value as AddInvulnerable).encodeTo(output);
        break;
      case RemoveInvulnerable:
        (value as RemoveInvulnerable).encodeTo(output);
        break;
      case UpdateBond:
        (value as UpdateBond).encodeTo(output);
        break;
      case TakeCandidateSlot:
        (value as TakeCandidateSlot).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetInvulnerables:
        return (value as SetInvulnerables)._sizeHint();
      case SetDesiredCandidates:
        return (value as SetDesiredCandidates)._sizeHint();
      case SetCandidacyBond:
        return (value as SetCandidacyBond)._sizeHint();
      case RegisterAsCandidate:
        return 1;
      case LeaveIntent:
        return 1;
      case AddInvulnerable:
        return (value as AddInvulnerable)._sizeHint();
      case RemoveInvulnerable:
        return (value as RemoveInvulnerable)._sizeHint();
      case UpdateBond:
        return (value as UpdateBond)._sizeHint();
      case TakeCandidateSlot:
        return (value as TakeCandidateSlot)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

/// Set the list of invulnerable (fixed) collators. These collators must do some
/// preparation, namely to have registered session keys.
///
/// The call will remove any accounts that have not registered keys from the set. That is,
/// it is non-atomic; the caller accepts all `AccountId`s passed in `new` _individually_ as
/// acceptable Invulnerables, and is not proposing a _set_ of new Invulnerables.
///
/// This call does not maintain mutual exclusivity of `Invulnerables` and `Candidates`. It
/// is recommended to use a batch of `add_invulnerable` and `remove_invulnerable` instead. A
/// `batch_all` can also be used to enforce atomicity. If any candidates are included in
/// `new`, they should be removed with `remove_invulnerable_candidate` after execution.
///
/// Must be called by the `UpdateOrigin`.
class SetInvulnerables extends Call {
  const SetInvulnerables({required this.new_});

  factory SetInvulnerables._decode(_i1.Input input) {
    return SetInvulnerables(new_: const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input));
  }

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> new_;

  @override
  Map<String, Map<String, List<List<int>>>> toJson() => {
        'set_invulnerables': {'new': new_.map((value) => value.toList()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetInvulnerables &&
          _i4.listsEqual(
            other.new_,
            new_,
          );

  @override
  int get hashCode => new_.hashCode;
}

/// Set the ideal number of non-invulnerable collators. If lowering this number, then the
/// number of running collators could be higher than this figure. Aside from that edge case,
/// there should be no other way to have more candidates than the desired number.
///
/// The origin for this call must be the `UpdateOrigin`.
class SetDesiredCandidates extends Call {
  const SetDesiredCandidates({required this.max});

  factory SetDesiredCandidates._decode(_i1.Input input) {
    return SetDesiredCandidates(max: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int max;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_desired_candidates': {'max': max}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(max);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      max,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetDesiredCandidates && other.max == max;

  @override
  int get hashCode => max.hashCode;
}

/// Set the candidacy bond amount.
///
/// If the candidacy bond is increased by this call, all current candidates which have a
/// deposit lower than the new bond will be kicked from the list and get their deposits
/// back.
///
/// The origin for this call must be the `UpdateOrigin`.
class SetCandidacyBond extends Call {
  const SetCandidacyBond({required this.bond});

  factory SetCandidacyBond._decode(_i1.Input input) {
    return SetCandidacyBond(bond: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt bond;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_candidacy_bond': {'bond': bond}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(bond);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      bond,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCandidacyBond && other.bond == bond;

  @override
  int get hashCode => bond.hashCode;
}

/// Register this account as a collator candidate. The account must (a) already have
/// registered session keys and (b) be able to reserve the `CandidacyBond`.
///
/// This call is not available to `Invulnerable` collators.
class RegisterAsCandidate extends Call {
  const RegisterAsCandidate();

  @override
  Map<String, dynamic> toJson() => {'register_as_candidate': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is RegisterAsCandidate;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Deregister `origin` as a collator candidate. Note that the collator can only leave on
/// session change. The `CandidacyBond` will be unreserved immediately.
///
/// This call will fail if the total number of candidates would drop below
/// `MinEligibleCollators`.
class LeaveIntent extends Call {
  const LeaveIntent();

  @override
  Map<String, dynamic> toJson() => {'leave_intent': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is LeaveIntent;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Add a new account `who` to the list of `Invulnerables` collators. `who` must have
/// registered session keys. If `who` is a candidate, they will be removed.
///
/// The origin for this call must be the `UpdateOrigin`.
class AddInvulnerable extends Call {
  const AddInvulnerable({required this.who});

  factory AddInvulnerable._decode(_i1.Input input) {
    return AddInvulnerable(who: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'add_invulnerable': {'who': who.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddInvulnerable &&
          _i4.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => who.hashCode;
}

/// Remove an account `who` from the list of `Invulnerables` collators. `Invulnerables` must
/// be sorted.
///
/// The origin for this call must be the `UpdateOrigin`.
class RemoveInvulnerable extends Call {
  const RemoveInvulnerable({required this.who});

  factory RemoveInvulnerable._decode(_i1.Input input) {
    return RemoveInvulnerable(who: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'remove_invulnerable': {'who': who.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveInvulnerable &&
          _i4.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => who.hashCode;
}

/// Update the candidacy bond of collator candidate `origin` to a new amount `new_deposit`.
///
/// Setting a `new_deposit` that is lower than the current deposit while `origin` is
/// occupying a top-`DesiredCandidates` slot is not allowed.
///
/// This call will fail if `origin` is not a collator candidate, the updated bond is lower
/// than the minimum candidacy bond, and/or the amount cannot be reserved.
class UpdateBond extends Call {
  const UpdateBond({required this.newDeposit});

  factory UpdateBond._decode(_i1.Input input) {
    return UpdateBond(newDeposit: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt newDeposit;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'update_bond': {'newDeposit': newDeposit}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(newDeposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      newDeposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateBond && other.newDeposit == newDeposit;

  @override
  int get hashCode => newDeposit.hashCode;
}

/// The caller `origin` replaces a candidate `target` in the collator candidate list by
/// reserving `deposit`. The amount `deposit` reserved by the caller must be greater than
/// the existing bond of the target it is trying to replace.
///
/// This call will fail if the caller is already a collator candidate or invulnerable, the
/// caller does not have registered session keys, the target is not a collator candidate,
/// and/or the `deposit` amount cannot be reserved.
class TakeCandidateSlot extends Call {
  const TakeCandidateSlot({
    required this.deposit,
    required this.target,
  });

  factory TakeCandidateSlot._decode(_i1.Input input) {
    return TakeCandidateSlot(
      deposit: _i1.U128Codec.codec.decode(input),
      target: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt deposit;

  /// T::AccountId
  final _i3.AccountId32 target;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'take_candidate_slot': {
          'deposit': deposit,
          'target': target.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    size = size + const _i3.AccountId32Codec().sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      target,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TakeCandidateSlot &&
          other.deposit == deposit &&
          _i4.listsEqual(
            other.target,
            target,
          );

  @override
  int get hashCode => Object.hash(
        deposit,
        target,
      );
}
