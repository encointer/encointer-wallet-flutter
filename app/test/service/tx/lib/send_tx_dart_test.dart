import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
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
      final tx = hex.decode(
          '450284008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a4801c497336fab8028b149e31be4a93054a58ec229da66aab2be8af9792de54f446c8846ab0ad45921117b35bf15794cbdf853870ec7bf43b8a15a151ad26c04688f45013c00000a0700d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d070010a5d4e8'
      );

      final sub = await author.submitAndWatchExtrinsic(tx as Uint8List);

      final events = await sub.stream.first;
      // Fixme: first never arrives
      print('First: $events');
    });

    test('subscribing to finalized heads works', () async {
      final polkadart = Provider.fromUri(Uri.parse('ws://localhost:9944'));

      final completer = Completer<void>();

      await Future.delayed(const Duration(milliseconds: 500));

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

      // Fixme: first never arrives
      print('End');
    });
  });
}
