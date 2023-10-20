// ignore_for_file: avoid_print

import 'dart:async';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';

import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/pallet/event.dart' as se;
import 'package:ew_polkadart/runtime_event.dart' as re;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('submit xt', () {
    test('send alice to bob works', () async {
      final polkadart = Provider.fromUri(Uri.parse('ws://localhost:9944'));
      final author = EWAuthorApi(polkadart);

      // note this contains some nonce and will not work on an arbitrary setup. Instead,
      // it will throw a bad signature error, see https://github.com/leonardocustodio/polkadart/pull/337.
      const xtHex =
          '0x45028400d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d01d2473e05092ddd9a032f6eab3a12c3a6983f867ec25180cefd6ce185f1df413b9bf6832c08b24bbd517b693710c1b762328ab7d4b7d7542b1e8bbde87d872984b5005000000a07008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a48070010a5d4e8';
      final xt = Extrinsic.fromHex(xtHex);

      final report = await author.submitAndWatchExtrinsicWithReport(xt.encoded);
      print('Got extrinsic report: $report');

      for (final ev in report.events) {
        if (ev.event is re.System) {
          final systemEvent = ev.event as re.System;

          if (systemEvent.value0 is se.ExtrinsicSuccess) {
            print('ExtrinsicSuccess');
          } else if (systemEvent.value0 is se.ExtrinsicFailed) {
            final dispatchError = (systemEvent.value0 as se.ExtrinsicFailed).dispatchError;
            print('ExtrinsicFailed');
            handleDispatchError(dispatchError);
          } else {
            print('Unidentified extrinsic result');
          }
        }
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
