import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_polkadart/ew_polkadart.dart'
    show
        AddLocation,
        Proposal,
        ProposalAction,
        RemoveLocation,
        SetInactivityTimeout,
        UpdateDemurrage,
        UpdateNominalIncome;

import 'package:ew_polkadart/encointer_types.dart' as et;

class VoteButton extends StatefulWidget {
  const VoteButton({
    super.key,
    required this.proposal,
    required this.purposeId,
  });

  final Proposal proposal;
  final BigInt purposeId;

  @override
  State<VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  late Future<Map<int, CommunityIdentifier>> future;

  int? remainingClaims;

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

    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<Map<int, CommunityIdentifier>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return SubmitButtonSmall(
              onPressed: (context) async {
                // await _submitFaucetDripTxs(
                //   context,
                //   snapshot.data!,
                //   widget.faucetPubKey,
                // );
                future = _getUncommittedReputationIds(context);
                setState(() {});
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

  /// Returns all reputation ids, which haven't been committed for this proposal's
  /// purpose id yet, i.e., can be used to vote currently.
  Future<Map<int, CommunityIdentifier>> _getUncommittedReputationIds(BuildContext context) async {
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

    return ids;
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
