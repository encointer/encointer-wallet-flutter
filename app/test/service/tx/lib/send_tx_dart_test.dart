import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';

import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/digests/blake2b.dart';

void main() {
  group('submit xt', () {
    test('send alice to bob works', () async {
      final polkadart = Provider.fromUri(Uri.parse('ws://localhost:9944'));
      final author = EWAuthorApi(polkadart);

      // note this contains some nonce and will not work on an arbitrary setup. Instead,
      // it will throw a bad signature error, see https://github.com/leonardocustodio/polkadart/pull/337.
      const xtHex = '0x450284008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a480178dc41ea448b82b617dad5be16c4f2affb348d4bb55c6618338030e8d2d7d461eaeecdc1e98822d9023fc3541df998353d3b02173639dbb7274a6c2c2847b08a45024c00000a0700d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d070010a5d4e8';
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
