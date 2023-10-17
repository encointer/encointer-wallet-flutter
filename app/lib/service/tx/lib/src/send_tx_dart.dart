import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';

import 'package:ew_polkadart/ew_polkadart.dart';

/// Substrate state API
class EWAuthorApi<P extends Provider> {
  const EWAuthorApi(this._provider);

  final P _provider;

  /// Submit a fully formatted extrinsic for block inclusion.
  Future<Uint8List> submitExtrinsic(Uint8List extrinsic) async {
    final params = <dynamic>['0x${hex.encode(extrinsic)}'];

    final response = await _provider.send('author_submitExtrinsic', params);

    if (response.error != null) {
      throw Exception(response.error.toString());
    }

    final data = response.result as String;
    return Uint8List.fromList(hex.decode(data.substring(2)));
  }

  /// Submit a fully formatted extrinsic and return a subscription
  /// which emits txStatus updates.
  Future<SubscriptionReponse> submitAndWatchExtrinsic(Uint8List extrinsic) async {
    final params = <dynamic>['0x${hex.encode(extrinsic)}'];

    final subscription = await _provider.subscribe(
      'author_submitAndWatchExtrinsic',
      params,
      onCancel: (subscription) async {
        await _provider.send('author_unsubmitAndWatchExtrinsic', [subscription]);
      },
    );

    return subscription;
  }

  /// Submit a fully formatted extrinsic and return a subscription
  /// which emits txStatus updates.
  Future<StreamSubscription<String>> subscribeFinalizedHeads(void Function(String) onData) async {
    // final params = <dynamic>['0x${hex.encode(extrinsic)}'];

    final subscription = await _provider.subscribe(
      'chain_subscribeFinalizedHeads',
      [],
      onCancel: (subscription) async {
        await _provider.send('chain_unsubscribeFinalizedHeads', [subscription]);
      },
    );

    return subscription.stream.map((event) => event.toString()).listen(onData);
  }
}
