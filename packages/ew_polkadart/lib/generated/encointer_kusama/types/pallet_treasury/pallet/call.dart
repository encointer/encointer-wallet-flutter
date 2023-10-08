// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
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
    return RejectProposal(
      proposalId: proposalId,
    );
  }

  ApproveProposal approveProposal({required BigInt proposalId}) {
    return ApproveProposal(
      proposalId: proposalId,
    );
  }

  Spend spend({
    required BigInt amount,
    required _i3.MultiAddress beneficiary,
  }) {
    return Spend(
      amount: amount,
      beneficiary: beneficiary,
    );
  }

  RemoveApproval removeApproval({required BigInt proposalId}) {
    return RemoveApproval(
      proposalId: proposalId,
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
        return ProposeSpend._decode(input);
      case 1:
        return RejectProposal._decode(input);
      case 2:
        return ApproveProposal._decode(input);
      case 3:
        return Spend._decode(input);
      case 4:
        return RemoveApproval._decode(input);
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
      case Spend:
        (value as Spend).encodeTo(output);
        break;
      case RemoveApproval:
        (value as RemoveApproval).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
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
      case Spend:
        return (value as Spend)._sizeHint();
      case RemoveApproval:
        return (value as RemoveApproval)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
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

  final BigInt value;

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
}

/// See [`Pallet::reject_proposal`].
class RejectProposal extends Call {
  const RejectProposal({required this.proposalId});

  factory RejectProposal._decode(_i1.Input input) {
    return RejectProposal(
      proposalId: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

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
}

/// See [`Pallet::approve_proposal`].
class ApproveProposal extends Call {
  const ApproveProposal({required this.proposalId});

  factory ApproveProposal._decode(_i1.Input input) {
    return ApproveProposal(
      proposalId: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

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
}

/// See [`Pallet::spend`].
class Spend extends Call {
  const Spend({
    required this.amount,
    required this.beneficiary,
  });

  factory Spend._decode(_i1.Input input) {
    return Spend(
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  final BigInt amount;

  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'spend': {
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
}

/// See [`Pallet::remove_approval`].
class RemoveApproval extends Call {
  const RemoveApproval({required this.proposalId});

  factory RemoveApproval._decode(_i1.Input input) {
    return RemoveApproval(
      proposalId: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

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
}
