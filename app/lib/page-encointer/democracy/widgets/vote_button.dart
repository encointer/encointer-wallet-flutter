import 'package:encointer_wallet/common/components/submit_button_cupertino.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/page-encointer/democracy/helpers.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show Proposal, Vote;

import 'package:ew_polkadart/encointer_types.dart' as et;

class VoteButton extends StatefulWidget {
  const VoteButton({
    super.key,
    required this.proposal,
    required this.proposalId,
    required this.purposeId,
    required this.democracyParams,
    required this.onPressed,
  });

  final Proposal proposal;
  final BigInt proposalId;
  final BigInt purposeId;
  final DemocracyParams democracyParams;
  final void Function() onPressed;

  @override
  State<VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  Future<Reputations>? future;

  // cached values
  int? reputationLifetime;
  Map<int, CommunityReputation>? verifiedReputations;

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
                      await _showSubmitVoteDialog(store, snapshot.data!, widget.proposalId);
                      widget.onPressed();
                    },
                    child: Text(l10n.proposalVote),
                  );
                } else {
                  return SubmitButtonSmall(child: Text(l10n.proposalVote));
                }
              } else {
                return const CupertinoActivityIndicator();
              }
            },
          );
  }

  Future<void> _showSubmitVoteDialog(AppStore store, Reputations reputations, BigInt proposalId) {
    final l10n = context.l10n;

    return AppAlert.showDialog(
      context,
      title: Text('${l10n.proposal} $proposalId'),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(l10n.proposalHowVote),
      ),
      actions: <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SubmitButtonCupertino(
                  onPressed: (BuildContext context) async {
                    await _submitDemocracyVote(store, Vote.aye, reputations);
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.proposalAye, style: const TextStyle(color: Colors.green)),
                ),
                SubmitButtonCupertino(
                  onPressed: (BuildContext context) async {
                    await _submitDemocracyVote(store, Vote.aye, reputations);
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.proposalNay, style: const TextStyle(color: Colors.red)),
                ),
              ],
            ),
            CupertinoButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancel),
            ),
          ],
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

    final ids = Map<int, CommunityIdentifier>.of({});
    final maybeProposalCid = getCommunityIdentifierFromProposal(widget.proposal.action);

    final reputations = await eligibleVerifiedReputations(store, address);

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

    Log.d('Uncommitted Reputations for Proposal ${widget.proposalId}: $ids');

    return ids.entries.map((e) => ReputationTuple(e.value.toPolkadart(), e.key)).toList();
  }

  Future<Map<int, CommunityReputation>> eligibleVerifiedReputations(AppStore store, String address) async {
    final store = context.read<AppStore>();

    final reputationLifetime = await _reputationLifetime();
    final verifiedReputations = await _verifiedReputations();
    Log.d('Verified Reputations for Proposal ${widget.proposalId}: $verifiedReputations');

    final reputations = verifiedReputations
      ..removeWhere(
        (cIndex, reputation) => !isInVotingCindexes(
          cIndex,
          widget.proposal,
          reputationLifetime,
          widget.democracyParams,
          store.encointer.ceremonyCycleDuration!,
        ),
      );

    Log.d('Eligible Reputations for Proposal ${widget.proposalId}: $reputations');
    return reputations;
  }

  Future<int> _reputationLifetime() async {
    reputationLifetime ??= await webApi.encointer.encointerKusama.query.encointerCeremonies.reputationLifetime();
    return reputationLifetime!;
  }

  Future< Map<int, CommunityReputation>> _verifiedReputations() async {
    verifiedReputations ??= await webApi.encointer.getReputations().then((reputations) {
      reputations.removeWhere((key, value) => !value.reputation.isVerified());
      return reputations;
    });
    return verifiedReputations!;
  }
}
