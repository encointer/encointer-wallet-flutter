import 'dart:async';

import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';

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

  Future<String> getBlockHash(int? number) async {
    final params = number != null ? [number] : const <String>[];
    Log.p('[getBlockHash] params: $params');

    final response = await provider.send('chain_getBlockHash', params);

    if (response.error != null) {
      throw Exception(response.error.toString());
    }

    final data = response.result;
    Log.p('[getBlockHash] hash: $data');

    return data as String;
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
    }).listen((header) async {
      Log.p('[subscribeNewHeads] Got header: ${header.toJson()}');
      store.chain.setLatestHeader(header);

      final hash = await getBlockHash(header.number);
      store.chain.setLatestHeaderHash(hash);
    });
  }
}
