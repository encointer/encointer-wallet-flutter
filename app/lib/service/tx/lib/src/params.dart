import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

/// Params for known extrinsics.

Map<String, dynamic> endorseNewcomerParams(CommunityIdentifier chosenCid, String newbie, Translations dic) {
  return {
    'title': 'endorse_newcomer',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'endorseNewcomer',
      'cid': chosenCid,
      'notificationTitle': dic.encointer.endorseNewcomerNotificationTitle,
      'notificationBody': dic.encointer.endorseNewcomerNotificationBody,
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
      'notificationTitle': dic.encointer.registerParticipantNotificationTitle,
      'notificationBody': dic.encointer.registerParticipantNotificationBody,
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
      'notificationTitle': dic.encointer.attestNotificationTitle,
      'notificationBody': dic.encointer.attestNotificationBody,
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
      'notificationTitle': dic.encointer.claimRewardsNotificationTitle,
      'notificationBody': dic.encointer.claimRewardsNotificationBody,
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
      'notificationTitle': dic.encointer.balanceTransferNotificationTitle,
      'notificationBody': dic.encointer.balanceTransferNotificationBody,
    },
    'params': [
      recipientAddress,
      cid,
      amount.toString(),
    ],
  };
}
