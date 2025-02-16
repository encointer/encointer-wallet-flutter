import 'dart:math';

import 'package:encointer_wallet/l10n/l10.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

/// Enum for Scope selection
enum ProposalScope { global, local }

extension ProposalScopeExt on ProposalScope {
  bool get isGlobal => this == ProposalScope.global;

  bool get isLocal => this == ProposalScope.local;

  String localizedStr(AppLocalizations l10n) {
    return switch (this) {
      ProposalScope.global => l10n.proposalScopeGlobal,
      ProposalScope.local => l10n.proposalScopeLocal,
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

double monthlyDemurragePercentToDemurrage(double monthly, BigInt blockProductionTime) {
  final blocks = blocksPerMonth(blockProductionTime);
  return -log(1 - (monthly / 100)) / blocks;
}

double blocksPerMonth(BigInt blockProductionTime) {
  return (86400 / blockProductionTime.toDouble()) * (365 / 12);
}
