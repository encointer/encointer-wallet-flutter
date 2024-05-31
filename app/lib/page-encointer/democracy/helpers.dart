import 'dart:math';

import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

import 'package:ew_polkadart/ew_polkadart.dart'
    show AddLocation, ProposalAction, RemoveLocation, SetInactivityTimeout, Tally, UpdateDemurrage, UpdateNominalIncome;

/// Gets the localized proposal action title.
///
/// Todo: add localization for all variants.
String getProposalActionTitle(BuildContext context, ProposalAction action) {
  final l10n = context.l10n;

  switch (action.runtimeType) {
    case UpdateNominalIncome:
      final store = context.read<AppStore>();
      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cid = CommunityIdentifier(cidPolkadart!.geohash, cidPolkadart.digest);
      return l10n.proposalUpdateNominalIncome(
        u64F64Util.toDouble((action as UpdateNominalIncome).value1.bits).toStringAsFixed(2),
        store.encointer.communityStores![cid.toFmtString()]!.symbol!,
      );
    case UpdateDemurrage:
      // Todo: calculate monthly demurrage
      return l10n.proposalUpdateDemurrage(
        u64F64Util.toDouble((action as UpdateNominalIncome).value1.bits).toStringAsFixed(2),
      );
    case AddLocation:
      return 'Add Location (unsupported)';
    case RemoveLocation:
      return 'Remove Location (unsupported)';
    case SetInactivityTimeout:
      return 'SetInactivity Timeout (unsupported)';
    default:
      throw Exception('ProposalAction: Invalid Type: "${action.runtimeType}"');
  }
}

String demurragePerMonth()

/// Gets the community identifier from a proposal for community proposals.
///
/// Returns null for global proposals.
et.CommunityIdentifier? getCommunityIdentifierFromProposal(ProposalAction action) {
  switch (action.runtimeType) {
    case AddLocation:
      return (action as AddLocation).value0;
    case RemoveLocation:
      return (action as RemoveLocation).value0;
    case UpdateDemurrage:
      return (action as UpdateDemurrage).value0;
    case UpdateNominalIncome:
      return (action as UpdateNominalIncome).value0;
    case SetInactivityTimeout:
      // This is a global action hence all communities can vote for it.
      return null;
    default:
      throw Exception('ProposalAction: Invalid Type: "${action.runtimeType}"');
  }
}

bool isPassing(Tally tally, BigInt electorateSize, DemocracyParams params) {
  if (tally.turnout < params.minTurnout) {
    return false;
  }

  return positiveTurnoutBias(
    electorateSize.toInt(),
    tally.turnout.toInt(),
    tally.ayes.toInt(),
  );
}

bool positiveTurnoutBias(int electorate, int turnout, int ayes) {
  return ayes > approvalThreshold(electorate, turnout);
}

double approvalThreshold(int electorate, int turnout) {
  if (electorate == 0 || turnout == 0) return 0;

  final sqrtE = sqrt(electorate);
  final sqrtT = sqrt(turnout);

  return (sqrtE * sqrtT) / ((sqrtE / sqrtT) + 1);
}
