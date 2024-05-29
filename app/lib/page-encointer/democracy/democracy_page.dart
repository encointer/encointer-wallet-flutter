import 'package:encointer_wallet/page-encointer/democracy/widgets/proposal_tile.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:ew_test_keys/ew_test_keys.dart';

class DemocracyPage extends StatefulWidget {
  const DemocracyPage({super.key});

  static const String route = '/democracy';

  @override
  State<DemocracyPage> createState() => _DemocracyPageState();
}


class _DemocracyPageState extends State<DemocracyPage> {

  late final AppStore _appStore;

  Map<BigInt, Proposal>? proposals;
  Map<BigInt, Tally>? tallies;
  DemocracyParams? democracyParams;

  @override
  void initState() {
    super.initState();
    _appStore = context.read<AppStore>();
    _init();
  }

  Future<void> _init() async {
    final allProposals = await webApi.encointer.getProposals();
    final allTallies = await webApi.encointer.getTallies();

    democracyParams = webApi.encointer.democracyParams();

    proposals = allProposals;
    tallies = allTallies;

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final h3Grey = context.titleLarge.copyWith(fontSize: 19, color: AppColors.encointerGrey);
    final store = context.watch<AppStore>();
    final appConfig = RepositoryProvider.of<AppConfig>(context);

    // Not an ideal practice, but we only release a dev-version of the faucet, and cleanup can be later.
    Widget proposalsList() {
      if (proposals == null || tallies == null) {
        return appConfig.isIntegrationTest ? const SizedBox.shrink() : const CupertinoActivityIndicator();
      }

      final proposalList = proposals!.entries.toList();
      final tallyList = tallies!.entries.toList();

      return ListView.builder(
          shrinkWrap: true,
          itemCount: proposals!.length,
          itemBuilder: (context, index) {
            final proposalEntry = proposalList[index];
            return ProposalTile(
              proposalId: proposalEntry.key,
              proposal: proposalEntry.value,
              tally: tallyList[index].value,
              params: democracyParams!,
            );
          }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Democracy'),
        leading: IconButton(
          key: const Key(EWTestKeys.closeAccountManage),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const Text('Proposals up for vote'),
              proposalsList()
            ],
          ),
        ),
      ),
    );
  }
}
