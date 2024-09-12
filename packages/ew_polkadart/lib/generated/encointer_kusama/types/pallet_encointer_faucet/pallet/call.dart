// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../encointer_primitives/communities/community_identifier.dart' as _i3;
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

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  CreateFaucet createFaucet({
    required List<int> name,
    required BigInt amount,
    List<_i3.CommunityIdentifier>? whitelist,
    required BigInt dripAmount,
  }) {
    return CreateFaucet(
      name: name,
      amount: amount,
      whitelist: whitelist,
      dripAmount: dripAmount,
    );
  }

  Drip drip({
    required _i4.AccountId32 faucetAccount,
    required _i3.CommunityIdentifier cid,
    required int cindex,
  }) {
    return Drip(
      faucetAccount: faucetAccount,
      cid: cid,
      cindex: cindex,
    );
  }

  DissolveFaucet dissolveFaucet({
    required _i4.AccountId32 faucetAccount,
    required _i4.AccountId32 beneficiary,
  }) {
    return DissolveFaucet(
      faucetAccount: faucetAccount,
      beneficiary: beneficiary,
    );
  }

  CloseFaucet closeFaucet({required _i4.AccountId32 faucetAccount}) {
    return CloseFaucet(faucetAccount: faucetAccount);
  }

  SetReserveAmount setReserveAmount({required BigInt reserveAmount}) {
    return SetReserveAmount(reserveAmount: reserveAmount);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return CreateFaucet._decode(input);
      case 1:
        return Drip._decode(input);
      case 2:
        return DissolveFaucet._decode(input);
      case 3:
        return CloseFaucet._decode(input);
      case 4:
        return SetReserveAmount._decode(input);
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
      case CreateFaucet:
        (value as CreateFaucet).encodeTo(output);
        break;
      case Drip:
        (value as Drip).encodeTo(output);
        break;
      case DissolveFaucet:
        (value as DissolveFaucet).encodeTo(output);
        break;
      case CloseFaucet:
        (value as CloseFaucet).encodeTo(output);
        break;
      case SetReserveAmount:
        (value as SetReserveAmount).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case CreateFaucet:
        return (value as CreateFaucet)._sizeHint();
      case Drip:
        return (value as Drip)._sizeHint();
      case DissolveFaucet:
        return (value as DissolveFaucet)._sizeHint();
      case CloseFaucet:
        return (value as CloseFaucet)._sizeHint();
      case SetReserveAmount:
        return (value as SetReserveAmount)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class CreateFaucet extends Call {
  const CreateFaucet({
    required this.name,
    required this.amount,
    this.whitelist,
    required this.dripAmount,
  });

  factory CreateFaucet._decode(_i1.Input input) {
    return CreateFaucet(
      name: _i1.U8SequenceCodec.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
      whitelist: const _i1.OptionCodec<List<_i3.CommunityIdentifier>>(
              _i1.SequenceCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec))
          .decode(input),
      dripAmount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// FaucetNameType
  final List<int> name;

  /// BalanceOf<T>
  final BigInt amount;

  /// Option<WhiteListType>
  final List<_i3.CommunityIdentifier>? whitelist;

  /// BalanceOf<T>
  final BigInt dripAmount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create_faucet': {
          'name': name,
          'amount': amount,
          'whitelist': whitelist?.map((value) => value.toJson()).toList(),
          'dripAmount': dripAmount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(name);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    size = size +
        const _i1.OptionCodec<List<_i3.CommunityIdentifier>>(
                _i1.SequenceCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec))
            .sizeHint(whitelist);
    size = size + _i1.U128Codec.codec.sizeHint(dripAmount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      name,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
    const _i1.OptionCodec<List<_i3.CommunityIdentifier>>(
            _i1.SequenceCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec))
        .encodeTo(
      whitelist,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      dripAmount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CreateFaucet &&
          _i5.listsEqual(
            other.name,
            name,
          ) &&
          other.amount == amount &&
          other.whitelist == whitelist &&
          other.dripAmount == dripAmount;

  @override
  int get hashCode => Object.hash(
        name,
        amount,
        whitelist,
        dripAmount,
      );
}

class Drip extends Call {
  const Drip({
    required this.faucetAccount,
    required this.cid,
    required this.cindex,
  });

  factory Drip._decode(_i1.Input input) {
    return Drip(
      faucetAccount: const _i1.U8ArrayCodec(32).decode(input),
      cid: _i3.CommunityIdentifier.codec.decode(input),
      cindex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 faucetAccount;

  /// CommunityIdentifier
  final _i3.CommunityIdentifier cid;

  /// CeremonyIndexType
  final int cindex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'drip': {
          'faucetAccount': faucetAccount.toList(),
          'cid': cid.toJson(),
          'cindex': cindex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(faucetAccount);
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U32Codec.codec.sizeHint(cindex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      faucetAccount,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      cindex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Drip &&
          _i5.listsEqual(
            other.faucetAccount,
            faucetAccount,
          ) &&
          other.cid == cid &&
          other.cindex == cindex;

  @override
  int get hashCode => Object.hash(
        faucetAccount,
        cid,
        cindex,
      );
}

class DissolveFaucet extends Call {
  const DissolveFaucet({
    required this.faucetAccount,
    required this.beneficiary,
  });

  factory DissolveFaucet._decode(_i1.Input input) {
    return DissolveFaucet(
      faucetAccount: const _i1.U8ArrayCodec(32).decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 faucetAccount;

  /// T::AccountId
  final _i4.AccountId32 beneficiary;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'dissolve_faucet': {
          'faucetAccount': faucetAccount.toList(),
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(faucetAccount);
    size = size + const _i4.AccountId32Codec().sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      faucetAccount,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DissolveFaucet &&
          _i5.listsEqual(
            other.faucetAccount,
            faucetAccount,
          ) &&
          _i5.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        faucetAccount,
        beneficiary,
      );
}

class CloseFaucet extends Call {
  const CloseFaucet({required this.faucetAccount});

  factory CloseFaucet._decode(_i1.Input input) {
    return CloseFaucet(faucetAccount: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i4.AccountId32 faucetAccount;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'close_faucet': {'faucetAccount': faucetAccount.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(faucetAccount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      faucetAccount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CloseFaucet &&
          _i5.listsEqual(
            other.faucetAccount,
            faucetAccount,
          );

  @override
  int get hashCode => faucetAccount.hashCode;
}

class SetReserveAmount extends Call {
  const SetReserveAmount({required this.reserveAmount});

  factory SetReserveAmount._decode(_i1.Input input) {
    return SetReserveAmount(reserveAmount: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt reserveAmount;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_reserve_amount': {'reserveAmount': reserveAmount}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(reserveAmount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      reserveAmount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetReserveAmount && other.reserveAmount == reserveAmount;

  @override
  int get hashCode => reserveAmount.hashCode;
}
