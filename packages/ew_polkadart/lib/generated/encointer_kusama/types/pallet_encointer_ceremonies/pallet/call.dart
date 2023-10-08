// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/communities/community_identifier.dart'
    as _i3;
import '../../encointer_primitives/ceremonies/proof_of_attendance.dart' as _i4;
import '../../tuples.dart' as _i5;
import '../../sp_core/crypto/account_id32.dart' as _i6;

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

  RegisterParticipant registerParticipant({
    required _i3.CommunityIdentifier cid,
    _i4.ProofOfAttendance? proof,
  }) {
    return RegisterParticipant(
      cid: cid,
      proof: proof,
    );
  }

  UpgradeRegistration upgradeRegistration({
    required _i3.CommunityIdentifier cid,
    required _i4.ProofOfAttendance proof,
  }) {
    return UpgradeRegistration(
      cid: cid,
      proof: proof,
    );
  }

  UnregisterParticipant unregisterParticipant({
    required _i3.CommunityIdentifier cid,
    _i5.Tuple2<_i3.CommunityIdentifier, int>? maybeReputationCommunityCeremony,
  }) {
    return UnregisterParticipant(
      cid: cid,
      maybeReputationCommunityCeremony: maybeReputationCommunityCeremony,
    );
  }

  AttestAttendees attestAttendees({
    required _i3.CommunityIdentifier cid,
    required int numberOfParticipantsVote,
    required List<_i6.AccountId32> attestations,
  }) {
    return AttestAttendees(
      cid: cid,
      numberOfParticipantsVote: numberOfParticipantsVote,
      attestations: attestations,
    );
  }

  EndorseNewcomer endorseNewcomer({
    required _i3.CommunityIdentifier cid,
    required _i6.AccountId32 newbie,
  }) {
    return EndorseNewcomer(
      cid: cid,
      newbie: newbie,
    );
  }

  ClaimRewards claimRewards({
    required _i3.CommunityIdentifier cid,
    BigInt? maybeMeetupIndex,
  }) {
    return ClaimRewards(
      cid: cid,
      maybeMeetupIndex: maybeMeetupIndex,
    );
  }

  SetInactivityTimeout setInactivityTimeout({required int inactivityTimeout}) {
    return SetInactivityTimeout(
      inactivityTimeout: inactivityTimeout,
    );
  }

  SetEndorsementTicketsPerBootstrapper setEndorsementTicketsPerBootstrapper(
      {required int endorsementTicketsPerBootstrapper}) {
    return SetEndorsementTicketsPerBootstrapper(
      endorsementTicketsPerBootstrapper: endorsementTicketsPerBootstrapper,
    );
  }

  SetEndorsementTicketsPerReputable setEndorsementTicketsPerReputable(
      {required int endorsementTicketsPerReputable}) {
    return SetEndorsementTicketsPerReputable(
      endorsementTicketsPerReputable: endorsementTicketsPerReputable,
    );
  }

  SetReputationLifetime setReputationLifetime(
      {required int reputationLifetime}) {
    return SetReputationLifetime(
      reputationLifetime: reputationLifetime,
    );
  }

  SetMeetupTimeOffset setMeetupTimeOffset({required int meetupTimeOffset}) {
    return SetMeetupTimeOffset(
      meetupTimeOffset: meetupTimeOffset,
    );
  }

  SetTimeTolerance setTimeTolerance({required BigInt timeTolerance}) {
    return SetTimeTolerance(
      timeTolerance: timeTolerance,
    );
  }

  SetLocationTolerance setLocationTolerance({required int locationTolerance}) {
    return SetLocationTolerance(
      locationTolerance: locationTolerance,
    );
  }

  PurgeCommunityCeremony purgeCommunityCeremony(
      {required _i5.Tuple2<_i3.CommunityIdentifier, int> communityCeremony}) {
    return PurgeCommunityCeremony(
      communityCeremony: communityCeremony,
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
        return RegisterParticipant._decode(input);
      case 1:
        return UpgradeRegistration._decode(input);
      case 2:
        return UnregisterParticipant._decode(input);
      case 3:
        return AttestAttendees._decode(input);
      case 4:
        return EndorseNewcomer._decode(input);
      case 5:
        return ClaimRewards._decode(input);
      case 6:
        return SetInactivityTimeout._decode(input);
      case 7:
        return SetEndorsementTicketsPerBootstrapper._decode(input);
      case 8:
        return SetEndorsementTicketsPerReputable._decode(input);
      case 9:
        return SetReputationLifetime._decode(input);
      case 10:
        return SetMeetupTimeOffset._decode(input);
      case 11:
        return SetTimeTolerance._decode(input);
      case 12:
        return SetLocationTolerance._decode(input);
      case 13:
        return PurgeCommunityCeremony._decode(input);
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
      case RegisterParticipant:
        (value as RegisterParticipant).encodeTo(output);
        break;
      case UpgradeRegistration:
        (value as UpgradeRegistration).encodeTo(output);
        break;
      case UnregisterParticipant:
        (value as UnregisterParticipant).encodeTo(output);
        break;
      case AttestAttendees:
        (value as AttestAttendees).encodeTo(output);
        break;
      case EndorseNewcomer:
        (value as EndorseNewcomer).encodeTo(output);
        break;
      case ClaimRewards:
        (value as ClaimRewards).encodeTo(output);
        break;
      case SetInactivityTimeout:
        (value as SetInactivityTimeout).encodeTo(output);
        break;
      case SetEndorsementTicketsPerBootstrapper:
        (value as SetEndorsementTicketsPerBootstrapper).encodeTo(output);
        break;
      case SetEndorsementTicketsPerReputable:
        (value as SetEndorsementTicketsPerReputable).encodeTo(output);
        break;
      case SetReputationLifetime:
        (value as SetReputationLifetime).encodeTo(output);
        break;
      case SetMeetupTimeOffset:
        (value as SetMeetupTimeOffset).encodeTo(output);
        break;
      case SetTimeTolerance:
        (value as SetTimeTolerance).encodeTo(output);
        break;
      case SetLocationTolerance:
        (value as SetLocationTolerance).encodeTo(output);
        break;
      case PurgeCommunityCeremony:
        (value as PurgeCommunityCeremony).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case RegisterParticipant:
        return (value as RegisterParticipant)._sizeHint();
      case UpgradeRegistration:
        return (value as UpgradeRegistration)._sizeHint();
      case UnregisterParticipant:
        return (value as UnregisterParticipant)._sizeHint();
      case AttestAttendees:
        return (value as AttestAttendees)._sizeHint();
      case EndorseNewcomer:
        return (value as EndorseNewcomer)._sizeHint();
      case ClaimRewards:
        return (value as ClaimRewards)._sizeHint();
      case SetInactivityTimeout:
        return (value as SetInactivityTimeout)._sizeHint();
      case SetEndorsementTicketsPerBootstrapper:
        return (value as SetEndorsementTicketsPerBootstrapper)._sizeHint();
      case SetEndorsementTicketsPerReputable:
        return (value as SetEndorsementTicketsPerReputable)._sizeHint();
      case SetReputationLifetime:
        return (value as SetReputationLifetime)._sizeHint();
      case SetMeetupTimeOffset:
        return (value as SetMeetupTimeOffset)._sizeHint();
      case SetTimeTolerance:
        return (value as SetTimeTolerance)._sizeHint();
      case SetLocationTolerance:
        return (value as SetLocationTolerance)._sizeHint();
      case PurgeCommunityCeremony:
        return (value as PurgeCommunityCeremony)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::register_participant`].
class RegisterParticipant extends Call {
  const RegisterParticipant({
    required this.cid,
    this.proof,
  });

  factory RegisterParticipant._decode(_i1.Input input) {
    return RegisterParticipant(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      proof: const _i1.OptionCodec<_i4.ProofOfAttendance>(
              _i4.ProofOfAttendance.codec)
          .decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final _i4.ProofOfAttendance? proof;

  @override
  Map<String, Map<String, Map<String, dynamic>?>> toJson() => {
        'register_participant': {
          'cid': cid.toJson(),
          'proof': proof?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size +
        const _i1.OptionCodec<_i4.ProofOfAttendance>(
                _i4.ProofOfAttendance.codec)
            .sizeHint(proof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.OptionCodec<_i4.ProofOfAttendance>(_i4.ProofOfAttendance.codec)
        .encodeTo(
      proof,
      output,
    );
  }
}

/// See [`Pallet::upgrade_registration`].
class UpgradeRegistration extends Call {
  const UpgradeRegistration({
    required this.cid,
    required this.proof,
  });

  factory UpgradeRegistration._decode(_i1.Input input) {
    return UpgradeRegistration(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      proof: _i4.ProofOfAttendance.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final _i4.ProofOfAttendance proof;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'upgrade_registration': {
          'cid': cid.toJson(),
          'proof': proof.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i4.ProofOfAttendance.codec.sizeHint(proof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i4.ProofOfAttendance.codec.encodeTo(
      proof,
      output,
    );
  }
}

/// See [`Pallet::unregister_participant`].
class UnregisterParticipant extends Call {
  const UnregisterParticipant({
    required this.cid,
    this.maybeReputationCommunityCeremony,
  });

  factory UnregisterParticipant._decode(_i1.Input input) {
    return UnregisterParticipant(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      maybeReputationCommunityCeremony:
          const _i1.OptionCodec<_i5.Tuple2<_i3.CommunityIdentifier, int>>(
              _i5.Tuple2Codec<_i3.CommunityIdentifier, int>(
        _i3.CommunityIdentifier.codec,
        _i1.U32Codec.codec,
      )).decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final _i5.Tuple2<_i3.CommunityIdentifier, int>?
      maybeReputationCommunityCeremony;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'unregister_participant': {
          'cid': cid.toJson(),
          'maybeReputationCommunityCeremony': [
            maybeReputationCommunityCeremony?.value0.toJson(),
            maybeReputationCommunityCeremony?.value1,
          ],
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size +
        const _i1.OptionCodec<_i5.Tuple2<_i3.CommunityIdentifier, int>>(
            _i5.Tuple2Codec<_i3.CommunityIdentifier, int>(
          _i3.CommunityIdentifier.codec,
          _i1.U32Codec.codec,
        )).sizeHint(maybeReputationCommunityCeremony);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.OptionCodec<_i5.Tuple2<_i3.CommunityIdentifier, int>>(
        _i5.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      maybeReputationCommunityCeremony,
      output,
    );
  }
}

/// See [`Pallet::attest_attendees`].
class AttestAttendees extends Call {
  const AttestAttendees({
    required this.cid,
    required this.numberOfParticipantsVote,
    required this.attestations,
  });

  factory AttestAttendees._decode(_i1.Input input) {
    return AttestAttendees(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      numberOfParticipantsVote: _i1.U32Codec.codec.decode(input),
      attestations:
          const _i1.SequenceCodec<_i6.AccountId32>(_i1.U8ArrayCodec(32))
              .decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final int numberOfParticipantsVote;

  final List<_i6.AccountId32> attestations;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'attest_attendees': {
          'cid': cid.toJson(),
          'numberOfParticipantsVote': numberOfParticipantsVote,
          'attestations': attestations.map((value) => value.toList()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U32Codec.codec.sizeHint(numberOfParticipantsVote);
    size = size +
        const _i1.SequenceCodec<_i6.AccountId32>(_i1.U8ArrayCodec(32))
            .sizeHint(attestations);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numberOfParticipantsVote,
      output,
    );
    const _i1.SequenceCodec<_i6.AccountId32>(_i1.U8ArrayCodec(32)).encodeTo(
      attestations,
      output,
    );
  }
}

/// See [`Pallet::endorse_newcomer`].
class EndorseNewcomer extends Call {
  const EndorseNewcomer({
    required this.cid,
    required this.newbie,
  });

  factory EndorseNewcomer._decode(_i1.Input input) {
    return EndorseNewcomer(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      newbie: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final _i6.AccountId32 newbie;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'endorse_newcomer': {
          'cid': cid.toJson(),
          'newbie': newbie.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(newbie);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      newbie,
      output,
    );
  }
}

/// See [`Pallet::claim_rewards`].
class ClaimRewards extends Call {
  const ClaimRewards({
    required this.cid,
    this.maybeMeetupIndex,
  });

  factory ClaimRewards._decode(_i1.Input input) {
    return ClaimRewards(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      maybeMeetupIndex:
          const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final BigInt? maybeMeetupIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'claim_rewards': {
          'cid': cid.toJson(),
          'maybeMeetupIndex': maybeMeetupIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size +
        const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec)
            .sizeHint(maybeMeetupIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).encodeTo(
      maybeMeetupIndex,
      output,
    );
  }
}

/// See [`Pallet::set_inactivity_timeout`].
class SetInactivityTimeout extends Call {
  const SetInactivityTimeout({required this.inactivityTimeout});

  factory SetInactivityTimeout._decode(_i1.Input input) {
    return SetInactivityTimeout(
      inactivityTimeout: _i1.U32Codec.codec.decode(input),
    );
  }

  final int inactivityTimeout;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_inactivity_timeout': {'inactivityTimeout': inactivityTimeout}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(inactivityTimeout);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      inactivityTimeout,
      output,
    );
  }
}

/// See [`Pallet::set_endorsement_tickets_per_bootstrapper`].
class SetEndorsementTicketsPerBootstrapper extends Call {
  const SetEndorsementTicketsPerBootstrapper(
      {required this.endorsementTicketsPerBootstrapper});

  factory SetEndorsementTicketsPerBootstrapper._decode(_i1.Input input) {
    return SetEndorsementTicketsPerBootstrapper(
      endorsementTicketsPerBootstrapper: _i1.U8Codec.codec.decode(input),
    );
  }

  final int endorsementTicketsPerBootstrapper;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_endorsement_tickets_per_bootstrapper': {
          'endorsementTicketsPerBootstrapper': endorsementTicketsPerBootstrapper
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(endorsementTicketsPerBootstrapper);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      endorsementTicketsPerBootstrapper,
      output,
    );
  }
}

/// See [`Pallet::set_endorsement_tickets_per_reputable`].
class SetEndorsementTicketsPerReputable extends Call {
  const SetEndorsementTicketsPerReputable(
      {required this.endorsementTicketsPerReputable});

  factory SetEndorsementTicketsPerReputable._decode(_i1.Input input) {
    return SetEndorsementTicketsPerReputable(
      endorsementTicketsPerReputable: _i1.U8Codec.codec.decode(input),
    );
  }

  final int endorsementTicketsPerReputable;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_endorsement_tickets_per_reputable': {
          'endorsementTicketsPerReputable': endorsementTicketsPerReputable
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(endorsementTicketsPerReputable);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      endorsementTicketsPerReputable,
      output,
    );
  }
}

/// See [`Pallet::set_reputation_lifetime`].
class SetReputationLifetime extends Call {
  const SetReputationLifetime({required this.reputationLifetime});

  factory SetReputationLifetime._decode(_i1.Input input) {
    return SetReputationLifetime(
      reputationLifetime: _i1.U32Codec.codec.decode(input),
    );
  }

  final int reputationLifetime;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_reputation_lifetime': {'reputationLifetime': reputationLifetime}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(reputationLifetime);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      reputationLifetime,
      output,
    );
  }
}

/// See [`Pallet::set_meetup_time_offset`].
class SetMeetupTimeOffset extends Call {
  const SetMeetupTimeOffset({required this.meetupTimeOffset});

  factory SetMeetupTimeOffset._decode(_i1.Input input) {
    return SetMeetupTimeOffset(
      meetupTimeOffset: _i1.I32Codec.codec.decode(input),
    );
  }

  final int meetupTimeOffset;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_meetup_time_offset': {'meetupTimeOffset': meetupTimeOffset}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.I32Codec.codec.sizeHint(meetupTimeOffset);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.I32Codec.codec.encodeTo(
      meetupTimeOffset,
      output,
    );
  }
}

/// See [`Pallet::set_time_tolerance`].
class SetTimeTolerance extends Call {
  const SetTimeTolerance({required this.timeTolerance});

  factory SetTimeTolerance._decode(_i1.Input input) {
    return SetTimeTolerance(
      timeTolerance: _i1.U64Codec.codec.decode(input),
    );
  }

  final BigInt timeTolerance;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_time_tolerance': {'timeTolerance': timeTolerance}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(timeTolerance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      timeTolerance,
      output,
    );
  }
}

/// See [`Pallet::set_location_tolerance`].
class SetLocationTolerance extends Call {
  const SetLocationTolerance({required this.locationTolerance});

  factory SetLocationTolerance._decode(_i1.Input input) {
    return SetLocationTolerance(
      locationTolerance: _i1.U32Codec.codec.decode(input),
    );
  }

  final int locationTolerance;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_location_tolerance': {'locationTolerance': locationTolerance}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(locationTolerance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      locationTolerance,
      output,
    );
  }
}

/// See [`Pallet::purge_community_ceremony`].
class PurgeCommunityCeremony extends Call {
  const PurgeCommunityCeremony({required this.communityCeremony});

  factory PurgeCommunityCeremony._decode(_i1.Input input) {
    return PurgeCommunityCeremony(
      communityCeremony: const _i5.Tuple2Codec<_i3.CommunityIdentifier, int>(
        _i3.CommunityIdentifier.codec,
        _i1.U32Codec.codec,
      ).decode(input),
    );
  }

  final _i5.Tuple2<_i3.CommunityIdentifier, int> communityCeremony;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {
        'purge_community_ceremony': {
          'communityCeremony': [
            communityCeremony.value0.toJson(),
            communityCeremony.value1,
          ]
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i5.Tuple2Codec<_i3.CommunityIdentifier, int>(
          _i3.CommunityIdentifier.codec,
          _i1.U32Codec.codec,
        ).sizeHint(communityCeremony);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    const _i5.Tuple2Codec<_i3.CommunityIdentifier, int>(
      _i3.CommunityIdentifier.codec,
      _i1.U32Codec.codec,
    ).encodeTo(
      communityCeremony,
      output,
    );
  }
}
