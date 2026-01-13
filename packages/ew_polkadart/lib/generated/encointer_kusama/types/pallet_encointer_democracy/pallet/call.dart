// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../encointer_primitives/communities/community_identifier.dart' as _i6;
import '../../encointer_primitives/democracy/proposal_action.dart' as _i3;
import '../../encointer_primitives/democracy/vote.dart' as _i4;
import '../../tuples.dart' as _i5;

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

  SubmitProposal submitProposal({required _i3.ProposalAction proposalAction}) {
    return SubmitProposal(proposalAction: proposalAction);
  }

  Vote vote({
    required BigInt proposalId,
    required _i4.Vote vote,
    required List<_i5.Tuple2<_i6.CommunityIdentifier, int>> reputations,
  }) {
    return Vote(
      proposalId: proposalId,
      vote: vote,
      reputations: reputations,
    );
  }

  UpdateProposalState updateProposalState({required BigInt proposalId}) {
    return UpdateProposalState(proposalId: proposalId);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SubmitProposal._decode(input);
      case 1:
        return Vote._decode(input);
      case 2:
        return UpdateProposalState._decode(input);
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
      case SubmitProposal:
        (value as SubmitProposal).encodeTo(output);
        break;
      case Vote:
        (value as Vote).encodeTo(output);
        break;
      case UpdateProposalState:
        (value as UpdateProposalState).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SubmitProposal:
        return (value as SubmitProposal)._sizeHint();
      case Vote:
        return (value as Vote)._sizeHint();
      case UpdateProposalState:
        return (value as UpdateProposalState)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

class SubmitProposal extends Call {
  const SubmitProposal({required this.proposalAction});

  factory SubmitProposal._decode(_i1.Input input) {
    return SubmitProposal(proposalAction: _i3.ProposalAction.codec.decode(input));
  }

  /// Box<ProposalAction<T::AccountId, BalanceOf<T>, T::Moment,
  ///AssetKindOf<T>>,>
  final _i3.ProposalAction proposalAction;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'submit_proposal': {'proposalAction': proposalAction.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ProposalAction.codec.sizeHint(proposalAction);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ProposalAction.codec.encodeTo(
      proposalAction,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubmitProposal && other.proposalAction == proposalAction;

  @override
  int get hashCode => proposalAction.hashCode;
}

class Vote extends Call {
  const Vote({
    required this.proposalId,
    required this.vote,
    required this.reputations,
  });

  factory Vote._decode(_i1.Input input) {
    return Vote(
      proposalId: _i1.U128Codec.codec.decode(input),
      vote: _i4.Vote.codec.decode(input),
      reputations: const _i1.SequenceCodec<_i5.Tuple2<_i6.CommunityIdentifier, int>>(
          _i5.Tuple2Codec<_i6.CommunityIdentifier, int>(
        _i6.CommunityIdentifier.codec,
        _i1.U32Codec.codec,
      )).decode(input),
    );
  }

  /// ProposalIdType
  final BigInt proposalId;

  /// Vote
  final _i4.Vote vote;

  /// ReputationVecOf<T>
  final List<_i5.Tuple2<_i6.CommunityIdentifier, int>> reputations;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'vote': {
          'proposalId': proposalId,
          'vote': vote.toJson(),
          'reputations': reputations
              .map((value) => [
                    value.value0.toJson(),
                    value.value1,
                  ])
              .toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    size = size + _i4.Vote.codec.sizeHint(vote);
    size = size +
        const _i1.SequenceCodec<_i5.Tuple2<_i6.CommunityIdentifier, int>>(_i5.Tuple2Codec<_i6.CommunityIdentifier, int>(
          _i6.CommunityIdentifier.codec,
          _i1.U32Codec.codec,
        )).sizeHint(reputations);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      proposalId,
      output,
    );
    _i4.Vote.codec.encodeTo(
      vote,
      output,
    );
    const _i1.SequenceCodec<_i5.Tuple2<_i6.CommunityIdentifier, int>>(_i5.Tuple2Codec<_i6.CommunityIdentifier, int>(
      _i6.CommunityIdentifier.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      reputations,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Vote &&
          other.proposalId == proposalId &&
          other.vote == vote &&
          _i7.listsEqual(
            other.reputations,
            reputations,
          );

  @override
  int get hashCode => Object.hash(
        proposalId,
        vote,
        reputations,
      );
}

class UpdateProposalState extends Call {
  const UpdateProposalState({required this.proposalId});

  factory UpdateProposalState._decode(_i1.Input input) {
    return UpdateProposalState(proposalId: _i1.U128Codec.codec.decode(input));
  }

  /// ProposalIdType
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'update_proposal_state': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
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
      other is UpdateProposalState && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}
