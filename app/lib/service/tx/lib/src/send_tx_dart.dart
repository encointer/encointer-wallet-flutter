import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';

import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/event_record.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/phase.dart';
import 'package:ew_polkadart/runtime_error.dart';
import 'package:ew_polkadart/runtime_event.dart' as re;
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/runtime_event.dart';
import 'package:pointycastle/digests/blake2b.dart';

/// Hex encoded 32-byte hash.
typedef Hash = String;

class ExtrinsicReport {
  ExtrinsicReport({
    required this.extrinsicHash,
    required this.blockHash,
    required this.events,
  });

  /// Hash of the extrinsic.
  final Hash extrinsicHash;

  /// Hash of the block the extrinsic was included in.
  final Hash blockHash;

  /// Events associated with the extrinsic.
  final List<EventRecord> events;
}

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
  Future<SubscriptionResponse> submitAndWatchExtrinsic(Uint8List extrinsic) async {
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

  Future<ExtrinsicReport> submitAndWatchExtrinsicWithReport(Uint8List extrinsic) async {

    final xt = Extrinsic(extrinsic);
    final hash = xt.hash;

    final subResponse = await submitAndWatchExtrinsic(extrinsic);

    final completer = Completer<void>();

    ExtrinsicReport? report;
    final sub = subResponse.stream.listen((event) async {
      print('XtStatus: ${event.result}');
      if (event.result['finalized'] != null) {
        final blockHashHex = event.result['finalized'].toString();
        final blockHash = hexToUint8(blockHashHex);

        final events = await EncointerKusama(_provider).query.system.events(at: blockHash);

        for (final ev in events) {
          print('${ev.toJson()}');
        }

        final block = await ChainApi(_provider).getBlock(at: blockHash);
        print('block: $block');

        final xts = block['block']['extrinsics'] as List<dynamic>;
        final xtIndex = xts.indexWhere((xt) => xtHash(xt as String) == hash);

        if (xtIndex != -1) {
          print('found xt in block at index: $xtIndex');
        }

        final xtEvents = events.where((e) =>
        e.phase is ApplyExtrinsic && (e.phase as ApplyExtrinsic).value0 == xtIndex
        ).toList();

        report = ExtrinsicReport(extrinsicHash: hash, blockHash: blockHashHex, events: xtEvents);

        completer.complete();
      }
    });

    await completer.future;
    await sub.cancel();
    return report!;
}

  Future<StreamSubscription<String>> subscribeFinalizedHeads(void Function(String) onData) async {
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

// Todo: move to a separate file and eventually into polkadart.
class ChainApi<P extends Provider> {
  const ChainApi(this._provider);

  final P _provider;

  /// Submit a fully formatted extrinsic for block inclusion.
  /// The type will be changed to Extrinsic later
  Future<Map<String, dynamic>> getBlock({BlockHash? at}) async {
    final params = at != null ? ['0x${hex.encode(at)}'] : const <String>[];

    final response = await _provider.send('chain_getBlock', params);

    if (response.error != null) {
      throw Exception(response.error.toString());
    }

    final data = response.result;
    return data as Map<String, dynamic>;
  }
}

class Extrinsic {
  Extrinsic(this._encoded);

  factory Extrinsic.fromHex(String hexString) {
    return Extrinsic(hexToUint8(hexString));
  }

  final Uint8List _encoded;

  String get hash => hex.encode(Blake2bDigest(digestSize: 32).process(_encoded));
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
