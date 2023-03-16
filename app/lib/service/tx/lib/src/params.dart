import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';

/// Params for known extrinsics.

Map<String, dynamic> endorseNewcomerParams(
  CommunityIdentifier chosenCid,
  String newbie,
) {
  return {
    'title': 'endorse_newcomer',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'endorseNewcomer',
      'cid': chosenCid,
    },
    'params': [chosenCid, newbie],
  };
}

Map<String, dynamic> registerParticipantParams(
  CommunityIdentifier chosenCid, {
  ProofOfAttendance? proof,
}) {
  return {
    'title': 'register_participant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'registerParticipant',
      'cid': chosenCid,
    },
    'params': [
      chosenCid,
      proof,
    ],
  };
}

Map<String, dynamic> attestAttendeesParams(
  CommunityIdentifier chosenCid,
  int numberOfParticipantsVote,
  List<String> attendees,
) {
  return {
    'title': 'attest_claims',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'attestAttendees',
      'cid': chosenCid,
    },
    'params': [chosenCid, numberOfParticipantsVote, attendees],
  };
}

Map<String, dynamic> claimRewardsParams(CommunityIdentifier chosenCid) {
  return {
    'title': 'claim_rewards',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'claimRewards',
      'cid': chosenCid,
    },
    // meetupIndex == null. The chain will figure out our index.
    'params': [chosenCid, null],
  };
}

Map<String, dynamic> encointerBalanceTransferParams(
  CommunityIdentifier cid,
  String recipientAddress,
  double? amount,
) {
  return {
    'title': 'encointerBalancesTransfer',
    'txInfo': {
      'module': 'encointerBalances',
      'call': 'transfer',
      'cid': cid,
    },
    'params': [
      recipientAddress,
      cid,
      amount.toString(),
    ],
  };
}

Map<String, dynamic> unregisterParticipantParams(
  CommunityIdentifier cid,
  // CommunityCeremony is a new type we have to define.
  // It must contain the CommunityCeremony of the reputation that was used when registering if the
  // participant has registered as a reputatble. Otherwise, it must be null.
  int? ceremonyIndex,
) {
  return {
    'title': 'encointerUnregisterParticipant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'unregisterParticipant',
      'cid': cid,
    },
    'params': [cid, ceremonyIndex],
  };
}
