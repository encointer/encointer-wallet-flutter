import 'package:encointer_wallet/extras/utils/translations/translations.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';

/// Params for known extrinsics.

Map<String, dynamic> endorseNewcomerParams(CommunityIdentifier chosenCid, String newbie, Translations dic) {
  return {
    'title': 'endorse_newcomer',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'endorseNewcomer',
      'cid': chosenCid,
      'notificationTitle': dic.transaction.endorseNewcomerNotificationTitle,
      'notificationBody': dic.transaction.endorseNewcomerNotificationBody,
    },
    'params': [chosenCid, newbie],
  };
}

Map<String, dynamic> registerParticipantParams(CommunityIdentifier chosenCid, Translations dic,
    {ProofOfAttendance? proof}) {
  return {
    'title': 'register_participant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'registerParticipant',
      'cid': chosenCid,
      'notificationTitle': dic.transaction.registerParticipantNotificationTitle,
      'notificationBody': dic.transaction.registerParticipantNotificationBody,
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
  Translations dic,
) {
  return {
    'title': 'attest_claims',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'attestAttendees',
      'cid': chosenCid,
      'notificationTitle': dic.transaction.attestNotificationTitle,
      'notificationBody': dic.transaction.attestNotificationBody,
    },
    'params': [chosenCid, numberOfParticipantsVote, attendees],
  };
}

Map<String, dynamic> claimRewardsParams(CommunityIdentifier chosenCid, Translations dic) {
  return {
    'title': 'claim_rewards',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'claimRewards',
      'cid': chosenCid,
      'notificationTitle': dic.transaction.claimRewardsNotificationTitle,
      'notificationBody': dic.transaction.claimRewardsNotificationBody,
    },
    // meetupIndex == null. The chain will figure out our index.
    'params': [chosenCid, null],
  };
}

Map<String, dynamic> encointerBalanceTransferParams(
  CommunityIdentifier cid,
  String recipientAddress,
  double? amount,
  Translations dic,
) {
  return {
    'title': 'encointerBalancesTransfer',
    'txInfo': {
      'module': 'encointerBalances',
      'call': 'transfer',
      'cid': cid,
      'notificationTitle': dic.transaction.balanceTransferNotificationTitle,
      'notificationBody': dic.transaction.balanceTransferNotificationBody,
    },
    'params': [
      recipientAddress,
      cid,
      amount.toString(),
    ],
  };
}

Map<String, dynamic> unregisterParticipantParams(CommunityIdentifier cid, ProofOfAttendance? proof, Translations dic) {
  final communityCeremony = [proof?.communityIdentifier, proof?.ceremonyIndex];

  return {
    'title': 'encointerUnregisterParticipant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'unregisterParticipant',
      'cid': cid,
      'notificationTitle': dic.transaction.unregisterParticipantNotificationTitle,
      'notificationBody': dic.transaction.unregisterParticipantNotificationBody,
    },
    'params': [cid, communityCeremony],
  };
}
