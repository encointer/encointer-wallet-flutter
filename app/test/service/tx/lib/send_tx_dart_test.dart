import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';

import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/pallet/event.dart' as se;
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/phase.dart';
import 'package:ew_polkadart/runtime_error.dart';
import 'package:ew_polkadart/runtime_event.dart' as re;
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/runtime_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/digests/blake2b.dart';

void main() {
  group('submit xt', () {
    test('send alice to bob works', () async {
      final polkadart = Provider.fromUri(Uri.parse('ws://localhost:9944'));
      final author = EWAuthorApi(polkadart);

      // note this contains some nonce and will not work on an arbitrary setup. Instead,
      // it will throw a bad signature error, see https://github.com/leonardocustodio/polkadart/pull/337.
      const xtHex = '0xd1018400d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d011a140fa2a5bf80c614bbdd778e74d3fe09fbe215974263816f385acac8dc4e6ba64e07bb84b1ed5f1d361aff5c2fed9f3d84471d89fc0229c7b4e2a3bfefdf83a5032400003d0073716d3176f08c911c00';
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

void handleExtrinsicEvent(RuntimeEvent event) {
  switch (event.runtimeType) {
    case re.System:
      print('found system event');
      break;
    default:
      print('ignoring event: ${event.toJson()}');
  }
}


void handleDispatchError(DispatchError value) {
  switch (value.runtimeType) {
    case Module:
      final moduleError = (value as Module).value0;
      print('Found module error: ${value.toJson()}');
      final runtimeError = RuntimeError.decodeWithIndex(moduleError.index, moduleError.error);
      print('Decoded Error: ${runtimeError.toJson()}');
      break;
    case BadOrigin:
      print('bad origin error: ${value.toJson()}');
      break;
    case Other:
    case CannotLookup:
    case ConsumerRemaining:
    case NoProviders:
    case TooManyConsumers:
    case Token:
    case Arithmetic:
    case Transactional:
    case Exhausted:
    case Corruption:
    case Unavailable:
    case RootNotAllowed:
      print('unhandled dispatch error');
    default:
      throw Exception('DispatchError: Unsupported "$value" of type "${value.runtimeType}"');
  }
}
