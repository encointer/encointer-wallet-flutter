import 'package:encointer_wallet/page-encointer/democracy/helpers.dart';
import 'package:encointer_wallet/page-encointer/democracy/propose_page.dart';
import 'package:encointer_wallet/page-encointer/democracy/widgets/proposal_tile.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/l10n/l10.dart';

import 'package:ew_polkadart/ew_polkadart.dart' show Proposal, Tally;

class DemocracyPage extends StatefulWidget {
  const DemocracyPage({super.key});

  static const String route = '/democracy';

  @override
  State<DemocracyPage> createState() => _DemocracyPageState();
}

class _DemocracyPageState extends State<DemocracyPage> {
  Map<BigInt, Proposal>? activeProposals;
  Map<BigInt, Proposal>? pastApprovedProposals;
  Map<BigInt, Proposal>? pastRejectedProposals;
  Map<BigInt, Tally>? tallies;
  Map<BigInt, BigInt>? purposeIds;
  DemocracyParams? democracyParams;

  static const pruneApprovedProposalsDays = 150;
  static const pruneRejectedProposalsDays = 10;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    democracyParams = webApi.encointer.democracyParams();

    await updateProposals(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
    final l10n = context.l10n;
    final titleLargeBlue =
        context.titleLarge.copyWith(color: context.colorScheme.primary);
    final titleMediumBlue =
        context.titleMedium.copyWith(color: context.colorScheme.primary);

    // Not an ideal practice, see #1702
    List<Widget> listViewWidgets() {
      final widgets = <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(l10n.proposalsUpForVote, style: titleLargeBlue),
            IconButton(
              icon: const Icon(Iconsax.add_square),
              color: context.colorScheme.secondary,
              onPressed: () =>
                  Navigator.of(context).pushNamed(ProposePage.route),
            ),
          ],
        ),
        ...proposalTilesOrEmptyWidget(context, activeProposals),
        Text(l10n.proposalsPast, style: titleLargeBlue),
        Text(l10n.proposalApproved, style: titleMediumBlue),
        ...proposalTilesOrEmptyWidget(context, pastApprovedProposals),
        Text(l10n.proposalRejected, style: titleMediumBlue),
        ...proposalTilesOrEmptyWidget(context, pastRejectedProposals),
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
              onTap: () => AppLaunch.launchURL(
                  'https://book.encointer.org/protocol-democracy.html'),
              child: Text(
                l10n.democracyFaq,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: context.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => AppLaunch.launchURL(
                  'https://forum.encointer.org/t/deliberation-for-encointer-democracy-proposals/126'),
              child: Text(
                l10n.democracyDiscussion,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: context.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> updateProposals(BuildContext context) async {
    final store = context.read<AppStore>();

    final maybeProposalIds =
        await webApi.encointer.getHistoricProposalIds(count: BigInt.from(50));

    final allProposals = await webApi.encointer.getProposals(maybeProposalIds);
    // Reduce proposalIds to the entries which also exist in allProposals
    // this is necessary, because migrations may purge incompatible (non-decodable) proposals,
    // but never the index
    final proposalIds =
        maybeProposalIds.where(allProposals.containsKey).toList();
    final allTallies = await webApi.encointer.getTallies(proposalIds);
    final allPurposeIds =
        await webApi.encointer.getProposalPurposeIds(proposalIds);

    final chosenCidOrGlobalProposals =
        proposalsForCommunityOrGlobal(allProposals, store.encointer.chosenCid!);
    final activeAndPast =
        partition(chosenCidOrGlobalProposals, (p) => p.value.isActive());
    final approvedAndRejected =
        partition(activeAndPast[1], (p) => p.value.hasPassed());

    activeProposals = Map.fromEntries(activeAndPast[0]);

    pastApprovedProposals = Map.fromEntries(approvedAndRejected[0].where((e) =>
        e.value.isMoreRecentThan(
            const Duration(days: pruneApprovedProposalsDays))));
    pastRejectedProposals = Map.fromEntries(approvedAndRejected[1].where((e) =>
        e.value.isMoreRecentThan(
            const Duration(days: pruneRejectedProposalsDays))));

    tallies = allTallies;
    purposeIds = allPurposeIds;

    setState(() {});
  }

  Iterable<Widget> proposalTilesOrEmptyWidget(
      BuildContext context, Map<BigInt, Proposal>? proposals) {
    final h3Grey = context.titleLarge
        .copyWith(fontSize: 19, color: AppColors.encointerGrey);
    final appConfig = RepositoryProvider.of<AppConfig>(context);
    final l10n = context.l10n;

    if (proposals == null || tallies == null) {
      return appConfig.isIntegrationTest
          ? [const SizedBox.shrink()]
          : [const Center(child: CupertinoActivityIndicator())];
    }

    if (proposals.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(l10n.proposalsEmpty, style: h3Grey),
        )
      ];
    }

    return proposals.entries.map(
      (proposalEntry) => ProposalTile(
        proposalId: proposalEntry.key,
        proposal: proposalEntry.value,
        tally: tallies![proposalEntry.key]!,
        purposeId: purposeIds![proposalEntry.key]!,
        params: democracyParams!,
      ),
    );
  }
}
