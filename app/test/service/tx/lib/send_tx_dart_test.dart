// ignore_for_file: avoid_print

@Skip('Skip these tests as they need a specific setup.')

import 'dart:async';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_builder.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart' as ew;
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/encointer_types.dart';

import 'package:ew_polkadart/ew_polkadart.dart' show EncointerKusama, Provider;
import 'package:ew_primitives/ew_primitives.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('submit xt', () {
    test('send alice to bob works', () async {
      final provider = Provider.fromUri(Uri.parse('ws://localhost:9944'));
      final author = EWAuthorApi(provider);
      final encointerKusama = EncointerKusama(provider);

      final keyring = await testKeyring();
      final accounts = keyring.accounts;
      final alice = accounts[0];
      final bob = accounts[1];

      // Checked that the encoded call matches the one from polkadot-js.
      const oneERT = 1000000000000;
      final transfer =
          encointerKusama.tx.balances.transferAllowDeath(dest: bob.multiAddress(), value: BigInt.from(oneERT));

      final txBuilder = TxBuilder(provider);

      // mediterranean test community
      final paymentAsset = CommunityIdentifier(geohash: utf8.encode('sqm1v'), digest: hex.decode('f08c911c'));
      print('payment asset: ${paymentAsset.toJson()}');
      final testCid = ew.CommunityIdentifier.fromPolkadart(paymentAsset);
      print('payment asset fmt: ${testCid.toFmtString()}');

      final xt = await txBuilder.createSignedExtrinsic(alice.pair, transfer, paymentAsset: paymentAsset);
      print('Sending XT: ${hex.encode(xt)}');

      final report = await author.submitAndWatchExtrinsicWithReport(OpaqueExtrinsic(xt));
      print('Got extrinsic report: $report');

      if (report.isExtrinsicSuccess) {
        print('ExtrinsicSuccess');
      } else if (report.isExtrinsicFailed) {
        print('ExtrinsicFailed');
        logDispatchError(report.dispatchError!);
      } else {
        throw Exception('Unidentified Extrinsic Result');
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
    });
  });
}
