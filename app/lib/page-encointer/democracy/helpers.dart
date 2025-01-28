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
        Approved,
        Confirming,
        Enacted,
        Ongoing,
        Petition,
        Proposal,
        ProposalAction,
        Rejected,
        RemoveLocation,
        SetInactivityTimeout,
        SpendNative,
        SupersededBy,
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
      final demurrageDouble = u64F64Util.toDouble((action as UpdateDemurrage).value1.bits);
      final d = demurragePerMonth(demurrageDouble, BigInt.from(6));

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

  Log.d('[Democracy] valid voting cIndexes (inclusive): [$votingCindexLowerBound, $votingCindexUpperBound]');

  return cIndex >= votingCindexLowerBound && cIndex <= votingCindexUpperBound;
}

bool isPassing(Tally tally, BigInt electorateSize, DemocracyParams params) {
  // minTurnout is in perThousands
  if ((tally.turnout < BigInt.from(1)) | (tally.turnout < params.minTurnout * electorateSize ~/ BigInt.from(1000))) {
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

/// Function to partition a list into two lists based on a predicate
///
/// The first value of the result are the items for which the predicate
/// returned true.
List<List<T>> partition<T>(Iterable<T> items, bool Function(T) predicate) {
  final trueList = <T>[];
  final falseList = <T>[];

  for (final item in items) {
    if (predicate(item)) {
      trueList.add(item);
    } else {
      falseList.add(item);
    }
  }

  return [trueList, falseList];
}

Iterable<MapEntry<BigInt, Proposal>> proposalsForCommunityOrGlobal(
    Map<BigInt, Proposal> proposals, CommunityIdentifier cid) {
  return proposals.entries.where((e) {
    final maybeCid = getCommunityIdentifierFromProposal(e.value.action);
    return maybeCid == null || maybeCid == et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest);
  });
}

extension ProposalExt on Proposal {
  bool isActive() {
    return state.runtimeType == Ongoing || state.runtimeType == Confirming;
  }

  bool isPast() {
    // Approved, Enacted, Superseded, Rejected
    return !isActive();
  }

  bool hasPassed() {
    return state.runtimeType == Approved || state.runtimeType == Enacted;
  }

  bool supersededOrRejected() {
    return state.runtimeType == SupersededBy || state.runtimeType == Rejected;
  }

  bool isMoreRecentThan(Duration duration) {
    return DateTime.now().subtract(duration).isBefore(DateTime.fromMillisecondsSinceEpoch(start.toInt()));
  }
}
