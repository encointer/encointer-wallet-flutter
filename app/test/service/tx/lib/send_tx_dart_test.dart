import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';

import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/pallet/event.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/phase.dart';
import 'package:ew_polkadart/encointer_types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/digests/blake2b.dart';

void main() {
  group('submit xt', () {
    test('send alice to bob works', () async {
      final polkadart = Provider.fromUri(Uri.parse('ws://localhost:9944'));
      final author = EWAuthorApi(polkadart);

      // note this contains some nonce and will not work on an arbitrary setup. Instead,
      // it will throw a bad signature error, see https://github.com/leonardocustodio/polkadart/pull/337.
      const xtHex = '0x450284008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a480196dc2bd25c5a0d23f17c9c8aef39183383c0947fb3863e82ef609def14535b4742a579cd4ea49ccc2550ea0e5a4a1a4b529020e323792c64c36d3e7caf5fe08435035800000a0700d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d070010a5d4e8';
      final tx = hexToUint8(xtHex);
      final hash = xtHash(xtHex);

      final events = await author.submitAndWatchExtrinsic(tx);

      final completer = Completer<void>();

      final sub = events.stream.listen((event) async {
        print('First: ${event.result}');
        if (event.result['finalized'] != null) {
          final blockHash = hexToUint8(event.result['finalized'].toString());

          final events = await EncointerKusama(polkadart).query.system.events(at: blockHash);

          for (final ev in events) {
            print('${ev.toJson()}');
          }

          final block = await ChainApi(polkadart).getBlock(at: blockHash);
          print('block: $block');

          final xts = block['block']['extrinsics'] as List<dynamic>;
          final xtIndex = xts.indexWhere((xt) => xtHash(xt as String) == hash);

          if (xtIndex != -1) {
            print('found xt in block at index: $xtIndex');
          }

          final xtEvents = events.where((e) =>
            e.phase is ApplyExtrinsic && (e.phase as ApplyExtrinsic).value0 == xtIndex
          );

          print('Our Extrinsic Events:');
          for (final ev in xtEvents) {
            print('${ev.toJson()}');
          }

          for (final ev in xtEvents) {
            if (ev.event is System) {
              final systemEvent = ev.event as System;

              if (systemEvent.value0 is ExtrinsicSuccess) {
                print('ExtrinsicSuccess');
              } else if (systemEvent.value0 is ExtrinsicFailed) {
                print('ExtrinsicFailed');
              } else {
                print('Unidentified extrinsic result');
              }
            }
          }

          completer.complete();
        }
      });

      await completer.future;
      await sub.cancel();
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

Uint8List hexToUint8(String hexString) {
  return hex.decode(hexString.replaceFirst('0x', '')) as Uint8List;
}

String xtHash(String hexString) {
  return hex.encode(Blake2bDigest(digestSize: 32).process(hexToUint8(hexString)));
}
