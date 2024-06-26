import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page-encointer/democracy/helpers.dart';
import 'package:encointer_wallet/page-encointer/democracy/widgets/proposal_tile.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/encointer_primitives/democracy/proposal_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/l10n/l10.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

import 'package:ew_polkadart/ew_polkadart.dart' show Approved, Confirming, Enacted, Ongoing, Proposal, Tally;

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

  Iterable<MapEntry<BigInt, Proposal>> proposalsForCommunity(CommunityIdentifier cid) {
    return proposals!.entries.where((e) {
      final maybeCid = getCommunityIdentifierFromProposal(e.value.action);
      return maybeCid == null || maybeCid == et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
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

      final chosenCid = store.encointer.chosenCid!;
      final activeProposals = proposalsForCommunity(chosenCid)
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

      final chosenCid = store.encointer.chosenCid!;
      final pastProposals = proposalsForCommunity(chosenCid)
          .where((e) =>
              e.value.state.runtimeType == Rejected ||
              e.value.state.runtimeType == SupersededBy ||
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
        child: Column(
          children: [
            if (store.encointer.chosenCid == null)
              const Text('Need to choose a community for democracy')
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widgets.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: widgets[index],
                    ),
                  ),
                ),
              ),
            InkWell(
              onTap: () => AppLaunch.launchURL('https://book.encointer.org/protocol-democracy.html'),
              child: Text(
                l10n.democracyFaq,
                style: TextStyle(decoration: TextDecoration.underline, color: context.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => AppLaunch.launchURL('https://book.encointer.org/protocol-democracy.html'),
              child: Text(
                'Todo: Enter link ${l10n.democracyDiscussion}',
                style: TextStyle(decoration: TextDecoration.underline, color: context.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
