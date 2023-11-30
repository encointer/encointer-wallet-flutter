import 'dart:async';

import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';

class ChainApi {
  ChainApi(this.store, this.provider);

  final AppStore store;
  final ReconnectingWsProvider provider;

  StreamSubscription<Header>? _latestHeaderSubscription;

  Future<void> startSubscriptions() async {
    Log.d('api: starting encointer subscriptions', 'ChainApi');
    await subscribeNewHeads();
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping encointer subscriptions', 'ChainApi');
    await _latestHeaderSubscription?.cancel();
  }

  /// Subscribes to the latest headers
  Future<void> subscribeNewHeads() async {
    await _latestHeaderSubscription?.cancel();

    final subscription = await provider.subscribe(
      'chain_subscribeNewHeads',
      [],
      onCancel: (subscription) async {
        await provider.send('chain_unsubscribeNewHeads', [subscription]);
      },
    );

    _latestHeaderSubscription = subscription.stream.map((res) {
      Log.p('Header: ${res.result}');
      return Header.fromRpc(res.result as Map<String, dynamic>);
    }).listen((header) {
      Log.p('[subscribeNewHeads] Got header: ${header.toJson()}');
      store.chain.setLatestHeader(header);
    });
  }
}
