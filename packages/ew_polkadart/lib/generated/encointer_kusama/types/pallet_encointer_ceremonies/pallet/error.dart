// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// the participant is already registered
  participantAlreadyRegistered('ParticipantAlreadyRegistered', 0),

  /// verification of signature of attendee failed
  badProofOfAttendanceSignature('BadProofOfAttendanceSignature', 1),

  /// verification of signature of attendee failed
  badAttendeeSignature('BadAttendeeSignature', 2),

  /// Bootstrapper reputation is non-transferrable to other accounts for security reasons
  bootstrapperReputationIsUntransferrable(
      'BootstrapperReputationIsUntransferrable', 3),

  /// meetup location was not found
  meetupLocationNotFound('MeetupLocationNotFound', 4),

  /// meetup time calculation failed
  meetupTimeCalculationError('MeetupTimeCalculationError', 5),

  /// no valid claims were supplied
  noValidAttestations('NoValidAttestations', 6),

  /// the action can only be performed during ATTESTING phase
  attestationPhaseRequired('AttestationPhaseRequired', 7),

  /// the action can only be performed during REGISTERING or ATTESTING phase
  registeringOrAttestationPhaseRequired(
      'RegisteringOrAttestationPhaseRequired', 8),

  /// CommunityIdentifier not found
  inexistentCommunity('InexistentCommunity', 9),

  /// proof is outdated
  proofOutdated('ProofOutdated', 10),

  /// proof is acausal
  proofAcausal('ProofAcausal', 11),

  /// supplied proof is not proving sender
  wrongProofSubject('WrongProofSubject', 12),

  /// former attendance has not been verified or has already been linked to other account
  attendanceUnverifiedOrAlreadyUsed('AttendanceUnverifiedOrAlreadyUsed', 13),

  /// can't have more attestations than other meetup participants
  tooManyAttestations('TooManyAttestations', 14),

  /// sender has run out of newbie tickets
  noMoreNewbieTickets('NoMoreNewbieTickets', 15),

  /// newbie is already endorsed
  alreadyEndorsed('AlreadyEndorsed', 16),

  /// Participant is not registered
  participantIsNotRegistered('ParticipantIsNotRegistered', 17),

  /// No locations are available for assigning participants
  noLocationsAvailable('NoLocationsAvailable', 18),

  /// Trying to issue rewards in a phase that is not REGISTERING
  wrongPhaseForClaimingRewards('WrongPhaseForClaimingRewards', 19),

  /// Trying to issue rewards for a meetup for which UBI was already issued
  rewardsAlreadyIssued('RewardsAlreadyIssued', 20),

  /// Trying to claim UBI for a meetup where votes are not dependable
  votesNotDependable('VotesNotDependable', 21),

  /// Overflow adding user to registry
  registryOverflow('RegistryOverflow', 22),

  /// CheckedMath operation error
  checkedMath('CheckedMath', 23),

  /// Only Bootstrappers are allowed to be registered at this time
  onlyBootstrappers('OnlyBootstrappers', 24),

  /// MeetupTimeOffset can only be changed during registering
  wrongPhaseForChangingMeetupTimeOffset(
      'WrongPhaseForChangingMeetupTimeOffset', 25),

  /// MeetupTimeOffset needs to be in [-8h, 8h]
  invalidMeetupTimeOffset('InvalidMeetupTimeOffset', 26),

  /// the history for given ceremony index and community has been purged
  communityCeremonyHistoryPurged('CommunityCeremonyHistoryPurged', 27),

  /// Unregistering can only be performed during the registering phase
  wrongPhaseForUnregistering('WrongPhaseForUnregistering', 28),

  /// Error while finding meetup participants
  getMeetupParticipantsError('GetMeetupParticipantsError', 29),

  /// index out of bounds while validating the meetup
  meetupValidationIndexOutOfBounds('MeetupValidationIndexOutOfBounds', 30),

  /// Not possible to pay rewards in attestations phase
  earlyRewardsNotPossible('EarlyRewardsNotPossible', 31),

  /// Only newbies can upgrade their registration
  mustBeNewbieToUpgradeRegistration('MustBeNewbieToUpgradeRegistration', 32),

  /// To unregister as a reputable you need to provide a provide a community ceremony where you have a linked reputation
  reputationCommunityCeremonyRequired(
      'ReputationCommunityCeremonyRequired', 33),

  /// In order to unregister a reputable, the provided reputation must be linked
  reputationMustBeLinked('ReputationMustBeLinked', 34),

  /// Meetup Index > Meetup Count or < 1
  invalidMeetupIndex('InvalidMeetupIndex', 35),

  /// BoundedVec bound reached
  tooManyAttestationsInBoundedVec('TooManyAttestationsInBoundedVec', 36);

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
        return Error.bootstrapperReputationIsUntransferrable;
      case 4:
        return Error.meetupLocationNotFound;
      case 5:
        return Error.meetupTimeCalculationError;
      case 6:
        return Error.noValidAttestations;
      case 7:
        return Error.attestationPhaseRequired;
      case 8:
        return Error.registeringOrAttestationPhaseRequired;
      case 9:
        return Error.inexistentCommunity;
      case 10:
        return Error.proofOutdated;
      case 11:
        return Error.proofAcausal;
      case 12:
        return Error.wrongProofSubject;
      case 13:
        return Error.attendanceUnverifiedOrAlreadyUsed;
      case 14:
        return Error.tooManyAttestations;
      case 15:
        return Error.noMoreNewbieTickets;
      case 16:
        return Error.alreadyEndorsed;
      case 17:
        return Error.participantIsNotRegistered;
      case 18:
        return Error.noLocationsAvailable;
      case 19:
        return Error.wrongPhaseForClaimingRewards;
      case 20:
        return Error.rewardsAlreadyIssued;
      case 21:
        return Error.votesNotDependable;
      case 22:
        return Error.registryOverflow;
      case 23:
        return Error.checkedMath;
      case 24:
        return Error.onlyBootstrappers;
      case 25:
        return Error.wrongPhaseForChangingMeetupTimeOffset;
      case 26:
        return Error.invalidMeetupTimeOffset;
      case 27:
        return Error.communityCeremonyHistoryPurged;
      case 28:
        return Error.wrongPhaseForUnregistering;
      case 29:
        return Error.getMeetupParticipantsError;
      case 30:
        return Error.meetupValidationIndexOutOfBounds;
      case 31:
        return Error.earlyRewardsNotPossible;
      case 32:
        return Error.mustBeNewbieToUpgradeRegistration;
      case 33:
        return Error.reputationCommunityCeremonyRequired;
      case 34:
        return Error.reputationMustBeLinked;
      case 35:
        return Error.invalidMeetupIndex;
      case 36:
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
