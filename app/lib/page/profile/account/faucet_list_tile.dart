import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_tx_wrappers.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

class FaucetListTile extends StatefulWidget {
  const FaucetListTile(
    this.store, {
    super.key,
    required this.userAddress,
    required this.faucetPubKey,
    required this.faucet,
  });

  final AppStore store;

  final String userAddress;
  final String faucetPubKey;
  final Faucet faucet;

  @override
  State<FaucetListTile> createState() => _FaucetListTileState();
}

class _FaucetListTileState extends State<FaucetListTile> {
  late Future<Map<int, CommunityIdentifier>> future;

  int? remainingClaims;

  @override
  void initState() {
    super.initState();
    future = _getUncommittedReputationIds(widget.userAddress);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Assets.kusama.svg(fit: BoxFit.fitHeight),
        ),
      ),
      title: Text(
        widget.faucet.name,
        style: context.titleMedium.copyWith(color: context.colorScheme.primary),
      ),
      subtitle: Row(
        children: [
          const Text('Available: '),
          if (remainingClaims != null) Text('$remainingClaims') else const CupertinoActivityIndicator(),
          Text(' x ${Fmt.token(BigInt.from(widget.faucet.dripAmount), ertDecimals - 3)} mKSM')
        ],
      ),
      trailing: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<Map<int, CommunityIdentifier>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SubmitButtonSmall(
                onPressed: (context) async {
                  await _submitFaucetDripTxs(
                    context,
                    snapshot.data!,
                    widget.faucetPubKey,
                  );
                  future = _getUncommittedReputationIds(widget.userAddress);
                  setState(() {});
                },
                child: const Text('Claim'),
              );
            } else {
              return const SubmitButtonSmall(child: Text('No Claim'));
            }
          } else {
            return const CupertinoActivityIndicator();
          }
        },
      ),
    );
  }

  /// Returns all reputation ids, which haven't been committed for this faucet's
  /// purpose id yet, i.e., can be used to drip the faucet currently.
  Future<Map<int, CommunityIdentifier>> _getUncommittedReputationIds(String address) async {
    final reputations = widget.store.encointer.accountStores![address]!.verifiedReputations;
    final ids = Map<int, CommunityIdentifier>.of({});

    // Create a set of futures to await in parallel.
    final futures = reputations.entries.map(
      (e) async {
        final cid = e.value.communityIdentifier;
        // Only check if the reputations community id is allowed to drip the faucet.
        if (widget.faucet.whitelist == null || widget.faucet.whitelist!.contains(cid)) {
          final hasCommitted = await webApi.encointer.hasCommittedFor(
            cid,
            e.key,
            widget.faucet.purposeId,
            address,
          );

          if (!hasCommitted) ids[e.key] = e.value.communityIdentifier;
        }
      },
    );

    await Future.wait(futures);

    remainingClaims = ids.length;
    // update the text widgets with the remaining claims.
    setState(() {});
    return ids;
  }

  Future<void> _submitFaucetDripTxs(
    BuildContext context,
    Map<int, CommunityIdentifier> ids,
    String faucetAccount,
  ) async {
    final store = widget.store;
    final e = ids.entries.first;
    return submitFaucetDrip(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      faucetAccount,
      e.value,
      e.key,
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
    );
  }
}
