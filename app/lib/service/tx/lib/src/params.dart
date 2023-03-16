import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

/// Params for known extrinsics.

Map<String, dynamic> endorseNewcomerParams(
  CommunityIdentifier chosenCid,
  String newbie,
  Translations dic,
) {
  return {
    'title': 'endorse_newcomer',
    'notificationTitle': 'Endorse newcomer',
    'notificationBody': 'Yeni üyenin topluluğumuza katılmasını desteklediğin için teşekkür ederiz!',
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
    'notificationTitle': 'Görüşmeye başarıyla kaydoldunuz!',
    'notificationBody': 'Görüşmeye kayıt olduğunuz için teşekkür ederiz. Görüşme tarihinde hatırlatma alacaksınız.',
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
    'notificationTitle': 'Attest phase tamamlandı',
    'notificationBody': 'Attest phase başarıyla tamamlandı. Şimdi görüşmenin sonraki aşamalarına geçebilirsiniz.',
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
    'notificationTitle': 'Ödül talebiniz alındı',
    'notificationBody': 'Görüşmeniz başarıyla tamamlandı. Ödül talebiniz alındı ve en kısa sürede işleme alınacaktır.',
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
    'notificationTitle': 'Transaction complete',
    'notificationBody': "Your coins have been successfully transferred to the recipient's account!",
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
