// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

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

  ProposeSpend proposeSpend({
    required BigInt value,
    required _i3.MultiAddress beneficiary,
  }) {
    return ProposeSpend(
      value: value,
      beneficiary: beneficiary,
    );
  }

  RejectProposal rejectProposal({required BigInt proposalId}) {
    return RejectProposal(proposalId: proposalId);
  }

  ApproveProposal approveProposal({required BigInt proposalId}) {
    return ApproveProposal(proposalId: proposalId);
  }

  SpendLocal spendLocal({
    required BigInt amount,
    required _i3.MultiAddress beneficiary,
  }) {
    return SpendLocal(
      amount: amount,
      beneficiary: beneficiary,
    );
  }

  RemoveApproval removeApproval({required BigInt proposalId}) {
    return RemoveApproval(proposalId: proposalId);
  }

  Spend spend({
    required dynamic assetKind,
    required BigInt amount,
    required _i4.AccountId32 beneficiary,
    int? validFrom,
  }) {
    return Spend(
      assetKind: assetKind,
      amount: amount,
      beneficiary: beneficiary,
      validFrom: validFrom,
    );
  }

  Payout payout({required int index}) {
    return Payout(index: index);
  }

  CheckStatus checkStatus({required int index}) {
    return CheckStatus(index: index);
  }

  VoidSpend voidSpend({required int index}) {
    return VoidSpend(index: index);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ProposeSpend._decode(input);
      case 1:
        return RejectProposal._decode(input);
      case 2:
        return ApproveProposal._decode(input);
      case 3:
        return SpendLocal._decode(input);
      case 4:
        return RemoveApproval._decode(input);
      case 5:
        return Spend._decode(input);
      case 6:
        return Payout._decode(input);
      case 7:
        return CheckStatus._decode(input);
      case 8:
        return VoidSpend._decode(input);
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
      case ProposeSpend:
        (value as ProposeSpend).encodeTo(output);
        break;
      case RejectProposal:
        (value as RejectProposal).encodeTo(output);
        break;
      case ApproveProposal:
        (value as ApproveProposal).encodeTo(output);
        break;
      case SpendLocal:
        (value as SpendLocal).encodeTo(output);
        break;
      case RemoveApproval:
        (value as RemoveApproval).encodeTo(output);
        break;
      case Spend:
        (value as Spend).encodeTo(output);
        break;
      case Payout:
        (value as Payout).encodeTo(output);
        break;
      case CheckStatus:
        (value as CheckStatus).encodeTo(output);
        break;
      case VoidSpend:
        (value as VoidSpend).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ProposeSpend:
        return (value as ProposeSpend)._sizeHint();
      case RejectProposal:
        return (value as RejectProposal)._sizeHint();
      case ApproveProposal:
        return (value as ApproveProposal)._sizeHint();
      case SpendLocal:
        return (value as SpendLocal)._sizeHint();
      case RemoveApproval:
        return (value as RemoveApproval)._sizeHint();
      case Spend:
        return (value as Spend)._sizeHint();
      case Payout:
        return (value as Payout)._sizeHint();
      case CheckStatus:
        return (value as CheckStatus)._sizeHint();
      case VoidSpend:
        return (value as VoidSpend)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::propose_spend`].
class ProposeSpend extends Call {
  const ProposeSpend({
    required this.value,
    required this.beneficiary,
  });

  factory ProposeSpend._decode(_i1.Input input) {
    return ProposeSpend(
      value: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// BalanceOf<T, I>
  final BigInt value;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose_spend': {
          'value': value,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
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
      other is ProposeSpend && other.value == value && other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        value,
        beneficiary,
      );
}

/// See [`Pallet::reject_proposal`].
class RejectProposal extends Call {
  const RejectProposal({required this.proposalId});

  factory RejectProposal._decode(_i1.Input input) {
    return RejectProposal(proposalId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ProposalIndex
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'reject_proposal': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      proposalId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RejectProposal && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}

/// See [`Pallet::approve_proposal`].
class ApproveProposal extends Call {
  const ApproveProposal({required this.proposalId});

  factory ApproveProposal._decode(_i1.Input input) {
    return ApproveProposal(proposalId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ProposalIndex
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'approve_proposal': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      proposalId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApproveProposal && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}

/// See [`Pallet::spend_local`].
class SpendLocal extends Call {
  const SpendLocal({
    required this.amount,
    required this.beneficiary,
  });

  factory SpendLocal._decode(_i1.Input input) {
    return SpendLocal(
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// BalanceOf<T, I>
  final BigInt amount;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'spend_local': {
          'amount': amount,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
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
      other is SpendLocal && other.amount == amount && other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        amount,
        beneficiary,
      );
}

/// See [`Pallet::remove_approval`].
class RemoveApproval extends Call {
  const RemoveApproval({required this.proposalId});

  factory RemoveApproval._decode(_i1.Input input) {
    return RemoveApproval(proposalId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ProposalIndex
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'remove_approval': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      proposalId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveApproval && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}

/// See [`Pallet::spend`].
class Spend extends Call {
  const Spend({
    required this.assetKind,
    required this.amount,
    required this.beneficiary,
    this.validFrom,
  });

  factory Spend._decode(_i1.Input input) {
    return Spend(
      assetKind: _i1.NullCodec.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
      validFrom: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// Box<T::AssetKind>
  final dynamic assetKind;

  /// AssetBalanceOf<T, I>
  final BigInt amount;

  /// Box<BeneficiaryLookupOf<T, I>>
  final _i4.AccountId32 beneficiary;

  /// Option<BlockNumberFor<T>>
  final int? validFrom;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'spend': {
          'assetKind': null,
          'amount': amount,
          'beneficiary': beneficiary.toList(),
          'validFrom': validFrom,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.NullCodec.codec.sizeHint(assetKind);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    size = size + const _i4.AccountId32Codec().sizeHint(beneficiary);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(validFrom);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
      assetKind,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      validFrom,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Spend &&
          other.assetKind == assetKind &&
          other.amount == amount &&
          _i5.listsEqual(
            other.beneficiary,
            beneficiary,
          ) &&
          other.validFrom == validFrom;

  @override
  int get hashCode => Object.hash(
        assetKind,
        amount,
        beneficiary,
        validFrom,
      );
}

/// See [`Pallet::payout`].
class Payout extends Call {
  const Payout({required this.index});

  factory Payout._decode(_i1.Input input) {
    return Payout(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'payout': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Payout && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// See [`Pallet::check_status`].
class CheckStatus extends Call {
  const CheckStatus({required this.index});

  factory CheckStatus._decode(_i1.Input input) {
    return CheckStatus(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'check_status': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CheckStatus && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// See [`Pallet::void_spend`].
class VoidSpend extends Call {
  const VoidSpend({required this.index});

  factory VoidSpend._decode(_i1.Input input) {
    return VoidSpend(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'void_spend': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VoidSpend && other.index == index;

  @override
  int get hashCode => index.hashCode;
}
