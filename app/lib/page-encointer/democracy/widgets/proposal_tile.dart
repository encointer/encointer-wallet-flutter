import 'package:encointer_wallet/l10.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page-encointer/democracy/widgets/update_proposal_button.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/democracy/widgets/vote_button.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/page-encointer/democracy/helpers.dart';
import 'package:encointer_wallet/store/app.dart';

import 'package:ew_polkadart/ew_polkadart.dart'
    show Approved, Confirming, Enacted, Ongoing, Proposal, Tally, SupersededBy, Rejected;

class ProposalTile extends StatefulWidget {
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
  State<ProposalTile> createState() => _ProposalTileState();
}

class _ProposalTileState extends State<ProposalTile> {
  @override
  void initState() {
    proposal = widget.proposal;
    tally = widget.tally;

    super.initState();
  }

  late Proposal proposal;
  late Tally tally;

  Future<void> _updateState() async {
    proposal = await webApi.encointer.getProposals([widget.proposalId]).then((map) => map[widget.proposalId]!);
    tally = await webApi.encointer.getTallies([widget.proposalId]).then((map) => map[widget.proposalId]!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final titleSmall = context.titleMedium;

    final turnout = tally.turnout.toInt();
    final electorateSize = proposal.electorateSize;
    final threshold = approvalThreshold(electorateSize.toInt(), turnout);

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15),
          bottom: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Text(
            getProposalActionTitle(context, proposal.action),
            style: context.titleMedium.copyWith(color: context.colorScheme.primary),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(),
            leading: Text(widget.proposalId.toString(), style: titleSmall),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${l10n.proposalTurnout}: $turnout / $electorateSize'),
                if (turnout != 0) Text(l10n.proposalApprovalThreshold((threshold * 100).toStringAsFixed(2))),
                if (turnout != 0) passingOrFailingText(context, proposal, tally, widget.params),
              ],
            ),
            trailing: voteButtonOrProposalStatus(context),
          ),
          Align(alignment: Alignment.bottomRight, child: proposalStateInfo(context, proposal, widget.params)),
        ],
      ),
    );
  }

  Widget proposalStateInfo(BuildContext context, Proposal proposal, DemocracyParams params) {
    final l10n = context.l10n;
    final locale = context.read<AppSettings>().locale.toString();

    if (proposal.state.runtimeType == Ongoing) {
      final ongoingUntil = DateTime.fromMillisecondsSinceEpoch((proposal.start + params.proposalLifetime).toInt());

      if (DateTime.now().isAfter(ongoingUntil)) {
        // proposal failed and needs to be bumped
        return Text(l10n.proposalFailedAndNeedsBump);
      } else {
        // proposal still ongoing
        return Text('${l10n.proposalOngoingUntil} ${mMMEdHm(ongoingUntil, locale)}');
      }
    }

    if (proposal.state.runtimeType == Approved) {
      final enactmentDate = context.read<AppStore>().encointer.proposalEnactmentDate!;
      final date = DateTime.fromMillisecondsSinceEpoch(enactmentDate);
      return Text('${l10n.proposalPendingEnactmentAt} ${mMMEdHm(date, locale)}');
    }

    if (proposal.state.runtimeType == Confirming) {
      final confirmingSince = (proposal.state as Confirming).since;
      final confirmingUntil =
          DateTime.fromMillisecondsSinceEpoch((confirmingSince + params.confirmationPeriod).toInt());

      if (DateTime.now().isAfter(confirmingUntil)) {
        return Text(l10n.proposalPassedAndNeedsBump);
      } else {
        // proposal still confirming
        return Text('${l10n.proposalConfirmingUntil} ${mMMEdHm(confirmingUntil, locale)}');
      }
    }

    // No widget for Enacted || Cancelled
    return const SizedBox.shrink();
  }

  /// Localized date string including the date and time.
  String mMMEdHm(DateTime date, String locale) {
    final dateString = DateFormat.MMMEd(locale).format(date);
    final timeString = DateFormat.Hm(locale).format(date);
    return '$dateString $timeString';
  }

  Widget passingOrFailingText(BuildContext context, Proposal proposal, Tally tally, DemocracyParams params) {
    final l10n = context.l10n;

    var ayeRatio = 0.0;
    if (tally.ayes != BigInt.zero) {
      ayeRatio = tally.ayes / tally.turnout;
    }
    final percentage = (ayeRatio * 100).toStringAsFixed(2);

    // This is for past proposals
    if (proposal.state.runtimeType == Approved || proposal.state.runtimeType == Enacted) {
      return Text(l10n.proposalPassed(percentage), style: const TextStyle(color: Colors.green));
    }

    if (proposal.state.runtimeType == Rejected) {
      return Text(l10n.proposalFailed(percentage), style: const TextStyle(color: Colors.red));
    }

    if (proposal.state.runtimeType == SupersededBy) {
      final replacementId = (proposal.state as SupersededBy).id;
      return Text(l10n.proposalSupersededBy(replacementId.toString()), style: const TextStyle(color: Colors.red));
    }

    // This is for current proposals
    if (isPassing(tally, proposal.electorateSize, params.minTurnout)) {
      return Text(l10n.proposalIsPassing(percentage), style: const TextStyle(color: Colors.green));
    } else {
      return Text(l10n.proposalIsFailing(percentage), style: const TextStyle(color: Colors.red));
    }
  }

  Widget voteButtonOrProposalStatus(BuildContext context) {
    final l10n = context.l10n;
    switch (proposal.state.runtimeType) {
      case Rejected:
        return Text(l10n.proposalRejected, style: const TextStyle(color: Colors.red));
      case SupersededBy:
        return Text(l10n.proposalSuperseded, style: const TextStyle(color: Colors.red));
      case Enacted:
        return Text(l10n.proposalEnacted, style: const TextStyle(color: Colors.green));
      case Approved:
        return Text(l10n.proposalApproved, style: const TextStyle(color: Colors.green));
      case Ongoing:
        final proposalLifetime = Duration(milliseconds: widget.params.proposalLifetime.toInt());
        if (proposal.isOlderThan(proposalLifetime)) {
          // Proposal lifetime has passed; proposal has expired.
          return SizedBox(
            height: 50,
            width: 60,
            child: UpdateProposalButton(
              proposalId: widget.proposalId,
              onPressed: _updateState,
            ),
          );
        } else {
          return SizedBox(
            height: 50,
            width: 60,
            child: VoteButton(
              proposal: proposal,
              proposalId: widget.proposalId,
              purposeId: widget.purposeId,
              democracyParams: widget.params,
              onPressed: _updateState,
            ),
          );
        }
      case Confirming:
        final confirmDuration = Duration(milliseconds: widget.params.confirmationPeriod.toInt());
        if (proposal.isConfirmingLongerThan(confirmDuration)!) {
          // confirmation time has passed
          return SizedBox(
            height: 50,
            width: 60,
            child: UpdateProposalButton(
              proposalId: widget.proposalId,
              onPressed: _updateState,
            ),
          );
        } else {
          return SizedBox(
            height: 50,
            width: 60,
            child: VoteButton(
              proposal: proposal,
              proposalId: widget.proposalId,
              purposeId: widget.purposeId,
              democracyParams: widget.params,
              onPressed: _updateState,
            ),
          );
        }
      default:
        // should never happen.
        return const Text('Unknown Proposal State');
    }
  }
}
