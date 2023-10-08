// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../encointer_primitives/communities/community_identifier.dart'
    as _i3;
import '../../encointer_primitives/ceremonies/participant_type.dart' as _i4;
import '../../sp_core/crypto/account_id32.dart' as _i5;
import '../../encointer_meetup_validation/exclusion_reason.dart' as _i6;
import '../../encointer_primitives/ceremonies/meetup_result.dart' as _i7;

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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  ParticipantRegistered participantRegistered({
    required _i3.CommunityIdentifier value0,
    required _i4.ParticipantType value1,
    required _i5.AccountId32 value2,
  }) {
    return ParticipantRegistered(
      value0: value0,
      value1: value1,
      value2: value2,
    );
  }

  EndorsedParticipant endorsedParticipant({
    required _i3.CommunityIdentifier value0,
    required _i5.AccountId32 value1,
    required _i5.AccountId32 value2,
  }) {
    return EndorsedParticipant(
      value0: value0,
      value1: value1,
      value2: value2,
    );
  }

  AttestationsRegistered attestationsRegistered({
    required _i3.CommunityIdentifier value0,
    required BigInt value1,
    required int value2,
    required _i5.AccountId32 value3,
  }) {
    return AttestationsRegistered(
      value0: value0,
      value1: value1,
      value2: value2,
      value3: value3,
    );
  }

  RewardsIssued rewardsIssued({
    required _i3.CommunityIdentifier value0,
    required BigInt value1,
    required int value2,
  }) {
    return RewardsIssued(
      value0: value0,
      value1: value1,
      value2: value2,
    );
  }

  InactivityTimeoutUpdated inactivityTimeoutUpdated({required int value0}) {
    return InactivityTimeoutUpdated(
      value0: value0,
    );
  }

  EndorsementTicketsPerBootstrapperUpdated
      endorsementTicketsPerBootstrapperUpdated({required int value0}) {
    return EndorsementTicketsPerBootstrapperUpdated(
      value0: value0,
    );
  }

  EndorsementTicketsPerReputableUpdated endorsementTicketsPerReputableUpdated(
      {required int value0}) {
    return EndorsementTicketsPerReputableUpdated(
      value0: value0,
    );
  }

  ReputationLifetimeUpdated reputationLifetimeUpdated({required int value0}) {
    return ReputationLifetimeUpdated(
      value0: value0,
    );
  }

  MeetupTimeOffsetUpdated meetupTimeOffsetUpdated({required int value0}) {
    return MeetupTimeOffsetUpdated(
      value0: value0,
    );
  }

  TimeToleranceUpdated timeToleranceUpdated({required BigInt value0}) {
    return TimeToleranceUpdated(
      value0: value0,
    );
  }

  LocationToleranceUpdated locationToleranceUpdated({required int value0}) {
    return LocationToleranceUpdated(
      value0: value0,
    );
  }

  CommunityCeremonyHistoryPurged communityCeremonyHistoryPurged({
    required _i3.CommunityIdentifier value0,
    required int value1,
  }) {
    return CommunityCeremonyHistoryPurged(
      value0: value0,
      value1: value1,
    );
  }

  NoReward noReward({
    required _i3.CommunityIdentifier cid,
    required int cindex,
    required BigInt meetupIndex,
    required _i5.AccountId32 account,
    required _i6.ExclusionReason reason,
  }) {
    return NoReward(
      cid: cid,
      cindex: cindex,
      meetupIndex: meetupIndex,
      account: account,
      reason: reason,
    );
  }

  InactivityCounterUpdated inactivityCounterUpdated({
    required _i3.CommunityIdentifier value0,
    required int value1,
  }) {
    return InactivityCounterUpdated(
      value0: value0,
      value1: value1,
    );
  }

  MeetupEvaluated meetupEvaluated({
    required _i3.CommunityIdentifier value0,
    required BigInt value1,
    required _i7.MeetupResult value2,
  }) {
    return MeetupEvaluated(
      value0: value0,
      value1: value1,
      value2: value2,
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
        return ParticipantRegistered._decode(input);
      case 1:
        return EndorsedParticipant._decode(input);
      case 2:
        return AttestationsRegistered._decode(input);
      case 3:
        return RewardsIssued._decode(input);
      case 4:
        return InactivityTimeoutUpdated._decode(input);
      case 5:
        return EndorsementTicketsPerBootstrapperUpdated._decode(input);
      case 6:
        return EndorsementTicketsPerReputableUpdated._decode(input);
      case 7:
        return ReputationLifetimeUpdated._decode(input);
      case 8:
        return MeetupTimeOffsetUpdated._decode(input);
      case 9:
        return TimeToleranceUpdated._decode(input);
      case 10:
        return LocationToleranceUpdated._decode(input);
      case 11:
        return CommunityCeremonyHistoryPurged._decode(input);
      case 12:
        return NoReward._decode(input);
      case 13:
        return InactivityCounterUpdated._decode(input);
      case 14:
        return MeetupEvaluated._decode(input);
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
      case ParticipantRegistered:
        (value as ParticipantRegistered).encodeTo(output);
        break;
      case EndorsedParticipant:
        (value as EndorsedParticipant).encodeTo(output);
        break;
      case AttestationsRegistered:
        (value as AttestationsRegistered).encodeTo(output);
        break;
      case RewardsIssued:
        (value as RewardsIssued).encodeTo(output);
        break;
      case InactivityTimeoutUpdated:
        (value as InactivityTimeoutUpdated).encodeTo(output);
        break;
      case EndorsementTicketsPerBootstrapperUpdated:
        (value as EndorsementTicketsPerBootstrapperUpdated).encodeTo(output);
        break;
      case EndorsementTicketsPerReputableUpdated:
        (value as EndorsementTicketsPerReputableUpdated).encodeTo(output);
        break;
      case ReputationLifetimeUpdated:
        (value as ReputationLifetimeUpdated).encodeTo(output);
        break;
      case MeetupTimeOffsetUpdated:
        (value as MeetupTimeOffsetUpdated).encodeTo(output);
        break;
      case TimeToleranceUpdated:
        (value as TimeToleranceUpdated).encodeTo(output);
        break;
      case LocationToleranceUpdated:
        (value as LocationToleranceUpdated).encodeTo(output);
        break;
      case CommunityCeremonyHistoryPurged:
        (value as CommunityCeremonyHistoryPurged).encodeTo(output);
        break;
      case NoReward:
        (value as NoReward).encodeTo(output);
        break;
      case InactivityCounterUpdated:
        (value as InactivityCounterUpdated).encodeTo(output);
        break;
      case MeetupEvaluated:
        (value as MeetupEvaluated).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case ParticipantRegistered:
        return (value as ParticipantRegistered)._sizeHint();
      case EndorsedParticipant:
        return (value as EndorsedParticipant)._sizeHint();
      case AttestationsRegistered:
        return (value as AttestationsRegistered)._sizeHint();
      case RewardsIssued:
        return (value as RewardsIssued)._sizeHint();
      case InactivityTimeoutUpdated:
        return (value as InactivityTimeoutUpdated)._sizeHint();
      case EndorsementTicketsPerBootstrapperUpdated:
        return (value as EndorsementTicketsPerBootstrapperUpdated)._sizeHint();
      case EndorsementTicketsPerReputableUpdated:
        return (value as EndorsementTicketsPerReputableUpdated)._sizeHint();
      case ReputationLifetimeUpdated:
        return (value as ReputationLifetimeUpdated)._sizeHint();
      case MeetupTimeOffsetUpdated:
        return (value as MeetupTimeOffsetUpdated)._sizeHint();
      case TimeToleranceUpdated:
        return (value as TimeToleranceUpdated)._sizeHint();
      case LocationToleranceUpdated:
        return (value as LocationToleranceUpdated)._sizeHint();
      case CommunityCeremonyHistoryPurged:
        return (value as CommunityCeremonyHistoryPurged)._sizeHint();
      case NoReward:
        return (value as NoReward)._sizeHint();
      case InactivityCounterUpdated:
        return (value as InactivityCounterUpdated)._sizeHint();
      case MeetupEvaluated:
        return (value as MeetupEvaluated)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Participant registered for next ceremony [community, participant type, who]
class ParticipantRegistered extends Event {
  const ParticipantRegistered({
    required this.value0,
    required this.value1,
    required this.value2,
  });

  factory ParticipantRegistered._decode(_i1.Input input) {
    return ParticipantRegistered(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i4.ParticipantType.codec.decode(input),
      value2: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final _i4.ParticipantType value1;

  final _i5.AccountId32 value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'ParticipantRegistered': [
          value0.toJson(),
          value1.toJson(),
          value2.toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i4.ParticipantType.codec.sizeHint(value1);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i4.ParticipantType.codec.encodeTo(
      value1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value2,
      output,
    );
  }
}

/// A bootstrapper (first accountid) has endorsed a participant (second accountid) who can now register as endorsee for this ceremony
class EndorsedParticipant extends Event {
  const EndorsedParticipant({
    required this.value0,
    required this.value1,
    required this.value2,
  });

  factory EndorsedParticipant._decode(_i1.Input input) {
    return EndorsedParticipant(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: const _i1.U8ArrayCodec(32).decode(input),
      value2: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final _i5.AccountId32 value1;

  final _i5.AccountId32 value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'EndorsedParticipant': [
          value0.toJson(),
          value1.toList(),
          value2.toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value1);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value2,
      output,
    );
  }
}

/// A participant has registered N attestations for fellow meetup participants
class AttestationsRegistered extends Event {
  const AttestationsRegistered({
    required this.value0,
    required this.value1,
    required this.value2,
    required this.value3,
  });

  factory AttestationsRegistered._decode(_i1.Input input) {
    return AttestationsRegistered(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i1.U64Codec.codec.decode(input),
      value2: _i1.U32Codec.codec.decode(input),
      value3: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final BigInt value1;

  final int value2;

  final _i5.AccountId32 value3;

  @override
  Map<String, List<dynamic>> toJson() => {
        'AttestationsRegistered': [
          value0.toJson(),
          value1,
          value2,
          value3.toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    size = size + _i1.U32Codec.codec.sizeHint(value2);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value3,
      output,
    );
  }
}

/// rewards have been claimed and issued successfully for N participants for their meetup at the previous ceremony
class RewardsIssued extends Event {
  const RewardsIssued({
    required this.value0,
    required this.value1,
    required this.value2,
  });

  factory RewardsIssued._decode(_i1.Input input) {
    return RewardsIssued(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i1.U64Codec.codec.decode(input),
      value2: _i1.U8Codec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final BigInt value1;

  final int value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'RewardsIssued': [
          value0.toJson(),
          value1,
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    size = size + _i1.U8Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value2,
      output,
    );
  }
}

/// inactivity timeout has changed. affects how many ceremony cycles a community can be idle before getting purged
class InactivityTimeoutUpdated extends Event {
  const InactivityTimeoutUpdated({required this.value0});

  factory InactivityTimeoutUpdated._decode(_i1.Input input) {
    return InactivityTimeoutUpdated(
      value0: _i1.U32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'InactivityTimeoutUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// The number of endorsement tickets which bootstrappers can give out has changed
class EndorsementTicketsPerBootstrapperUpdated extends Event {
  const EndorsementTicketsPerBootstrapperUpdated({required this.value0});

  factory EndorsementTicketsPerBootstrapperUpdated._decode(_i1.Input input) {
    return EndorsementTicketsPerBootstrapperUpdated(
      value0: _i1.U8Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() =>
      {'EndorsementTicketsPerBootstrapperUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// The number of endorsement tickets which bootstrappers can give out has changed
class EndorsementTicketsPerReputableUpdated extends Event {
  const EndorsementTicketsPerReputableUpdated({required this.value0});

  factory EndorsementTicketsPerReputableUpdated._decode(_i1.Input input) {
    return EndorsementTicketsPerReputableUpdated(
      value0: _i1.U8Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() =>
      {'EndorsementTicketsPerReputableUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// reputation lifetime has changed. After this many ceremony cycles, reputations is outdated
class ReputationLifetimeUpdated extends Event {
  const ReputationLifetimeUpdated({required this.value0});

  factory ReputationLifetimeUpdated._decode(_i1.Input input) {
    return ReputationLifetimeUpdated(
      value0: _i1.U32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'ReputationLifetimeUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// meetup time offset has changed. affects the exact time the upcoming ceremony meetups will take place
class MeetupTimeOffsetUpdated extends Event {
  const MeetupTimeOffsetUpdated({required this.value0});

  factory MeetupTimeOffsetUpdated._decode(_i1.Input input) {
    return MeetupTimeOffsetUpdated(
      value0: _i1.I32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'MeetupTimeOffsetUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.I32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.I32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// meetup time tolerance has changed
class TimeToleranceUpdated extends Event {
  const TimeToleranceUpdated({required this.value0});

  factory TimeToleranceUpdated._decode(_i1.Input input) {
    return TimeToleranceUpdated(
      value0: _i1.U64Codec.codec.decode(input),
    );
  }

  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'TimeToleranceUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// meetup location tolerance changed [m]
class LocationToleranceUpdated extends Event {
  const LocationToleranceUpdated({required this.value0});

  factory LocationToleranceUpdated._decode(_i1.Input input) {
    return LocationToleranceUpdated(
      value0: _i1.U32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'LocationToleranceUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

/// the registry for given ceremony index and community has been purged
class CommunityCeremonyHistoryPurged extends Event {
  const CommunityCeremonyHistoryPurged({
    required this.value0,
    required this.value1,
  });

  factory CommunityCeremonyHistoryPurged._decode(_i1.Input input) {
    return CommunityCeremonyHistoryPurged(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final int value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'CommunityCeremonyHistoryPurged': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }
}

class NoReward extends Event {
  const NoReward({
    required this.cid,
    required this.cindex,
    required this.meetupIndex,
    required this.account,
    required this.reason,
  });

  factory NoReward._decode(_i1.Input input) {
    return NoReward(
      cid: _i3.CommunityIdentifier.codec.decode(input),
      cindex: _i1.U32Codec.codec.decode(input),
      meetupIndex: _i1.U64Codec.codec.decode(input),
      account: const _i1.U8ArrayCodec(32).decode(input),
      reason: _i6.ExclusionReason.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier cid;

  final int cindex;

  final BigInt meetupIndex;

  final _i5.AccountId32 account;

  final _i6.ExclusionReason reason;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NoReward': {
          'cid': cid.toJson(),
          'cindex': cindex,
          'meetupIndex': meetupIndex,
          'account': account.toList(),
          'reason': reason.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i1.U32Codec.codec.sizeHint(cindex);
    size = size + _i1.U64Codec.codec.sizeHint(meetupIndex);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(account);
    size = size + _i6.ExclusionReason.codec.sizeHint(reason);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
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
    _i1.U64Codec.codec.encodeTo(
      meetupIndex,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
    _i6.ExclusionReason.codec.encodeTo(
      reason,
      output,
    );
  }
}

/// The inactivity counter of a community has been increased
class InactivityCounterUpdated extends Event {
  const InactivityCounterUpdated({
    required this.value0,
    required this.value1,
  });

  factory InactivityCounterUpdated._decode(_i1.Input input) {
    return InactivityCounterUpdated(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final int value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'InactivityCounterUpdated': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }
}

/// Result of the meetup at the previous ceremony
class MeetupEvaluated extends Event {
  const MeetupEvaluated({
    required this.value0,
    required this.value1,
    required this.value2,
  });

  factory MeetupEvaluated._decode(_i1.Input input) {
    return MeetupEvaluated(
      value0: _i3.CommunityIdentifier.codec.decode(input),
      value1: _i1.U64Codec.codec.decode(input),
      value2: _i7.MeetupResult.codec.decode(input),
    );
  }

  final _i3.CommunityIdentifier value0;

  final BigInt value1;

  final _i7.MeetupResult value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'MeetupEvaluated': [
          value0.toJson(),
          value1,
          value2.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    size = size + _i7.MeetupResult.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
    _i7.MeetupResult.codec.encodeTo(
      value2,
      output,
    );
  }
}
