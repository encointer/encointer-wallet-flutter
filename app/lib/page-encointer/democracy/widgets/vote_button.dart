import 'package:encointer_wallet/common/components/submit_button_cupertino.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:ew_l10n/l10n.dart';
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
  Future<bool>? future;

  // cached values
  int? reputationLifetime;
  Map<int, CommunityReputation>? verifiedReputations;

  // cached but to be updated values
  List<ReputationTuple> uncommittedReputations = [];
  List<ReputationTuple> committedReputations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      future = _getUncommittedReputationIds(context);
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
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                if (uncommittedReputations.isNotEmpty) {
                  return SubmitButtonSmall(
                    onPressed: (context) async {
                      await _showSubmitVoteDialog(store, uncommittedReputations, widget.proposalId);
                      widget.onPressed();
                    },
                    child: Text(l10n.proposalVote),
                  );
                } else if (committedReputations.isNotEmpty) {
                  // indicate that we have already voted on this proposal.
                  return SubmitButtonSmall(child: Text(l10n.proposalVoted));
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
                  },
                  child: Text(l10n.proposalAye, style: const TextStyle(color: Colors.green)),
                ),
                SubmitButtonCupertino(
                  onPressed: (BuildContext context) async {
                    await _submitDemocracyVote(store, Vote.nay, reputations);
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
      vote,
      reputations,
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      onFinish: (_, __) => Navigator.of(context).pop(),
      onError: (dispatchError) {
        final message = getLocalizedTxErrorMessage(context.l10n, dispatchError);
        showTxErrorDialog(context, message, false);
      },
    );

    future = _getUncommittedReputationIds(context);
    setState(() {});
  }

  /// Returns all reputation ids, which haven't been committed for this proposal's
  /// purpose id yet, i.e., can be used to vote currently.
  Future<bool> _getUncommittedReputationIds(BuildContext context) async {
    final store = context.read<AppStore>();
    final address = store.account.currentAddress;

    final maybeProposalCid = getCommunityIdentifierFromProposal(widget.proposal.action);

    final reputations = await eligibleVerifiedReputations(store, address);

    // reset cache
    uncommittedReputations = [];
    committedReputations = [];

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

          if (!hasCommitted) {
            uncommittedReputations.add(ReputationTuple(e.value.communityIdentifier.toPolkadart(), e.key));
          } else {
            committedReputations.add(ReputationTuple(e.value.communityIdentifier.toPolkadart(), e.key));
          }
        }
      },
    );

    await Future.wait(futures);

    Log.d('Uncommitted Reputations for Proposal ${widget.proposalId}: $uncommittedReputations');
    Log.d('Committed Reputations for Proposal ${widget.proposalId}: $committedReputations');

    setState(() {});

    return true;
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

  Future<Map<int, CommunityReputation>> _verifiedReputations() async {
    verifiedReputations ??= await webApi.encointer.getReputations().then((reputations) {
      reputations.removeWhere((key, value) => !value.reputation.isVerified());
      return reputations;
    });
    return verifiedReputations!;
  }
}
