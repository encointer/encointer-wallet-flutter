// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../encointer_runtime/runtime_call.dart' as _i4;
import '../../primitive_types/h256.dart' as _i5;
import '../../sp_weights/weight_v2/weight.dart' as _i6;

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

  SetMembers setMembers({
    required List<_i3.AccountId32> newMembers,
    _i3.AccountId32? prime,
    required int oldCount,
  }) {
    return SetMembers(
      newMembers: newMembers,
      prime: prime,
      oldCount: oldCount,
    );
  }

  Execute execute({
    required _i4.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    return Execute(
      proposal: proposal,
      lengthBound: lengthBound,
    );
  }

  Propose propose({
    required BigInt threshold,
    required _i4.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    return Propose(
      threshold: threshold,
      proposal: proposal,
      lengthBound: lengthBound,
    );
  }

  Vote vote({
    required _i5.H256 proposal,
    required BigInt index,
    required bool approve,
  }) {
    return Vote(
      proposal: proposal,
      index: index,
      approve: approve,
    );
  }

  DisapproveProposal disapproveProposal({required _i5.H256 proposalHash}) {
    return DisapproveProposal(
      proposalHash: proposalHash,
    );
  }

  Close close({
    required _i5.H256 proposalHash,
    required BigInt index,
    required _i6.Weight proposalWeightBound,
    required BigInt lengthBound,
  }) {
    return Close(
      proposalHash: proposalHash,
      index: index,
      proposalWeightBound: proposalWeightBound,
      lengthBound: lengthBound,
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
        return SetMembers._decode(input);
      case 1:
        return Execute._decode(input);
      case 2:
        return Propose._decode(input);
      case 3:
        return Vote._decode(input);
      case 5:
        return DisapproveProposal._decode(input);
      case 6:
        return Close._decode(input);
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
      case SetMembers:
        (value as SetMembers).encodeTo(output);
        break;
      case Execute:
        (value as Execute).encodeTo(output);
        break;
      case Propose:
        (value as Propose).encodeTo(output);
        break;
      case Vote:
        (value as Vote).encodeTo(output);
        break;
      case DisapproveProposal:
        (value as DisapproveProposal).encodeTo(output);
        break;
      case Close:
        (value as Close).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetMembers:
        return (value as SetMembers)._sizeHint();
      case Execute:
        return (value as Execute)._sizeHint();
      case Propose:
        return (value as Propose)._sizeHint();
      case Vote:
        return (value as Vote)._sizeHint();
      case DisapproveProposal:
        return (value as DisapproveProposal)._sizeHint();
      case Close:
        return (value as Close)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::set_members`].
class SetMembers extends Call {
  const SetMembers({
    required this.newMembers,
    this.prime,
    required this.oldCount,
  });

  factory SetMembers._decode(_i1.Input input) {
    return SetMembers(
      newMembers: const _i1.SequenceCodec<_i3.AccountId32>(_i1.U8ArrayCodec(32)).decode(input),
      prime: const _i1.OptionCodec<_i3.AccountId32>(_i1.U8ArrayCodec(32)).decode(input),
      oldCount: _i1.U32Codec.codec.decode(input),
    );
  }

  final List<_i3.AccountId32> newMembers;

  final _i3.AccountId32? prime;

  final int oldCount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_members': {
          'newMembers': newMembers.map((value) => value.toList()).toList(),
          'prime': prime?.toList(),
          'oldCount': oldCount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i3.AccountId32>(_i1.U8ArrayCodec(32)).sizeHint(newMembers);
    size = size + const _i1.OptionCodec<_i3.AccountId32>(_i1.U8ArrayCodec(32)).sizeHint(prime);
    size = size + _i1.U32Codec.codec.sizeHint(oldCount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i1.U8ArrayCodec(32)).encodeTo(
      newMembers,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i1.U8ArrayCodec(32)).encodeTo(
      prime,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      oldCount,
      output,
    );
  }
}

/// See [`Pallet::execute`].
class Execute extends Call {
  const Execute({
    required this.proposal,
    required this.lengthBound,
  });

  factory Execute._decode(_i1.Input input) {
    return Execute(
      proposal: _i4.RuntimeCall.codec.decode(input),
      lengthBound: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final _i4.RuntimeCall proposal;

  final BigInt lengthBound;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'execute': {
          'proposal': proposal.toJson(),
          'lengthBound': lengthBound,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.RuntimeCall.codec.sizeHint(proposal);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lengthBound);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      proposal,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lengthBound,
      output,
    );
  }
}

/// See [`Pallet::propose`].
class Propose extends Call {
  const Propose({
    required this.threshold,
    required this.proposal,
    required this.lengthBound,
  });

  factory Propose._decode(_i1.Input input) {
    return Propose(
      threshold: _i1.CompactBigIntCodec.codec.decode(input),
      proposal: _i4.RuntimeCall.codec.decode(input),
      lengthBound: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt threshold;

  final _i4.RuntimeCall proposal;

  final BigInt lengthBound;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose': {
          'threshold': threshold,
          'proposal': proposal.toJson(),
          'lengthBound': lengthBound,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(threshold);
    size = size + _i4.RuntimeCall.codec.sizeHint(proposal);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lengthBound);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      threshold,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      proposal,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lengthBound,
      output,
    );
  }
}

/// See [`Pallet::vote`].
class Vote extends Call {
  const Vote({
    required this.proposal,
    required this.index,
    required this.approve,
  });

  factory Vote._decode(_i1.Input input) {
    return Vote(
      proposal: const _i1.U8ArrayCodec(32).decode(input),
      index: _i1.CompactBigIntCodec.codec.decode(input),
      approve: _i1.BoolCodec.codec.decode(input),
    );
  }

  final _i5.H256 proposal;

  final BigInt index;

  final bool approve;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'vote': {
          'proposal': proposal.toList(),
          'index': index,
          'approve': approve,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposal);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.BoolCodec.codec.sizeHint(approve);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposal,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      approve,
      output,
    );
  }
}

/// See [`Pallet::disapprove_proposal`].
class DisapproveProposal extends Call {
  const DisapproveProposal({required this.proposalHash});

  factory DisapproveProposal._decode(_i1.Input input) {
    return DisapproveProposal(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i5.H256 proposalHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'disapprove_proposal': {'proposalHash': proposalHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
  }
}

/// See [`Pallet::close`].
class Close extends Call {
  const Close({
    required this.proposalHash,
    required this.index,
    required this.proposalWeightBound,
    required this.lengthBound,
  });

  factory Close._decode(_i1.Input input) {
    return Close(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      index: _i1.CompactBigIntCodec.codec.decode(input),
      proposalWeightBound: _i6.Weight.codec.decode(input),
      lengthBound: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final _i5.H256 proposalHash;

  final BigInt index;

  final _i6.Weight proposalWeightBound;

  final BigInt lengthBound;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'close': {
          'proposalHash': proposalHash.toList(),
          'index': index,
          'proposalWeightBound': proposalWeightBound.toJson(),
          'lengthBound': lengthBound,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i6.Weight.codec.sizeHint(proposalWeightBound);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lengthBound);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i6.Weight.codec.encodeTo(
      proposalWeightBound,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lengthBound,
      output,
    );
  }
}
