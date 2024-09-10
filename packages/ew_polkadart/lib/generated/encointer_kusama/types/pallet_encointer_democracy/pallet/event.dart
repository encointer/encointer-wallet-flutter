// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../encointer_primitives/communities/community_identifier.dart'
    as _i7;
import '../../encointer_primitives/democracy/proposal_action.dart' as _i3;
import '../../encointer_primitives/democracy/proposal_state.dart' as _i5;
import '../../encointer_primitives/democracy/vote.dart' as _i4;
import '../../sp_runtime/dispatch_error_with_post_info.dart' as _i6;

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

  ProposalEnacted proposalEnacted({required BigInt proposalId}) {
    return ProposalEnacted(proposalId: proposalId);
  }

  ProposalSubmitted proposalSubmitted({
    required BigInt proposalId,
    required _i3.ProposalAction proposalAction,
  }) {
    return ProposalSubmitted(
      proposalId: proposalId,
      proposalAction: proposalAction,
    );
  }

  VotePlaced votePlaced({
    required BigInt proposalId,
    required _i4.Vote vote,
    required BigInt numVotes,
  }) {
    return VotePlaced(
      proposalId: proposalId,
      vote: vote,
      numVotes: numVotes,
    );
  }

  VoteFailed voteFailed({
    required BigInt proposalId,
    required _i4.Vote vote,
  }) {
    return VoteFailed(
      proposalId: proposalId,
      vote: vote,
    );
  }

  ProposalStateUpdated proposalStateUpdated({
    required BigInt proposalId,
    required _i5.ProposalState proposalState,
  }) {
    return ProposalStateUpdated(
      proposalId: proposalId,
      proposalState: proposalState,
    );
  }

  EnactmentFailed enactmentFailed({
    required BigInt proposalId,
    required _i6.DispatchErrorWithPostInfo reason,
  }) {
    return EnactmentFailed(
      proposalId: proposalId,
      reason: reason,
    );
  }

  PetitionApproved petitionApproved({
    _i7.CommunityIdentifier? cid,
    required List<int> text,
  }) {
    return PetitionApproved(
      cid: cid,
      text: text,
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
        return ProposalEnacted._decode(input);
      case 1:
        return ProposalSubmitted._decode(input);
      case 2:
        return VotePlaced._decode(input);
      case 3:
        return VoteFailed._decode(input);
      case 4:
        return ProposalStateUpdated._decode(input);
      case 5:
        return EnactmentFailed._decode(input);
      case 6:
        return PetitionApproved._decode(input);
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
      case ProposalEnacted:
        (value as ProposalEnacted).encodeTo(output);
        break;
      case ProposalSubmitted:
        (value as ProposalSubmitted).encodeTo(output);
        break;
      case VotePlaced:
        (value as VotePlaced).encodeTo(output);
        break;
      case VoteFailed:
        (value as VoteFailed).encodeTo(output);
        break;
      case ProposalStateUpdated:
        (value as ProposalStateUpdated).encodeTo(output);
        break;
      case EnactmentFailed:
        (value as EnactmentFailed).encodeTo(output);
        break;
      case PetitionApproved:
        (value as PetitionApproved).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case ProposalEnacted:
        return (value as ProposalEnacted)._sizeHint();
      case ProposalSubmitted:
        return (value as ProposalSubmitted)._sizeHint();
      case VotePlaced:
        return (value as VotePlaced)._sizeHint();
      case VoteFailed:
        return (value as VoteFailed)._sizeHint();
      case ProposalStateUpdated:
        return (value as ProposalStateUpdated)._sizeHint();
      case EnactmentFailed:
        return (value as EnactmentFailed)._sizeHint();
      case PetitionApproved:
        return (value as PetitionApproved)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// proposal enacted
class ProposalEnacted extends Event {
  const ProposalEnacted({required this.proposalId});

  factory ProposalEnacted._decode(_i1.Input input) {
    return ProposalEnacted(proposalId: _i1.U128Codec.codec.decode(input));
  }

  /// ProposalIdType
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'ProposalEnacted': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
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
      other is ProposalEnacted && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}

class ProposalSubmitted extends Event {
  const ProposalSubmitted({
    required this.proposalId,
    required this.proposalAction,
  });

  factory ProposalSubmitted._decode(_i1.Input input) {
    return ProposalSubmitted(
      proposalId: _i1.U128Codec.codec.decode(input),
      proposalAction: _i3.ProposalAction.codec.decode(input),
    );
  }

  /// ProposalIdType
  final BigInt proposalId;

  /// ProposalAction<T::AccountId, BalanceOf<T>>
  final _i3.ProposalAction proposalAction;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ProposalSubmitted': {
          'proposalId': proposalId,
          'proposalAction': proposalAction.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    size = size + _i3.ProposalAction.codec.sizeHint(proposalAction);
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
      other is ProposalSubmitted &&
          other.proposalId == proposalId &&
          other.proposalAction == proposalAction;

  @override
  int get hashCode => Object.hash(
        proposalId,
        proposalAction,
      );
}

class VotePlaced extends Event {
  const VotePlaced({
    required this.proposalId,
    required this.vote,
    required this.numVotes,
  });

  factory VotePlaced._decode(_i1.Input input) {
    return VotePlaced(
      proposalId: _i1.U128Codec.codec.decode(input),
      vote: _i4.Vote.codec.decode(input),
      numVotes: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ProposalIdType
  final BigInt proposalId;

  /// Vote
  final _i4.Vote vote;

  /// u128
  final BigInt numVotes;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VotePlaced': {
          'proposalId': proposalId,
          'vote': vote.toJson(),
          'numVotes': numVotes,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    size = size + _i4.Vote.codec.sizeHint(vote);
    size = size + _i1.U128Codec.codec.sizeHint(numVotes);
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
    _i4.Vote.codec.encodeTo(
      vote,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      numVotes,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VotePlaced &&
          other.proposalId == proposalId &&
          other.vote == vote &&
          other.numVotes == numVotes;

  @override
  int get hashCode => Object.hash(
        proposalId,
        vote,
        numVotes,
      );
}

class VoteFailed extends Event {
  const VoteFailed({
    required this.proposalId,
    required this.vote,
  });

  factory VoteFailed._decode(_i1.Input input) {
    return VoteFailed(
      proposalId: _i1.U128Codec.codec.decode(input),
      vote: _i4.Vote.codec.decode(input),
    );
  }

  /// ProposalIdType
  final BigInt proposalId;

  /// Vote
  final _i4.Vote vote;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VoteFailed': {
          'proposalId': proposalId,
          'vote': vote.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    size = size + _i4.Vote.codec.sizeHint(vote);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VoteFailed &&
          other.proposalId == proposalId &&
          other.vote == vote;

  @override
  int get hashCode => Object.hash(
        proposalId,
        vote,
      );
}

class ProposalStateUpdated extends Event {
  const ProposalStateUpdated({
    required this.proposalId,
    required this.proposalState,
  });

  factory ProposalStateUpdated._decode(_i1.Input input) {
    return ProposalStateUpdated(
      proposalId: _i1.U128Codec.codec.decode(input),
      proposalState: _i5.ProposalState.codec.decode(input),
    );
  }

  /// ProposalIdType
  final BigInt proposalId;

  /// ProposalState<T::Moment>
  final _i5.ProposalState proposalState;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ProposalStateUpdated': {
          'proposalId': proposalId,
          'proposalState': proposalState.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    size = size + _i5.ProposalState.codec.sizeHint(proposalState);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      proposalId,
      output,
    );
    _i5.ProposalState.codec.encodeTo(
      proposalState,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProposalStateUpdated &&
          other.proposalId == proposalId &&
          other.proposalState == proposalState;

  @override
  int get hashCode => Object.hash(
        proposalId,
        proposalState,
      );
}

class EnactmentFailed extends Event {
  const EnactmentFailed({
    required this.proposalId,
    required this.reason,
  });

  factory EnactmentFailed._decode(_i1.Input input) {
    return EnactmentFailed(
      proposalId: _i1.U128Codec.codec.decode(input),
      reason: _i6.DispatchErrorWithPostInfo.codec.decode(input),
    );
  }

  /// ProposalIdType
  final BigInt proposalId;

  /// DispatchErrorWithPostInfo
  final _i6.DispatchErrorWithPostInfo reason;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'EnactmentFailed': {
          'proposalId': proposalId,
          'reason': reason.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(proposalId);
    size = size + _i6.DispatchErrorWithPostInfo.codec.sizeHint(reason);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      proposalId,
      output,
    );
    _i6.DispatchErrorWithPostInfo.codec.encodeTo(
      reason,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EnactmentFailed &&
          other.proposalId == proposalId &&
          other.reason == reason;

  @override
  int get hashCode => Object.hash(
        proposalId,
        reason,
      );
}

class PetitionApproved extends Event {
  const PetitionApproved({
    this.cid,
    required this.text,
  });

  factory PetitionApproved._decode(_i1.Input input) {
    return PetitionApproved(
      cid: const _i1.OptionCodec<_i7.CommunityIdentifier>(
              _i7.CommunityIdentifier.codec)
          .decode(input),
      text: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// Option<CommunityIdentifier>
  final _i7.CommunityIdentifier? cid;

  /// PalletString
  final List<int> text;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PetitionApproved': {
          'cid': cid?.toJson(),
          'text': text,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i7.CommunityIdentifier>(
                _i7.CommunityIdentifier.codec)
            .sizeHint(cid);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(text);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.OptionCodec<_i7.CommunityIdentifier>(
            _i7.CommunityIdentifier.codec)
        .encodeTo(
      cid,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      text,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PetitionApproved &&
          other.cid == cid &&
          _i8.listsEqual(
            other.text,
            text,
          );

  @override
  int get hashCode => Object.hash(
        cid,
        text,
      );
}
