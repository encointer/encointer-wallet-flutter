import 'dart:math';

import 'package:encointer_wallet/l10n/arb/app_localizations.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

/// Enum for Scope selection
enum ProposalScope { global, local }

extension ProposalScopeExt on ProposalScope {
  bool get isGlobal => this == ProposalScope.global;

  bool get isLocal => this == ProposalScope.local;

  String localizedStr(AppLocalizations l10n, String community) {
    return switch (this) {
      ProposalScope.global => l10n.proposalScopeGlobal,
      ProposalScope.local => l10n.proposalScopeLocal(community),
    };
  }
}

/// Enum representing different proposal actions
enum ProposalActionIdentifier {
  addLocation,
  removeLocation,
  updateDemurrage,
  updateNominalIncome,
  setInactivityTimeout,
  petition,
  spendNative,
  issueSwapNativeOption
}

ProposalActionIdentifier proposalActionIdentifierFromPolkadartAction(et.ProposalAction action) {
  return switch (action.runtimeType) {
    et.AddLocation => ProposalActionIdentifier.addLocation,
    et.RemoveLocation => ProposalActionIdentifier.removeLocation,
    et.UpdateDemurrage => ProposalActionIdentifier.updateDemurrage,
    et.UpdateNominalIncome => ProposalActionIdentifier.updateNominalIncome,
    et.SetInactivityTimeout => ProposalActionIdentifier.setInactivityTimeout,
    et.Petition => ProposalActionIdentifier.petition,
    et.SpendNative => ProposalActionIdentifier.spendNative,
    et.IssueSwapNativeOption => ProposalActionIdentifier.issueSwapNativeOption,
    _ => throw UnimplementedError('Invalid Proposal Id Type'),
  };
}

class ProposalActionIdWithScope {
  ProposalActionIdWithScope(this.actionId, this.cid);

  factory ProposalActionIdWithScope.fromProposalAction(et.ProposalAction action) {
    return ProposalActionIdWithScope(
        proposalActionIdentifierFromPolkadartAction(action), getCidFromPolkadartAction(action));
  }

  final ProposalActionIdentifier actionId;
  final CommunityIdentifier? cid;
}

CommunityIdentifier? getCidFromPolkadartAction(et.ProposalAction action) {
  final maybeCid = switch (action.runtimeType) {
    et.AddLocation => (action as et.AddLocation).value0,
    et.RemoveLocation => (action as et.RemoveLocation).value0,
    et.UpdateDemurrage => (action as et.UpdateDemurrage).value0,
    et.UpdateNominalIncome => (action as et.UpdateNominalIncome).value0,
    et.SetInactivityTimeout => null,
    et.Petition => (action as et.Petition).value0,
    et.SpendNative => (action as et.SpendNative).value0,
    et.IssueSwapNativeOption => (action as et.IssueSwapNativeOption).value0,
    _ => throw UnimplementedError('Invalid Proposal Id Type'),
  };

  return maybeCid != null ? CommunityIdentifier.fromPolkadart(maybeCid) : null;
}

/// We still have to implement support for:
/// * issueSwapOption: It does not exist yet in the generated types
List<ProposalActionIdentifier> supportedProposalIds() {
  return [
    ProposalActionIdentifier.addLocation,
    ProposalActionIdentifier.updateDemurrage,
    ProposalActionIdentifier.updateNominalIncome,
    ProposalActionIdentifier.setInactivityTimeout,
    ProposalActionIdentifier.petition,
    ProposalActionIdentifier.spendNative,
    ProposalActionIdentifier.issueSwapNativeOption,
  ];
}

extension PropsalActionExt on ProposalActionIdentifier {
  /// Returns the allowed proposal policies corresponding
  /// to a specific proposal variant.
  List<ProposalScope> allowedPolicies() {
    return switch (this) {
      // Only global proposal allowed
      ProposalActionIdentifier.setInactivityTimeout => [ProposalScope.global],

      // Only local proposals allowed
      ProposalActionIdentifier.addLocation => [ProposalScope.local],
      ProposalActionIdentifier.removeLocation => [ProposalScope.local],
      ProposalActionIdentifier.updateDemurrage => [ProposalScope.local],
      ProposalActionIdentifier.updateNominalIncome => [ProposalScope.local],
      ProposalActionIdentifier.issueSwapNativeOption => [ProposalScope.local],

      // Global or Local allowed (first value is the default)
      ProposalActionIdentifier.petition => [ProposalScope.local, ProposalScope.global],
      ProposalActionIdentifier.spendNative => [ProposalScope.local, ProposalScope.global],
    };
  }

  String localizedStr(AppLocalizations l10n) {
    return switch (this) {
      ProposalActionIdentifier.addLocation => l10n.proposalTypeAddLocation,
      ProposalActionIdentifier.removeLocation => l10n.proposalTypeRemoveLocation,
      ProposalActionIdentifier.updateDemurrage => l10n.proposalTypeUpdateDemurrage,
      ProposalActionIdentifier.updateNominalIncome => l10n.proposalTypeUpdateNominalIncome,
      ProposalActionIdentifier.setInactivityTimeout => l10n.proposalTypeSetInactivityTimeout,
      ProposalActionIdentifier.petition => l10n.proposalTypePetition,
      ProposalActionIdentifier.spendNative => l10n.proposalTypeSpendNative,
      ProposalActionIdentifier.issueSwapNativeOption => l10n.proposalTypeIssueSwapNativeOption,
    };
  }
}

bool hasSameProposalForSameScope(
    List<ProposalActionIdWithScope> actions, ProposalActionIdentifier id, CommunityIdentifier? scope) {
  return actions.any((action) => action.actionId == id && action.cid == scope);
}

double monthlyDemurragePercentToDemurrage(double monthly, BigInt blockProductionTime) {
  final blocks = blocksPerMonth(blockProductionTime);
  return -log(1 - (monthly / 100)) / blocks;
}

double blocksPerMonth(BigInt blockProductionTime) {
  return (86400 / blockProductionTime.toDouble()) * (365 / 12);
}
