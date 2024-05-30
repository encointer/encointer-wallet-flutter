import 'dart:math';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_polkadart/ew_polkadart.dart'
    show
        AddLocation,
        Approved,
        Cancelled,
        Confirming,
        Enacted,
        Ongoing,
        Proposal,
        ProposalAction,
        RemoveLocation,
        SetInactivityTimeout,
        Tally,
        UpdateDemurrage,
        UpdateNominalIncome;
import 'package:ew_substrate_fixed/substrate_fixed.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:provider/provider.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

class ProposalTile extends StatelessWidget {
  const ProposalTile({
    super.key,
    required this.proposalId,
    required this.proposal,
    required this.tally,
    required this.purposeId,
    required this.params,
  });

  final BigInt proposalId;
  final Proposal proposal;
  final Tally tally;
  final BigInt purposeId;
  final DemocracyParams params;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();
    final titleSmall = context.titleMedium;

    final turnout = tally.turnout;
    final electorateSize = proposal.electorateSize;
    final threshold = approvalThreshold(electorateSize.toInt(), turnout.toInt());

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      leading: SizedBox(
        width: 20,
        height: 20,
        child: Text(proposalId.toString(), style: titleSmall),
      ),
      title: Text(
        getProposalActionTitle(context, proposal.action),
        style: context.titleMedium.copyWith(color: context.colorScheme.primary),
      ),
      subtitle: Column(
        children: [
          Text('Turnout: $turnout/$electorateSize'),
          Text('Approval Threshold: ${threshold.toStringAsFixed(2)}%'),
          passingOrFailingText(context)
        ],
      ),
      trailing: voteButtonOrProposalStatus(),
    );
  }

  Widget voteButtonOrProposalStatus() {
    return switch (proposal.state.runtimeType) {
      Ongoing => const Text('Ongoing'),
      Confirming => const Text('Confirming'),
      Approved => const Text('Approved'),
      Cancelled => const Text('Cancelled'),
      Enacted => const Text('Enacted'),
      _ => const Text('Unknown proposal state')
    };
  }

  Widget passingOrFailingText(BuildContext context) {
    final l10n = context.l10n;

    var ayeRatio = 0.0;
    if (proposal.electorateSize != BigInt.zero) {
      ayeRatio = tally.ayes / proposal.electorateSize;
    }
    final percentage = (ayeRatio * 100).toStringAsFixed(2);

    // This is for past proposals
    if (proposal.state.runtimeType == Approved || proposal.state.runtimeType == Enacted) {
      return Text(l10n.proposalPassed(percentage), style: const TextStyle(color: Colors.green));
    }

    if (proposal.state.runtimeType == Cancelled) {
      return Text(l10n.proposalFailed(percentage), style: const TextStyle(color: Colors.red));
    }

    // This is for current proposals
    if (isPassing()) {
      return Text(l10n.proposalIsPassing(percentage), style: const TextStyle(color: Colors.green));
    } else {
      return Text(l10n.proposalIsFailing(percentage), style: const TextStyle(color: Colors.red));
    }
  }

  bool isPassing() {
    if (tally.turnout < params.minTurnout) {
      return false;
    }

    return positiveTurnoutBias(
      proposal.electorateSize.toInt(),
      tally.turnout.toInt(),
      tally.ayes.toInt(),
    );
  }

  /// Returns all reputation ids, which haven't been committed for this proposal's
  /// purpose id yet, i.e., can be used to vote currently.
  Future<Map<int, CommunityIdentifier>> _getUncommittedReputationIds(BuildContext context, String address) async {
    final store = context.read<AppStore>();

    final reputations = store.encointer.accountStores![address]!.verifiedReputations;
    final ids = Map<int, CommunityIdentifier>.of({});
    final maybeProposalCid = getCommunityIdentifierFromProposal(proposal.action);

    // Create a set of futures to await in parallel.
    final futures = reputations.entries.map(
      (e) async {
        final cid = e.value.communityIdentifier;
        // Only check if the reputations community id is allowed to drip the faucet.
        if (maybeProposalCid == null ||
            maybeProposalCid == et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest)) {
          final hasCommitted = await webApi.encointer.hasCommittedFor(
            cid,
            e.key,
            purposeId.toInt(),
            address,
          );

          if (!hasCommitted) ids[e.key] = e.value.communityIdentifier;
        }
      },
    );

    await Future.wait(futures);

    return ids;
  }
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

String getProposalActionTitle(BuildContext context, ProposalAction action) {
  final l10n = context.l10n;

  return switch (action.runtimeType) {
    AddLocation => 'Add Location',
    RemoveLocation => 'Remove Location',
    UpdateDemurrage => 'Update Demurrage',
    UpdateNominalIncome => l10n.proposalUpdateNominalIncome(
        u64F64Util.toDouble((action as UpdateNominalIncome).value1.bits).toStringAsFixed(2),
        'Leu',
      ),
    SetInactivityTimeout => 'Set Inactivity Timeout',
    _ => 'Unsupported action found',
  };
}

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
