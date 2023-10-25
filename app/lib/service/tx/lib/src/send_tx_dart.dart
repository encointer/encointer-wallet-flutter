import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/service/service.dart';

import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/event_record.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/phase.dart';
import 'package:ew_polkadart/runtime_error.dart';
import 'package:ew_polkadart/runtime_event.dart' as re;
import 'package:ew_polkadart/generated/encointer_kusama/types/frame_system/pallet/event.dart' as se;
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/runtime_event.dart';
import 'package:pointycastle/digests/blake2b.dart';

/// Hex encoded 32-byte hash.
typedef Hash = String;

class ExtrinsicReport {
  ExtrinsicReport({
    required this.extrinsicHash,
    required this.blockHash,
    required this.timestamp,
    required this.events,
  });

  /// Hash of the extrinsic.
  final Hash extrinsicHash;

  /// Hash of the block the extrinsic was included in.
  final Hash blockHash;

  /// Timestamp of the block the extrinsic was included in.
  final BigInt timestamp;

  /// Events associated with the extrinsic.
  final List<EventRecord> events;

  Map<String, dynamic> toJson() => {
        'extrinsicHash': extrinsicHash,
        'blockHash': blockHash,
        'timestamp': timestamp.toString(),
        'events': events.map((value) => value.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  bool get isExtrinsicSuccess {
    return events.last.event.isExtrinsicSuccess;
  }

  bool get isExtrinsicFailed {
    return events.last.event.isExtrinsicFailed;
  }

  DispatchError? get dispatchError {
    return events.last.event.dispatchError;
  }
}

extension SystemExtension on RuntimeEvent {
  bool get isExtrinsicSuccess {
    return switch (this) {
      re.System(value0: final event) => event is se.ExtrinsicSuccess,
      _ => false,
    };
  }

  bool get isExtrinsicFailed {
    return switch (this) {
      re.System(value0: final event) => event is se.ExtrinsicFailed,
      _ => false,
    };
  }

  DispatchError? get dispatchError {
    if (isExtrinsicFailed) {
      return ((this as re.System).value0 as se.ExtrinsicFailed).dispatchError;
    } else {
      return null;
    }
  }
}

/// Substrate state API
class EWAuthorApi<P extends Provider> {
  const EWAuthorApi(this._provider);

  final P _provider;

  /// Submit a fully formatted extrinsic for block inclusion.
  Future<Uint8List> submitExtrinsic(Extrinsic extrinsic) async {
    final params = <String>[extrinsic.hexPrefixed];

    final response = await _provider.send('author_submitExtrinsic', params);

    if (response.error != null) {
      throw Exception(response.error.toString());
    }

    final data = response.result as String;
    return Uint8List.fromList(hex.decode(data.substring(2)));
  }

  /// Submit a fully formatted extrinsic and return a subscription
  /// which emits txStatus updates.
  Future<SubscriptionResponse> submitAndWatchExtrinsic(Extrinsic extrinsic) async {
    final params = <String>[extrinsic.hexPrefixed];

    final subscription = await _provider.subscribe(
      'author_submitAndWatchExtrinsic',
      params,
      onCancel: (subscription) async {
        await _provider.send('author_unsubmitAndWatchExtrinsic', [subscription]);
      },
    );

    return subscription;
  }

  Future<ExtrinsicReport> submitAndWatchExtrinsicWithReport(Extrinsic extrinsic) async {
    final hash = extrinsic.hash;

    final subResponse = await submitAndWatchExtrinsic(extrinsic);

    final completer = Completer<void>();

    ExtrinsicReport? report;
    final sub = subResponse.stream.listen((event) async {
      Log.d('ExtrinsicUpdate: ${event.result}');

      if (event.result == 'ready') {
        Log.p('Xt is ready');
      // ignore: avoid_dynamic_calls
      } else if (event.result['inBlock'] != null) {
        Log.p('Xt is in block: ${event.result}');
        // ignore: avoid_dynamic_calls
      } else if (event.result['finalized'] != null) {
        // ignore: avoid_dynamic_calls
        final blockHashHex = event.result['finalized'].toString();
        final blockHash = hexToUint8(blockHashHex);

        final kusama = EncointerKusama(_provider);

        final events = await kusama.query.system.events(at: blockHash);
        final block = await ChainApi(_provider).getBlock(at: blockHash);
        final timestamp = await kusama.query.timestamp.now(at: blockHash);

        // ignore: avoid_dynamic_calls
        final xts = List<String>.from(block['block']['extrinsics'] as List<dynamic>);
        final xtIndex = xts.indexWhere((xt) => xtHash(xt) == hash);

        if (xtIndex != -1) {
          Log.d('found xt in block at index: $xtIndex');
        } else {
          throw Exception(["Couldn't find extrinsic hash: $hash in block with hash: $blockHashHex"]);
        }

        final xtEvents =
            events.where((e) => e.phase is ApplyExtrinsic && (e.phase as ApplyExtrinsic).value0 == xtIndex).toList();

        report = ExtrinsicReport(extrinsicHash: hash, blockHash: blockHashHex, timestamp: timestamp, events: xtEvents);

        completer.complete();
      }
    });

    await completer.future;
    await sub.cancel();
    return report!;
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

  Uint8List get encoded => _encoded;

  String get hexPrefixed => '0x${hex.encode(_encoded)}';

  String get hash => hex.encode(Blake2bDigest(digestSize: 32).process(_encoded));
}

Uint8List hexToUint8(String hexString) {
  return hex.decode(hexString.replaceFirst('0x', '')) as Uint8List;
}

String xtHash(String hexString) {
  return hex.encode(Blake2bDigest(digestSize: 32).process(hexToUint8(hexString)));
}

/// Logs the dispatch error and decodes the individual module error. Only
/// used for debugging in unit tests so far.
///
/// Throws an exception if the error is not unknown.
void logDispatchError(DispatchError value) {
  switch (value.runtimeType) {
    case Module:
      final moduleError = (value as Module).value0;
      Log.d('Found module error: ${value.toJson()}');
      final runtimeError = RuntimeError.decodeWithIndex(moduleError.index, moduleError.error);
      Log.d('Decoded Error: ${runtimeError.toJson()}');
      break;
    case BadOrigin:
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
      Log.d('unhandled dispatch error');
      break;
    default:
      throw Exception('DispatchError: Unsupported "$value" of type "${value.runtimeType}"');
  }
}
