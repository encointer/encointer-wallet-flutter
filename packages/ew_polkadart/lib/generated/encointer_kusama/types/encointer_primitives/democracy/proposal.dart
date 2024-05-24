// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'proposal_action.dart' as _i2;
import 'proposal_state.dart' as _i3;

class Proposal {
  const Proposal({
    required this.start,
    required this.startCindex,
    required this.action,
    required this.state,
    required this.electorateSize,
  });

  factory Proposal.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Moment
  final BigInt start;

  /// CeremonyIndexType
  final int startCindex;

  /// ProposalAction
  final _i2.ProposalAction action;

  /// ProposalState<Moment>
  final _i3.ProposalState state;

  /// ReputationCountType
  final BigInt electorateSize;

  static const $ProposalCodec codec = $ProposalCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'start': start,
        'startCindex': startCindex,
        'action': action.toJson(),
        'state': state.toJson(),
        'electorateSize': electorateSize,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Proposal &&
          other.start == start &&
          other.startCindex == startCindex &&
          other.action == action &&
          other.state == state &&
          other.electorateSize == electorateSize;

  @override
  int get hashCode => Object.hash(
        start,
        startCindex,
        action,
        state,
        electorateSize,
      );
}

class $ProposalCodec with _i1.Codec<Proposal> {
  const $ProposalCodec();

  @override
  void encodeTo(
    Proposal obj,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      obj.start,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.startCindex,
      output,
    );
    _i2.ProposalAction.codec.encodeTo(
      obj.action,
      output,
    );
    _i3.ProposalState.codec.encodeTo(
      obj.state,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.electorateSize,
      output,
    );
  }

  @override
  Proposal decode(_i1.Input input) {
    return Proposal(
      start: _i1.U64Codec.codec.decode(input),
      startCindex: _i1.U32Codec.codec.decode(input),
      action: _i2.ProposalAction.codec.decode(input),
      state: _i3.ProposalState.codec.decode(input),
      electorateSize: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Proposal obj) {
    int size = 0;
    size = size + _i1.U64Codec.codec.sizeHint(obj.start);
    size = size + _i1.U32Codec.codec.sizeHint(obj.startCindex);
    size = size + _i2.ProposalAction.codec.sizeHint(obj.action);
    size = size + _i3.ProposalState.codec.sizeHint(obj.state);
    size = size + _i1.U128Codec.codec.sizeHint(obj.electorateSize);
    return size;
  }
}
