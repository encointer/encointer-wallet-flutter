import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/democracy/widgets/vote_button.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/page-encointer/democracy/helpers.dart';

import 'package:ew_polkadart/ew_polkadart.dart' show Approved, Cancelled, Confirming, Enacted, Ongoing, Proposal, Tally;

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
    // final l10n = context.l10n;
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
          passingOrFailingText(context, proposal, tally, params)
        ],
      ),
      trailing: voteButtonOrProposalStatus(context),
    );
  }

  Widget passingOrFailingText(BuildContext context, Proposal proposal, Tally tally, DemocracyParams params) {
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
    if (isPassing(tally, proposal.electorateSize, params)) {
      return Text(l10n.proposalIsPassing(percentage), style: const TextStyle(color: Colors.green));
    } else {
      return Text(l10n.proposalIsFailing(percentage), style: const TextStyle(color: Colors.red));
    }
  }

  Widget voteButtonOrProposalStatus(BuildContext context) {
    switch (proposal.state.runtimeType) {
      case Cancelled:
      return const Text('Cancelled', style: TextStyle(color: Colors.red));
      case Enacted:
      return const Text('Enacted', style: TextStyle(color: Colors.green));
      case Approved:
      return const Text('Approved', style: TextStyle(color: Colors.green));
      case Ongoing:
      case Confirming:
        return SizedBox(
          height: 50,
          width: 60,
          child: VoteButton(proposal: proposal, proposalId: proposalId, purposeId: purposeId),
        );
      default:
        // should never happen.
        return const Text('Unknown Proposal State');
    }
  }
}
