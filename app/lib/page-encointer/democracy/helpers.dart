import 'dart:math';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

import 'package:ew_polkadart/ew_polkadart.dart'
    show
        AddLocation,
        Petition,
        Proposal,
        ProposalAction,
        RemoveLocation,
        SetInactivityTimeout,
        SpendNative,
        Tally,
        UpdateDemurrage,
        UpdateNominalIncome;

/// Gets the localized proposal action title.
///
/// Todo: add localization for all variants.
String getProposalActionTitle(BuildContext context, ProposalAction action) {
  final l10n = context.l10n;
  final store = context.read<AppStore>();

  switch (action.runtimeType) {
    case UpdateNominalIncome:
      final store = context.read<AppStore>();

      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cid = CommunityIdentifier(cidPolkadart!.geohash, cidPolkadart.digest);

      return l10n.proposalUpdateNominalIncome(
        u64F64Util.toDouble((action as UpdateNominalIncome).value1.bits).toStringAsFixed(2),
        store.encointer.communityStores![cid.toFmtString()]?.symbol ?? cid.toFmtString(),
      );
    case UpdateDemurrage:
      final blockProductionTime = webApi.encointer.encointerKusama.constant.timestamp.minimumPeriod;

      final demurrageDouble = u64F64Util.toDouble((action as UpdateDemurrage).value1.bits);
      final d = demurragePerMonth(demurrageDouble, blockProductionTime);

      return l10n.proposalUpdateDemurrage(d.toStringAsFixed(2));
    case AddLocation:
      return 'Add Location (unsupported)';
    case RemoveLocation:
      return 'Remove Location (unsupported)';
    case SetInactivityTimeout:
      return 'SetInactivity Timeout (unsupported)';
    case Petition:
      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cidStr = cidOrGlobal(cidPolkadart, store);
      final demand = String.fromCharCodes((action as Petition).value1);
      return l10n.proposalPetition(cidStr, demand);
    case SpendNative:
      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cidStr = cidOrGlobal(cidPolkadart, store);
      final beneficiary = Fmt.address(
          AddressUtils.pubKeyToAddress((action as SpendNative).value1, prefix: store.settings.currentNetwork.ss58()))!;
      final amount = Fmt.token(action.value2, ertDecimals);
      return l10n.proposalSpendNative(cidStr, amount, beneficiary);
    default:
      throw Exception('ProposalAction: Invalid Type: "${action.runtimeType}"');
  }
}

String cidOrGlobal(et.CommunityIdentifier? cidPolkadart, AppStore store) {
  final cidStr = cidPolkadart == null
      ? 'global'
      : (store.encointer.communityStores![CommunityIdentifier(cidPolkadart.geohash, cidPolkadart.digest).toFmtString()]
              ?.symbol ??
          CommunityIdentifier(cidPolkadart.geohash, cidPolkadart.digest).toFmtString());
  return cidStr;
}

double demurragePerMonth(double demurrage, BigInt blockProductionTime) {
  return (1 - exp(-1 * demurrage * blocksPerMonth(blockProductionTime))) * 100;
}

double blocksPerMonth(BigInt blockProductionTime) {
  return (86400 / blockProductionTime.toDouble()) * (365 / 12);
}

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
    case Petition:
      // can be global or local
      return (action as Petition).value0;
    case SpendNative:
      // can be global or local
      return (action as SpendNative).value0;
    default:
      throw Exception('ProposalAction: Invalid Type: "${action.runtimeType}"');
  }
}

bool isInVotingCindexes(
  int cIndex,
  Proposal proposal,
  int reputationLifetime,
  DemocracyParams params,
  int cycleDuration,
) {
  final votingCindexLowerBound =
      proposal.startCindex - reputationLifetime + (params.proposalLifetime.toInt() / cycleDuration).ceil();
  final votingCindexUpperBound = proposal.startCindex - 2;

  return cIndex > votingCindexLowerBound && cIndex <= votingCindexUpperBound;
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
  return ayes / turnout > approvalThreshold(electorate, turnout);
}

/// Returns the approval threshold in the range of [0,1].
double approvalThreshold(int electorate, int turnout) {
  if (electorate == 0 || turnout == 0) return 0;
  return 1 / (1 + sqrt(turnout / electorate));
}
