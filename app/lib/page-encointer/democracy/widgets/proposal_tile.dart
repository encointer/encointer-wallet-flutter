import 'dart:math';

import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ProposalTile extends StatelessWidget {
  const ProposalTile({
    super.key,
    required this.proposalId,
    required this.proposal,
    required this.tally,
    required this.params,
  });

  final BigInt proposalId;
  final Proposal proposal;
  final Tally tally;
  final DemocracyParams params;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final turnout = tally.turnout;
    final electorateSize = proposal.electorateSize;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Text(proposalId.toString()),
      ),
      title: Text(
        'Update community income to 22 Leu',
        style: context.titleMedium.copyWith(color: context.colorScheme.primary),
      ),
      subtitle: Column(
        children: [
          Text('Turnout: $turnout/$electorateSize'),
          Text('Approval Threshold: ${approvalThreshold(electorateSize.toInt(), turnout.toInt())}%'),
          passingOrFailingText()
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

  Widget passingOrFailingText() {
    final ayeRatio = tally.ayes / proposal.electorateSize;
    final percentage = (ayeRatio * 100).toStringAsFixed(2);

    if (isPassing()) {
      return Text('Currently passing: $percentage% Aye', style: const TextStyle(color: Colors.green));
    } else {
      return Text('Currently failing: $percentage% Aye', style: const TextStyle(color: Colors.red));
    }
  }

  bool isPassing() {
    if (tally.turnout < params) {
      return false;
    }

    return positiveTurnoutBias(
      proposal.electorateSize.toInt(),
      tally.turnout.toInt(),
      tally.ayes.toInt(),
    );
  }
}

bool positiveTurnoutBias(int electorate, int turnout, int ayes) {
  return ayes > approvalThreshold(electorate, turnout);
}

double approvalThreshold(int electorate, int turnout) {
  final sqrtE = sqrt(electorate);
  final sqrtT = sqrt(turnout);

  return (sqrtE * sqrtT) / ((sqrtE / sqrtT) + 1);
}
