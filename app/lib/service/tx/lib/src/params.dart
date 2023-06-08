import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/l10n/l10.dart';

/// Params for known extrinsics.

Map<String, dynamic> endorseNewcomerParams(CommunityIdentifier chosenCid, String newbie, AppLocalizations dic) {
  return {
    'title': 'endorse_newcomer',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'endorseNewcomer',
      'cid': chosenCid,
      'notificationTitle': dic.endorseNewcomerNotificationTitle,
      'notificationBody': dic.endorseNewcomerNotificationBody,
    },
    'params': [chosenCid, newbie],
  };
}

Map<String, dynamic> registerParticipantParams(CommunityIdentifier chosenCid, AppLocalizations dic,
    {ProofOfAttendance? proof}) {
  return {
    'title': 'register_participant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'registerParticipant',
      'cid': chosenCid,
      'notificationTitle': dic.registerParticipantNotificationTitle,
      'notificationBody': dic.registerParticipantNotificationBody,
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
  AppLocalizations dic,
) {
  return {
    'title': 'attest_claims',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'attestAttendees',
      'cid': chosenCid,
      'notificationTitle': dic.attestNotificationTitle,
      'notificationBody': dic.attestNotificationBody,
    },
    'params': [chosenCid, numberOfParticipantsVote, attendees],
  };
}

Map<String, dynamic> claimRewardsParams(CommunityIdentifier chosenCid, AppLocalizations dic) {
  return {
    'title': 'claim_rewards',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'claimRewards',
      'cid': chosenCid,
      'notificationTitle': dic.claimRewardsNotificationTitle,
      'notificationBody': dic.claimRewardsNotificationBody,
    },
    // meetupIndex == null. The chain will figure out our index.
    'params': [chosenCid, null],
  };
}

Map<String, dynamic> encointerBalanceTransferParams(
  CommunityIdentifier cid,
  String recipientAddress,
  double? amount,
  AppLocalizations dic,
) {
  return {
    'title': 'encointerBalancesTransfer',
    'txInfo': {
      'module': 'encointerBalances',
      'call': 'transfer',
      'cid': cid,
      'notificationTitle': dic.balanceTransferNotificationTitle,
      'notificationBody': dic.balanceTransferNotificationBody,
    },
    'params': [
      recipientAddress,
      cid,
      amount.toString(),
    ],
  };
}

Map<String, dynamic> unregisterParticipantParams(
    CommunityIdentifier cid, ProofOfAttendance? proof, AppLocalizations dic) {
  final communityCeremony = [proof?.communityIdentifier, proof?.ceremonyIndex];

  return {
    'title': 'encointerUnregisterParticipant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'unregisterParticipant',
      'cid': cid,
      'notificationTitle': dic.unregisterParticipantNotificationTitle,
      'notificationBody': dic.unregisterParticipantNotificationBody,
    },
    'params': [cid, communityCeremony],
  };
}
