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

  /// meetup location was not found
  meetupLocationNotFound('MeetupLocationNotFound', 3),

  /// meetup time calculation failed
  meetupTimeCalculationError('MeetupTimeCalculationError', 4),

  /// no valid claims were supplied
  noValidAttestations('NoValidAttestations', 5),

  /// the action can only be performed during ATTESTING phase
  attestationPhaseRequired('AttestationPhaseRequired', 6),

  /// the action can only be performed during REGISTERING or ATTESTING phase
  registeringOrAttestationPhaseRequired('RegisteringOrAttestationPhaseRequired', 7),

  /// CommunityIdentifier not found
  inexistentCommunity('InexistentCommunity', 8),

  /// proof is outdated
  proofOutdated('ProofOutdated', 9),

  /// proof is acausal
  proofAcausal('ProofAcausal', 10),

  /// supplied proof is not proving sender
  wrongProofSubject('WrongProofSubject', 11),

  /// former attendance has not been verified or has already been linked to other account
  attendanceUnverifiedOrAlreadyUsed('AttendanceUnverifiedOrAlreadyUsed', 12),

  /// can't have more attestations than other meetup participants
  tooManyAttestations('TooManyAttestations', 13),

  /// sender has run out of newbie tickets
  noMoreNewbieTickets('NoMoreNewbieTickets', 14),

  /// newbie is already endorsed
  alreadyEndorsed('AlreadyEndorsed', 15),

  /// Participant is not registered
  participantIsNotRegistered('ParticipantIsNotRegistered', 16),

  /// No locations are available for assigning participants
  noLocationsAvailable('NoLocationsAvailable', 17),

  /// Trying to issue rewards in a phase that is not REGISTERING
  wrongPhaseForClaimingRewards('WrongPhaseForClaimingRewards', 18),

  /// Trying to issue rewards for a meetup for which UBI was already issued
  rewardsAlreadyIssued('RewardsAlreadyIssued', 19),

  /// Trying to claim UBI for a meetup where votes are not dependable
  votesNotDependable('VotesNotDependable', 20),

  /// Overflow adding user to registry
  registryOverflow('RegistryOverflow', 21),

  /// CheckedMath operation error
  checkedMath('CheckedMath', 22),

  /// Only Bootstrappers are allowed to be registered at this time
  onlyBootstrappers('OnlyBootstrappers', 23),

  /// MeetupTimeOffset can only be changed during registering
  wrongPhaseForChangingMeetupTimeOffset('WrongPhaseForChangingMeetupTimeOffset', 24),

  /// MeetupTimeOffset needs to be in [-8h, 8h]
  invalidMeetupTimeOffset('InvalidMeetupTimeOffset', 25),

  /// the history for given ceremony index and community has been purged
  communityCeremonyHistoryPurged('CommunityCeremonyHistoryPurged', 26),

  /// Unregistering can only be performed during the registering phase
  wrongPhaseForUnregistering('WrongPhaseForUnregistering', 27),

  /// Error while finding meetup participants
  getMeetupParticipantsError('GetMeetupParticipantsError', 28),

  /// index out of bounds while validating the meetup
  meetupValidationIndexOutOfBounds('MeetupValidationIndexOutOfBounds', 29),

  /// Not possible to pay rewards in attestations phase
  earlyRewardsNotPossible('EarlyRewardsNotPossible', 30),

  /// Only newbies can upgrade their registration
  mustBeNewbieToUpgradeRegistration('MustBeNewbieToUpgradeRegistration', 31),

  /// To unregister as a reputable you need to provide a provide a community ceremony where you have a linked reputation
  reputationCommunityCeremonyRequired('ReputationCommunityCeremonyRequired', 32),

  /// In order to unregister a reputable, the provided reputation must be linked
  reputationMustBeLinked('ReputationMustBeLinked', 33),

  /// Meetup Index > Meetup Count or < 1
  invalidMeetupIndex('InvalidMeetupIndex', 34),

  /// BoundedVec bound reached
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
