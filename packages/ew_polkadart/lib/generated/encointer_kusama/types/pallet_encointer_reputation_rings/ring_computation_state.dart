// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../encointer_primitives/communities/community_identifier.dart' as _i2;
import '../sp_core/crypto/account_id32.dart' as _i5;
import '../tuples.dart' as _i4;
import 'ring_computation_phase.dart' as _i3;

class RingComputationState {
  const RingComputationState({
    required this.community,
    required this.ceremonyIndex,
    required this.phase,
    required this.attendance,
  });

  factory RingComputationState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CommunityIdentifier
  final _i2.CommunityIdentifier community;

  /// CeremonyIndexType
  final int ceremonyIndex;

  /// RingComputationPhase
  final _i3.RingComputationPhase phase;

  /// Vec<(AccountId, u8)>
  final List<_i4.Tuple2<_i5.AccountId32, int>> attendance;

  static const $RingComputationStateCodec codec = $RingComputationStateCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'community': community.toJson(),
        'ceremonyIndex': ceremonyIndex,
        'phase': phase.toJson(),
        'attendance': attendance
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RingComputationState &&
          other.community == community &&
          other.ceremonyIndex == ceremonyIndex &&
          other.phase == phase &&
          _i7.listsEqual(
            other.attendance,
            attendance,
          );

  @override
  int get hashCode => Object.hash(
        community,
        ceremonyIndex,
        phase,
        attendance,
      );
}

class $RingComputationStateCodec with _i1.Codec<RingComputationState> {
  const $RingComputationStateCodec();

  @override
  void encodeTo(
    RingComputationState obj,
    _i1.Output output,
  ) {
    _i2.CommunityIdentifier.codec.encodeTo(
      obj.community,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.ceremonyIndex,
      output,
    );
    _i3.RingComputationPhase.codec.encodeTo(
      obj.phase,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<_i5.AccountId32, int>>(_i4.Tuple2Codec<_i5.AccountId32, int>(
      _i5.AccountId32Codec(),
      _i1.U8Codec.codec,
    )).encodeTo(
      obj.attendance,
      output,
    );
  }

  @override
  RingComputationState decode(_i1.Input input) {
    return RingComputationState(
      community: _i2.CommunityIdentifier.codec.decode(input),
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
      phase: _i3.RingComputationPhase.codec.decode(input),
      attendance: const _i1.SequenceCodec<_i4.Tuple2<_i5.AccountId32, int>>(_i4.Tuple2Codec<_i5.AccountId32, int>(
        _i5.AccountId32Codec(),
        _i1.U8Codec.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(RingComputationState obj) {
    int size = 0;
    size = size + _i2.CommunityIdentifier.codec.sizeHint(obj.community);
    size = size + _i1.U32Codec.codec.sizeHint(obj.ceremonyIndex);
    size = size + _i3.RingComputationPhase.codec.sizeHint(obj.phase);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<_i5.AccountId32, int>>(_i4.Tuple2Codec<_i5.AccountId32, int>(
          _i5.AccountId32Codec(),
          _i1.U8Codec.codec,
        )).sizeHint(obj.attendance);
    return size;
  }
}
