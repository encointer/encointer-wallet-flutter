// ignore_for_file: avoid_print

import 'dart:async';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';

import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('submit xt', () {
    test('send alice to bob works', () async {
      final polkadart = Provider.fromUri(Uri.parse('ws://localhost:9944'));
      final author = EWAuthorApi(polkadart);

      // note this contains some nonce and will not work on an arbitrary setup. Instead,
      // it will throw a bad signature error, see https://github.com/leonardocustodio/polkadart/pull/337.
      const xtHex =
          '0xd1018400d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d01ae256b85be1cc6f2af4684f44588457f536d332a03689d433df622dc5dca250fa4911531a6e90be32f1838055b6fe5966da4c8caf69af079bf81a5aa8ce8f58535037000003d0073716d3176f08c911c00';
      final xt = Extrinsic.fromHex(xtHex);

      final report = await author.submitAndWatchExtrinsicWithReport(xt.encoded);
      print('Got extrinsic report: $report');

      if (report.isExtrinsicSuccess) {
        print('ExtrinsicSuccess');
      } else if (report.isExtrinsicFailed) {
        print('ExtrinsicFailed');
        handleDispatchError(report.dispatchError!);
      } else {
        throw Exception('Unidentified Extrinsics Result');
      }
    });

    test('subscribing to finalized heads works', () async {
      final polkadart = Provider.fromUri(Uri.parse('ws://localhost:9944'));

      final completer = Completer<void>();

      await Future<void>.delayed(const Duration(milliseconds: 500));

      final subscription = await polkadart.subscribe(
        'chain_subscribeFinalizedHeads',
        [],
        onCancel: (subscription) async {
          await polkadart.send('chain_unsubscribeFinalizedHeads', [subscription]);
        },
      );

      final sub = subscription.stream.map((event) => event.toString()).listen((event) {
        print('Event: $event');
        completer.complete();
      });

      await completer.future.then((_) => sub.cancel());

      print('End');
    });
  });
}
