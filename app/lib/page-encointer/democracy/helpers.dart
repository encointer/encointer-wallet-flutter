import 'dart:math';

import 'package:encointer_wallet/config/consts.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/page-encointer/democracy/utils/asset_id.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_log/ew_log.dart';
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
        SpendAsset,
        SupersededBy,
        Tally,
        UpdateDemurrage,
        UpdateNominalIncome,
        IssueSwapNativeOption,
        IssueSwapAssetOption;

/// Gets the localized proposal action title.
String getProposalActionTitle(BuildContext context, ProposalAction action) {
  final l10n = context.l10n;
  final store = context.read<AppStore>();

  switch (action.runtimeType) {
    case UpdateNominalIncome:
      final store = context.read<AppStore>();

      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cid = CommunityIdentifier(cidPolkadart!.geohash, cidPolkadart.digest);

      return l10n.proposalUpdateNominalIncome(
        i64F64Util.toDouble((action as UpdateNominalIncome).value1.bits).toStringAsFixed(2),
        store.encointer.communityStores![cid.toFmtString()]?.symbol ?? cid.toFmtString(),
      );
    case UpdateDemurrage:
      final demurrageDouble = i64F64Util.toDouble((action as UpdateDemurrage).value1.bits);
      final d = demurragePerMonth(demurrageDouble, BigInt.from(6));

      return l10n.proposalUpdateDemurrage(d.toStringAsFixed(2));
    case AddLocation:
      final cidPolkadart = (action as AddLocation).value0;
      final cidStr = cidOrGlobal(cidPolkadart, store);
      final location = Location.fromPolkadart(action.value1);
      return '${l10n.proposalAddLocation(cidStr)} (${location.latLongFmt()})';
    case RemoveLocation:
      final cidPolkadart = (action as AddLocation).value0;
      final cidStr = cidOrGlobal(cidPolkadart, store);
      final location = Location.fromPolkadart(action.value1);
      return '${l10n.proposalRemoveLocation(cidStr)} (${location.latLongFmt()})';
    case SetInactivityTimeout:
      final timeout = (action as SetInactivityTimeout).value0;
      return l10n.proposalSetInactivityTimeoutTo(timeout.toString());
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
    case IssueSwapNativeOption:
      final issueOption = action as IssueSwapNativeOption;
      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cidStr = cidOrGlobal(cidPolkadart, store);
      final beneficiary =
          Fmt.address(AddressUtils.pubKeyToAddress(issueOption.value1, prefix: store.settings.currentNetwork.ss58()))!;
      final swapNativeOption = issueOption.value2;

      final allowance = Fmt.bigIntToDouble(swapNativeOption.nativeAllowance, ertDecimals);
      final rate = swapNativeOption.rate != null
          ? i64F64Parser.toDouble(swapNativeOption.rate!.bits) * pow(10, ertDecimals)
          : null;

      // This won't be null until we introduce oracle based rates.
      final rateFmt = rate != null ? Fmt.doubleFormat(rate, length: 2) : 'no-rate-found';

      return l10n.proposalIssueSwapNativeOption(cidStr, beneficiary, Fmt.doubleFormat(allowance, length: 2), rateFmt);
    case SpendAsset:
      final spendAsset = action as SpendAsset;
      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cidStr = cidOrGlobal(cidPolkadart, store);
      final beneficiary =
          Fmt.address(AddressUtils.pubKeyToAddress(spendAsset.value1, prefix: store.settings.currentNetwork.ss58()))!;

      final asset = fromVersionedLocatableAsset(action.value3);
      final amount = Fmt.token(action.value2, asset.decimals);

      return l10n.proposalSpendAsset(asset.symbol, cidStr, amount, beneficiary);
    case IssueSwapAssetOption:
      final issueOption = action as IssueSwapAssetOption;
      final cidPolkadart = getCommunityIdentifierFromProposal(action);
      final cidStr = cidOrGlobal(cidPolkadart, store);
      final beneficiary =
          Fmt.address(AddressUtils.pubKeyToAddress(issueOption.value1, prefix: store.settings.currentNetwork.ss58()))!;
      final swapAssetOption = issueOption.value2;

      final asset = fromVersionedLocatableAsset(swapAssetOption.assetId);

      final allowance = Fmt.bigIntToDouble(swapAssetOption.assetAllowance, asset.decimals);

      final rate = swapAssetOption.rate != null
          ? i64F64Parser.toDouble(swapAssetOption.rate!.bits) * pow(10, asset.decimals)
          : null;

      // This won't be null until we introduce oracle based rates.
      final rateFmt = rate != null ? Fmt.doubleFormat(rate, length: 2) : 'no-rate-found';

      return l10n.proposalIssueSwapAssetOption(
          asset.symbol, cidStr, beneficiary, Fmt.doubleFormat(allowance, length: 2), rateFmt);
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

double monthlyDemurragePercentToDemurrage(double monthly, BigInt blockProductionTime) {
  final blocks = blocksPerMonth(blockProductionTime);
  return -log(1 - (monthly / 100)) / blocks;
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
    case IssueSwapNativeOption:
      // can be global or local
      return (action as IssueSwapNativeOption).value0;
    case SpendAsset:
      // can be global or local
      return (action as SpendAsset).value0;
    case IssueSwapAssetOption:
      // can be global or local
      return (action as IssueSwapAssetOption).value0;
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

bool isPassing(Tally tally, BigInt electorateSize, BigInt minTurnout) {
  if (!minTurnoutReached(tally, electorateSize, minTurnout)) {
    return false;
  }

  return positiveTurnoutBias(
    electorateSize.toInt(),
    tally.turnout.toInt(),
    tally.ayes.toInt(),
  );
}

bool minTurnoutReached(Tally tally, BigInt electorateSize, BigInt minTurnout) {
  // minTurnout is in perThousands
  return (tally.turnout > BigInt.from(0)) &&
      ((tally.turnout * BigInt.from(1000) / electorateSize) >= minTurnout.toInt());
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

  /// Returns true if the proposal started after now - `duration`.
  bool isMoreRecentThan(Duration duration) {
    return DateTime.now().subtract(duration).isBefore(DateTime.fromMillisecondsSinceEpoch(start.toInt()));
  }

  /// Returns true if the proposal started before now - `duration`.
  bool isOlderThan(Duration duration) {
    return !isMoreRecentThan(duration);
  }

  /// Returns true if the proposal has been in `Confirming` for longer than `duration`.
  ///
  /// Returns null if the proposal is not in confirming state at all.
  bool? isConfirmingLongerThan(Duration duration) {
    if (state.runtimeType != Confirming) return null;

    final confirmingSince = (state as Confirming).since;
    return DateTime.now().subtract(duration).isAfter(DateTime.fromMillisecondsSinceEpoch(confirmingSince.toInt()));
  }
}
