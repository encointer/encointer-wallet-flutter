// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

enum Error {
  participantAlreadyRegistered('ParticipantAlreadyRegistered', 0),
  badProofOfAttendanceSignature('BadProofOfAttendanceSignature', 1),
  badAttendeeSignature('BadAttendeeSignature', 2),
  meetupLocationNotFound('MeetupLocationNotFound', 3),
  meetupTimeCalculationError('MeetupTimeCalculationError', 4),
  noValidAttestations('NoValidAttestations', 5),
  attestationPhaseRequired('AttestationPhaseRequired', 6),
  registeringOrAttestationPhaseRequired(
      'RegisteringOrAttestationPhaseRequired', 7),
  inexistentCommunity('InexistentCommunity', 8),
  proofOutdated('ProofOutdated', 9),
  proofAcausal('ProofAcausal', 10),
  wrongProofSubject('WrongProofSubject', 11),
  attendanceUnverifiedOrAlreadyUsed('AttendanceUnverifiedOrAlreadyUsed', 12),
  tooManyAttestations('TooManyAttestations', 13),
  noMoreNewbieTickets('NoMoreNewbieTickets', 14),
  alreadyEndorsed('AlreadyEndorsed', 15),
  participantIsNotRegistered('ParticipantIsNotRegistered', 16),
  noLocationsAvailable('NoLocationsAvailable', 17),
  wrongPhaseForClaimingRewards('WrongPhaseForClaimingRewards', 18),
  rewardsAlreadyIssued('RewardsAlreadyIssued', 19),
  votesNotDependable('VotesNotDependable', 20),
  registryOverflow('RegistryOverflow', 21),
  checkedMath('CheckedMath', 22),
  onlyBootstrappers('OnlyBootstrappers', 23),
  wrongPhaseForChangingMeetupTimeOffset(
      'WrongPhaseForChangingMeetupTimeOffset', 24),
  invalidMeetupTimeOffset('InvalidMeetupTimeOffset', 25),
  communityCeremonyHistoryPurged('CommunityCeremonyHistoryPurged', 26),
  wrongPhaseForUnregistering('WrongPhaseForUnregistering', 27),
  getMeetupParticipantsError('GetMeetupParticipantsError', 28),
  meetupValidationIndexOutOfBounds('MeetupValidationIndexOutOfBounds', 29),
  earlyRewardsNotPossible('EarlyRewardsNotPossible', 30),
  mustBeNewbieToUpgradeRegistration('MustBeNewbieToUpgradeRegistration', 31),
  reputationCommunityCeremonyRequired(
      'ReputationCommunityCeremonyRequired', 32),
  reputationMustBeLinked('ReputationMustBeLinked', 33),
  invalidMeetupIndex('InvalidMeetupIndex', 34),
  tooManyAttestationsInBoundedVec('TooManyAttestationsInBoundedVec', 35);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.participantAlreadyRegistered;
      case 1:
        return Error.badProofOfAttendanceSignature;
      case 2:
        return Error.badAttendeeSignature;
      case 3:
        return Error.meetupLocationNotFound;
      case 4:
        return Error.meetupTimeCalculationError;
      case 5:
        return Error.noValidAttestations;
      case 6:
        return Error.attestationPhaseRequired;
      case 7:
        return Error.registeringOrAttestationPhaseRequired;
      case 8:
        return Error.inexistentCommunity;
      case 9:
        return Error.proofOutdated;
      case 10:
        return Error.proofAcausal;
      case 11:
        return Error.wrongProofSubject;
      case 12:
        return Error.attendanceUnverifiedOrAlreadyUsed;
      case 13:
        return Error.tooManyAttestations;
      case 14:
        return Error.noMoreNewbieTickets;
      case 15:
        return Error.alreadyEndorsed;
      case 16:
        return Error.participantIsNotRegistered;
      case 17:
        return Error.noLocationsAvailable;
      case 18:
        return Error.wrongPhaseForClaimingRewards;
      case 19:
        return Error.rewardsAlreadyIssued;
      case 20:
        return Error.votesNotDependable;
      case 21:
        return Error.registryOverflow;
      case 22:
        return Error.checkedMath;
      case 23:
        return Error.onlyBootstrappers;
      case 24:
        return Error.wrongPhaseForChangingMeetupTimeOffset;
      case 25:
        return Error.invalidMeetupTimeOffset;
      case 26:
        return Error.communityCeremonyHistoryPurged;
      case 27:
        return Error.wrongPhaseForUnregistering;
      case 28:
        return Error.getMeetupParticipantsError;
      case 29:
        return Error.meetupValidationIndexOutOfBounds;
      case 30:
        return Error.earlyRewardsNotPossible;
      case 31:
        return Error.mustBeNewbieToUpgradeRegistration;
      case 32:
        return Error.reputationCommunityCeremonyRequired;
      case 33:
        return Error.reputationMustBeLinked;
      case 34:
        return Error.invalidMeetupIndex;
      case 35:
        return Error.tooManyAttestationsInBoundedVec;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
