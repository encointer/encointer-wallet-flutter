import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_polkadart/ew_polkadart.dart'
    show
        AddLocation,
        Proposal,
        ProposalAction,
        RemoveLocation,
        SetInactivityTimeout,
        UpdateDemurrage,
        UpdateNominalIncome,
        Vote;

import 'package:ew_polkadart/encointer_types.dart' as et;

class VoteButton extends StatefulWidget {
  const VoteButton({
    super.key,
    required this.proposal,
    required this.proposalId,
    required this.purposeId,
  });

  final Proposal proposal;
  final BigInt proposalId;
  final BigInt purposeId;

  @override
  State<VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  Future<Reputations>? future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      future = _getUncommittedReputationIds(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();

    return future == null
        ? const Center(child: CupertinoActivityIndicator())
        : FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<Reputations> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return SubmitButtonSmall(
                    onPressed: (context) async {
                      await _showSubmitVoteDialog(store, snapshot.data!);
                    },
                    child: Text(l10n.claim),
                  );
                } else {
                  return SubmitButtonSmall(child: Text(l10n.claim));
                }
              } else {
                return const CupertinoActivityIndicator();
              }
            },
          );
  }

  Future<void> _showSubmitVoteDialog(AppStore store, Reputations reputations) {
    return AppAlert.showDialog(
      context,
      title: const Text('Title'),
      content: const Text('Do you approve?'),
      actions: <Widget>[
        CupertinoButton(
          onPressed: () => _submitDemocracyVote(store, Vote.aye, reputations),
          child: const Text('Nay'),
        ),
        CupertinoButton(
          onPressed: () => _submitDemocracyVote(store, Vote.aye, reputations),
          child: const Text('Aye'),
        ),
        CupertinoButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancl'),
        ),
      ],
    );
  }

  Future<void> _submitDemocracyVote(AppStore store, Vote vote, Reputations reputations) async {
    await submitDemocracyVote(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      widget.proposalId,
      Vote.aye,
      reputations,
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
    );

    future = _getUncommittedReputationIds(context);
    setState(() {});
  }

  /// Returns all reputation ids, which haven't been committed for this proposal's
  /// purpose id yet, i.e., can be used to vote currently.
  Future<Reputations> _getUncommittedReputationIds(BuildContext context) async {
    final store = context.read<AppStore>();
    final address = store.account.currentAddress;

    final reputations = store.encointer.accountStores![address]!.verifiedReputations;
    final ids = Map<int, CommunityIdentifier>.of({});
    final maybeProposalCid = getCommunityIdentifierFromProposal(widget.proposal.action);

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
            widget.purposeId.toInt(),
            address,
          );

          if (!hasCommitted) ids[e.key] = e.value.communityIdentifier;
        }
      },
    );

    await Future.wait(futures);

    return ids.entries.map((e) => ReputationTuple(e.value.toPolkadart(), e.key)).toList();
  }
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