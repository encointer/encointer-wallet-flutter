// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import '../../sp_core/crypto/account_id32.dart' as _i4;

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

  AddMember addMember({required _i3.MultiAddress who}) {
    return AddMember(
      who: who,
    );
  }

  RemoveMember removeMember({required _i3.MultiAddress who}) {
    return RemoveMember(
      who: who,
    );
  }

  SwapMember swapMember({
    required _i3.MultiAddress remove,
    required _i3.MultiAddress add,
  }) {
    return SwapMember(
      remove: remove,
      add: add,
    );
  }

  ResetMembers resetMembers({required List<_i4.AccountId32> members}) {
    return ResetMembers(
      members: members,
    );
  }

  ChangeKey changeKey({required _i3.MultiAddress new_}) {
    return ChangeKey(
      new_: new_,
    );
  }

  SetPrime setPrime({required _i3.MultiAddress who}) {
    return SetPrime(
      who: who,
    );
  }

  ClearPrime clearPrime() {
    return const ClearPrime();
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AddMember._decode(input);
      case 1:
        return RemoveMember._decode(input);
      case 2:
        return SwapMember._decode(input);
      case 3:
        return ResetMembers._decode(input);
      case 4:
        return ChangeKey._decode(input);
      case 5:
        return SetPrime._decode(input);
      case 6:
        return const ClearPrime();
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
      case AddMember:
        (value as AddMember).encodeTo(output);
        break;
      case RemoveMember:
        (value as RemoveMember).encodeTo(output);
        break;
      case SwapMember:
        (value as SwapMember).encodeTo(output);
        break;
      case ResetMembers:
        (value as ResetMembers).encodeTo(output);
        break;
      case ChangeKey:
        (value as ChangeKey).encodeTo(output);
        break;
      case SetPrime:
        (value as SetPrime).encodeTo(output);
        break;
      case ClearPrime:
        (value as ClearPrime).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case AddMember:
        return (value as AddMember)._sizeHint();
      case RemoveMember:
        return (value as RemoveMember)._sizeHint();
      case SwapMember:
        return (value as SwapMember)._sizeHint();
      case ResetMembers:
        return (value as ResetMembers)._sizeHint();
      case ChangeKey:
        return (value as ChangeKey)._sizeHint();
      case SetPrime:
        return (value as SetPrime)._sizeHint();
      case ClearPrime:
        return 1;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::add_member`].
class AddMember extends Call {
  const AddMember({required this.who});

  factory AddMember._decode(_i1.Input input) {
    return AddMember(
      who: _i3.MultiAddress.codec.decode(input),
    );
  }

  final _i3.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'add_member': {'who': who.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }
}

/// See [`Pallet::remove_member`].
class RemoveMember extends Call {
  const RemoveMember({required this.who});

  factory RemoveMember._decode(_i1.Input input) {
    return RemoveMember(
      who: _i3.MultiAddress.codec.decode(input),
    );
  }

  final _i3.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'remove_member': {'who': who.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }
}

/// See [`Pallet::swap_member`].
class SwapMember extends Call {
  const SwapMember({
    required this.remove,
    required this.add,
  });

  factory SwapMember._decode(_i1.Input input) {
    return SwapMember(
      remove: _i3.MultiAddress.codec.decode(input),
      add: _i3.MultiAddress.codec.decode(input),
    );
  }

  final _i3.MultiAddress remove;

  final _i3.MultiAddress add;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'swap_member': {
          'remove': remove.toJson(),
          'add': add.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(remove);
    size = size + _i3.MultiAddress.codec.sizeHint(add);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      remove,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      add,
      output,
    );
  }
}

/// See [`Pallet::reset_members`].
class ResetMembers extends Call {
  const ResetMembers({required this.members});

  factory ResetMembers._decode(_i1.Input input) {
    return ResetMembers(
      members: const _i1.SequenceCodec<_i4.AccountId32>(_i1.U8ArrayCodec(32))
          .decode(input),
    );
  }

  final List<_i4.AccountId32> members;

  @override
  Map<String, Map<String, List<List<int>>>> toJson() => {
        'reset_members': {
          'members': members.map((value) => value.toList()).toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i4.AccountId32>(_i1.U8ArrayCodec(32))
            .sizeHint(members);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.SequenceCodec<_i4.AccountId32>(_i1.U8ArrayCodec(32)).encodeTo(
      members,
      output,
    );
  }
}

/// See [`Pallet::change_key`].
class ChangeKey extends Call {
  const ChangeKey({required this.new_});

  factory ChangeKey._decode(_i1.Input input) {
    return ChangeKey(
      new_: _i3.MultiAddress.codec.decode(input),
    );
  }

  final _i3.MultiAddress new_;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'change_key': {'new': new_.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      new_,
      output,
    );
  }
}

/// See [`Pallet::set_prime`].
class SetPrime extends Call {
  const SetPrime({required this.who});

  factory SetPrime._decode(_i1.Input input) {
    return SetPrime(
      who: _i3.MultiAddress.codec.decode(input),
    );
  }

  final _i3.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_prime': {'who': who.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }
}

/// See [`Pallet::clear_prime`].
class ClearPrime extends Call {
  const ClearPrime();

  @override
  Map<String, dynamic> toJson() => {'clear_prime': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }
}
