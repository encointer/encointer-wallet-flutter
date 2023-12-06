import 'dart:async';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show ByteInput, EncointerKusama, StorageChangeSet;
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/account_info.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_balances/types/account_data.dart';

class AssetsApi {
  AssetsApi(this.store, this.jsApi, this.encointerKusama);

  final JSApi jsApi;
  final AppStore store;
  final EncointerKusama encointerKusama;

  StreamSubscription<StorageChangeSet>? _balanceSubscription;

  Future<void> startSubscriptions() async {
    Log.d('api: starting assets subscriptions', 'AssetsApi');
    await subscribeBalance();
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping assets subscriptions', 'AssetsApi');
    await _balanceSubscription?.cancel();
    _balanceSubscription = null;
  }

  Future<void> fetchBalance() async {
    final pubKey = store.account.currentAccountPubKey;
    final currentAddress = store.account.currentAddress;
    if (currentAddress.isNotEmpty) {
      final accountData = await encointerKusama.query.balances.account(AddressUtils.addressToPubKey(currentAddress));
      await store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol!: accountData}));
    }
  }

  Future<AccountData> getBalance() async {
    return getBalanceOf(store.account.currentAddress);
  }

  Future<AccountData> getBalanceOf(String address) async {
    return encointerKusama.query.system.account(AddressUtils.addressToPubKey(address)).then((info) => info.data);
  }

  Future<void> subscribeBalance() async {
    await _balanceSubscription?.cancel();

    final pubKey = store.account.currentAccountPubKey;
    final address = store.account.currentAddress;

    if (pubKey == null || pubKey.isEmpty || address.isEmpty) return;

    final balanceKey = encointerKusama.query.system.accountKey(AddressUtils.addressToPubKey(address));

    _balanceSubscription = await encointerKusama.rpc.state.subscribeStorage([balanceKey], (storageChangeSet) async {
      Log.p('Got account data subscription: $storageChangeSet');
      if (storageChangeSet.changes[0].value != null) {
        final accountData = AccountInfo.decode(ByteInput(storageChangeSet.changes[0].value!));
        await store.assets.setAccountBalances(
            pubKey,
            Map.of({
              store.settings.networkState!.tokenSymbol!: accountData.data,
            }));
      }
    });
  }
}
