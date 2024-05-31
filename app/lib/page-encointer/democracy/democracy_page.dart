import 'package:encointer_wallet/page-encointer/democracy/widgets/proposal_tile.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class DemocracyPage extends StatefulWidget {
  const DemocracyPage({super.key});

  static const String route = '/democracy';

  @override
  State<DemocracyPage> createState() => _DemocracyPageState();
}

class _DemocracyPageState extends State<DemocracyPage> {
  Map<BigInt, Proposal>? proposals;
  Map<BigInt, Tally>? tallies;
  Map<BigInt, BigInt>? purposeIds;
  DemocracyParams? democracyParams;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final proposalIds = await webApi.encointer.getHistoricProposalIds(count: BigInt.from(50));

    final allProposals = await webApi.encointer.getProposals(proposalIds);
    final allTallies = await webApi.encointer.getTallies(proposalIds);
    final allPurposeIds = await webApi.encointer.getProposalPurposeIds(proposalIds);

    democracyParams = webApi.encointer.democracyParams();

    proposals = allProposals;
    tallies = allTallies;
    purposeIds = allPurposeIds;

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final titleLargeBlue = context.titleLarge.copyWith(color: context.colorScheme.primary);
    final h3Grey = context.titleLarge.copyWith(fontSize: 19, color: AppColors.encointerGrey);
    final appConfig = RepositoryProvider.of<AppConfig>(context);

    // Not an ideal practice, but we only release a dev-version of the faucet, and cleanup can be later.
    Iterable<Widget> activeProposalList() {
      if (proposals == null || tallies == null) {
        return appConfig.isIntegrationTest
            ? const [SizedBox.shrink()]
            : const [Center(child: CupertinoActivityIndicator())];
      }

      final activeProposals = proposals!.entries
          .where((e) => e.value.state.runtimeType == Ongoing || e.value.state.runtimeType == Confirming)
          .toList();

      if (activeProposals.isEmpty) {
        return [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.proposalsEmpty, style: h3Grey),
          )
        ];
      }

      return activeProposals
          .map(
            (proposalEntry) => ProposalTile(
              proposalId: proposalEntry.key,
              proposal: proposalEntry.value,
              tally: tallies![proposalEntry.key]!,
              purposeId: purposeIds![proposalEntry.key]!,
              params: democracyParams!,
            ),
          )
          .toList();
    }

    // Not an ideal practice, but we only release a dev-version of the faucet, and cleanup can be later.
    Iterable<Widget> pastProposalList() {
      if (proposals == null || tallies == null) {
        return appConfig.isIntegrationTest
            ? [const SizedBox.shrink()]
            : [const Center(child: CupertinoActivityIndicator())];
      }

      final pastProposals = proposals!.entries
          .where((e) =>
              e.value.state.runtimeType == Cancelled ||
              e.value.state.runtimeType == Enacted ||
              e.value.state.runtimeType == Approved)
          .toList();

      if (pastProposals.isEmpty) {
        return [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.proposalsEmpty, style: h3Grey),
          )
        ];
      }

      return pastProposals.map(
        (proposalEntry) => ProposalTile(
          proposalId: proposalEntry.key,
          proposal: proposalEntry.value,
          tally: tallies![proposalEntry.key]!,
          purposeId: purposeIds![proposalEntry.key]!,
          params: democracyParams!,
        ),
      );
    }

    List<Widget> listViewWidgets() {
      final widgets = <Widget>[
        Text(l10n.proposalsUpForVote, style: titleLargeBlue),
        ...activeProposalList(),
        Text(l10n.proposalsPast, style: titleLargeBlue),
        ...pastProposalList()
      ];

      return widgets;
    }

    final widgets = listViewWidgets();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.democracy),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widgets.length,
            itemBuilder: (context, index) => widgets[index],
          ),
        ),
      ),
    );
  }
}
