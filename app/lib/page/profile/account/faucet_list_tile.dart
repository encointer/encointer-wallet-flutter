import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_tx_wrappers.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';

class FaucetListTile extends StatefulWidget {
  const FaucetListTile(
    this.store, {
    super.key,
    required this.userAddress,
    required this.faucetAccount,
    required this.faucet,
  });

  final AppStore store;

  final String userAddress;
  final String faucetAccount;
  final Faucet faucet;

  @override
  State<FaucetListTile> createState() => _FaucetListTileState();
}

class _FaucetListTileState extends State<FaucetListTile> {
  late Future<Map<int, CommunityIdentifier>> future;
  late Future<BigInt> nativeBalance;

  @override
  void initState() {
    super.initState();
    future = _getUncommittedReputationIds(widget.userAddress);
    nativeBalance = getNativeFreeBalance(widget.userAddress);
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
          const Text('KSM: '),
          FutureBuilder(
              future: nativeBalance,
              builder: (BuildContext context, AsyncSnapshot<BigInt> snapshot) {
                if (snapshot.hasData) {
                  return Text(Fmt.token(snapshot.data!, ertDecimals));
                } else {
                  return const CupertinoActivityIndicator();
                }
              })
        ],
      ),
      trailing: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<Map<int, CommunityIdentifier>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SubmitButtonSmall(
                onPressed: (context) async {
                  await _submitFaucetDripTxs(context, snapshot.data!, widget.faucetAccount);
                  future = _getUncommittedReputationIds(widget.userAddress);
                  nativeBalance = getNativeFreeBalance(widget.userAddress);
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
    final reputations = widget.store.encointer.accountStores![address]!.reputations;
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
    return ids;
  }

  Future<void> _submitFaucetDripTxs(
    BuildContext context,
    Map<int, CommunityIdentifier> ids,
    String faucetAccount,
  ) async {
    final e = ids.entries.first;
    return submitFaucetDrip(context, widget.store, webApi, faucetAccount, e.value, e.key);
  }

  Future<BigInt> getNativeFreeBalance(String address) async {
    final balance = await webApi.assets.getBalanceOf(address);
    return balance.free;
  }
}
