import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/proofOfAttendance.dart';

/// Params for known extrinsics.

Map<String, dynamic> endorseNewcomerParams(
  CommunityIdentifier? chosenCid,
  String? newbie,
) {
  return {
    "title": 'endorse_newcomer',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'endorseNewcomer',
      "cid": chosenCid,
    },
    "params": [chosenCid, newbie],
  };
}

Map<String, dynamic> registerParticipantParams(
  CommunityIdentifier? chosenCid, {
  ProofOfAttendance? proof,
}) {
  return {
    "title": 'register_participant',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'registerParticipant',
      "cid": chosenCid,
    },
    "params": [
      chosenCid,
      proof,
    ],
  };
}

Map<String, dynamic> attestClaimsParams(
  CommunityIdentifier? chosenCid,
  int scannedClaimsCount,
  List<ClaimOfAttendance> claims,
) {
  return {
    "title": 'attest_claims',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'attestClaims',
      "cid": chosenCid,
    },
    "params": [claims],
  };
}

Map<String, dynamic> claimRewardsParams(CommunityIdentifier? chosenCid) {
  return {
    "title": 'claim_rewards',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'claimRewards',
      "cid": chosenCid,
    },
    "params": [chosenCid],
  };
}

Map<String, dynamic> encointerBalanceTransferParams(
  CommunityIdentifier? cid,
  String recipientAddress,
  double? amount,
) {
  return {
    "title": 'encointerBalancesTransfer',
    "txInfo": {
      "module": 'encointerBalances',
      "call": 'transfer',
      "cid": cid,
    },
    "params": [
      recipientAddress,
      cid,
      amount.toString(),
    ],
  };
}
