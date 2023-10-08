// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../xcm/v3/traits/outcome.dart' as _i3;
import '../../xcm/v3/multilocation/multi_location.dart' as _i4;
import '../../xcm/v3/xcm_1.dart' as _i5;
import '../../xcm/v3/response.dart' as _i6;
import '../../sp_weights/weight_v2/weight.dart' as _i7;
import '../../primitive_types/h256.dart' as _i8;
import '../../xcm/versioned_multi_assets.dart' as _i9;
import '../../xcm/v3/multiasset/multi_assets.dart' as _i10;
import '../../xcm/v3/traits/error.dart' as _i11;
import '../../xcm/versioned_multi_location.dart' as _i12;
import '../../xcm/v3/instruction_1.dart' as _i13;
import '../../xcm/v3/multiasset/multi_asset.dart' as _i14;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  Attempted attempted({required _i3.Outcome outcome}) {
    return Attempted(
      outcome: outcome,
    );
  }

  Sent sent({
    required _i4.MultiLocation origin,
    required _i4.MultiLocation destination,
    required _i5.Xcm message,
    required List<int> messageId,
  }) {
    return Sent(
      origin: origin,
      destination: destination,
      message: message,
      messageId: messageId,
    );
  }

  UnexpectedResponse unexpectedResponse({
    required _i4.MultiLocation origin,
    required BigInt queryId,
  }) {
    return UnexpectedResponse(
      origin: origin,
      queryId: queryId,
    );
  }

  ResponseReady responseReady({
    required BigInt queryId,
    required _i6.Response response,
  }) {
    return ResponseReady(
      queryId: queryId,
      response: response,
    );
  }

  Notified notified({
    required BigInt queryId,
    required int palletIndex,
    required int callIndex,
  }) {
    return Notified(
      queryId: queryId,
      palletIndex: palletIndex,
      callIndex: callIndex,
    );
  }

  NotifyOverweight notifyOverweight({
    required BigInt queryId,
    required int palletIndex,
    required int callIndex,
    required _i7.Weight actualWeight,
    required _i7.Weight maxBudgetedWeight,
  }) {
    return NotifyOverweight(
      queryId: queryId,
      palletIndex: palletIndex,
      callIndex: callIndex,
      actualWeight: actualWeight,
      maxBudgetedWeight: maxBudgetedWeight,
    );
  }

  NotifyDispatchError notifyDispatchError({
    required BigInt queryId,
    required int palletIndex,
    required int callIndex,
  }) {
    return NotifyDispatchError(
      queryId: queryId,
      palletIndex: palletIndex,
      callIndex: callIndex,
    );
  }

  NotifyDecodeFailed notifyDecodeFailed({
    required BigInt queryId,
    required int palletIndex,
    required int callIndex,
  }) {
    return NotifyDecodeFailed(
      queryId: queryId,
      palletIndex: palletIndex,
      callIndex: callIndex,
    );
  }

  InvalidResponder invalidResponder({
    required _i4.MultiLocation origin,
    required BigInt queryId,
    _i4.MultiLocation? expectedLocation,
  }) {
    return InvalidResponder(
      origin: origin,
      queryId: queryId,
      expectedLocation: expectedLocation,
    );
  }

  InvalidResponderVersion invalidResponderVersion({
    required _i4.MultiLocation origin,
    required BigInt queryId,
  }) {
    return InvalidResponderVersion(
      origin: origin,
      queryId: queryId,
    );
  }

  ResponseTaken responseTaken({required BigInt queryId}) {
    return ResponseTaken(
      queryId: queryId,
    );
  }

  AssetsTrapped assetsTrapped({
    required _i8.H256 hash,
    required _i4.MultiLocation origin,
    required _i9.VersionedMultiAssets assets,
  }) {
    return AssetsTrapped(
      hash: hash,
      origin: origin,
      assets: assets,
    );
  }

  VersionChangeNotified versionChangeNotified({
    required _i4.MultiLocation destination,
    required int result,
    required _i10.MultiAssets cost,
    required List<int> messageId,
  }) {
    return VersionChangeNotified(
      destination: destination,
      result: result,
      cost: cost,
      messageId: messageId,
    );
  }

  SupportedVersionChanged supportedVersionChanged({
    required _i4.MultiLocation location,
    required int version,
  }) {
    return SupportedVersionChanged(
      location: location,
      version: version,
    );
  }

  NotifyTargetSendFail notifyTargetSendFail({
    required _i4.MultiLocation location,
    required BigInt queryId,
    required _i11.Error error,
  }) {
    return NotifyTargetSendFail(
      location: location,
      queryId: queryId,
      error: error,
    );
  }

  NotifyTargetMigrationFail notifyTargetMigrationFail({
    required _i12.VersionedMultiLocation location,
    required BigInt queryId,
  }) {
    return NotifyTargetMigrationFail(
      location: location,
      queryId: queryId,
    );
  }

  InvalidQuerierVersion invalidQuerierVersion({
    required _i4.MultiLocation origin,
    required BigInt queryId,
  }) {
    return InvalidQuerierVersion(
      origin: origin,
      queryId: queryId,
    );
  }

  InvalidQuerier invalidQuerier({
    required _i4.MultiLocation origin,
    required BigInt queryId,
    required _i4.MultiLocation expectedQuerier,
    _i4.MultiLocation? maybeActualQuerier,
  }) {
    return InvalidQuerier(
      origin: origin,
      queryId: queryId,
      expectedQuerier: expectedQuerier,
      maybeActualQuerier: maybeActualQuerier,
    );
  }

  VersionNotifyStarted versionNotifyStarted({
    required _i4.MultiLocation destination,
    required _i10.MultiAssets cost,
    required List<int> messageId,
  }) {
    return VersionNotifyStarted(
      destination: destination,
      cost: cost,
      messageId: messageId,
    );
  }

  VersionNotifyRequested versionNotifyRequested({
    required _i4.MultiLocation destination,
    required _i10.MultiAssets cost,
    required List<int> messageId,
  }) {
    return VersionNotifyRequested(
      destination: destination,
      cost: cost,
      messageId: messageId,
    );
  }

  VersionNotifyUnrequested versionNotifyUnrequested({
    required _i4.MultiLocation destination,
    required _i10.MultiAssets cost,
    required List<int> messageId,
  }) {
    return VersionNotifyUnrequested(
      destination: destination,
      cost: cost,
      messageId: messageId,
    );
  }

  FeesPaid feesPaid({
    required _i4.MultiLocation paying,
    required _i10.MultiAssets fees,
  }) {
    return FeesPaid(
      paying: paying,
      fees: fees,
    );
  }

  AssetsClaimed assetsClaimed({
    required _i8.H256 hash,
    required _i4.MultiLocation origin,
    required _i9.VersionedMultiAssets assets,
  }) {
    return AssetsClaimed(
      hash: hash,
      origin: origin,
      assets: assets,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Attempted._decode(input);
      case 1:
        return Sent._decode(input);
      case 2:
        return UnexpectedResponse._decode(input);
      case 3:
        return ResponseReady._decode(input);
      case 4:
        return Notified._decode(input);
      case 5:
        return NotifyOverweight._decode(input);
      case 6:
        return NotifyDispatchError._decode(input);
      case 7:
        return NotifyDecodeFailed._decode(input);
      case 8:
        return InvalidResponder._decode(input);
      case 9:
        return InvalidResponderVersion._decode(input);
      case 10:
        return ResponseTaken._decode(input);
      case 11:
        return AssetsTrapped._decode(input);
      case 12:
        return VersionChangeNotified._decode(input);
      case 13:
        return SupportedVersionChanged._decode(input);
      case 14:
        return NotifyTargetSendFail._decode(input);
      case 15:
        return NotifyTargetMigrationFail._decode(input);
      case 16:
        return InvalidQuerierVersion._decode(input);
      case 17:
        return InvalidQuerier._decode(input);
      case 18:
        return VersionNotifyStarted._decode(input);
      case 19:
        return VersionNotifyRequested._decode(input);
      case 20:
        return VersionNotifyUnrequested._decode(input);
      case 21:
        return FeesPaid._decode(input);
      case 22:
        return AssetsClaimed._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Attempted:
        (value as Attempted).encodeTo(output);
        break;
      case Sent:
        (value as Sent).encodeTo(output);
        break;
      case UnexpectedResponse:
        (value as UnexpectedResponse).encodeTo(output);
        break;
      case ResponseReady:
        (value as ResponseReady).encodeTo(output);
        break;
      case Notified:
        (value as Notified).encodeTo(output);
        break;
      case NotifyOverweight:
        (value as NotifyOverweight).encodeTo(output);
        break;
      case NotifyDispatchError:
        (value as NotifyDispatchError).encodeTo(output);
        break;
      case NotifyDecodeFailed:
        (value as NotifyDecodeFailed).encodeTo(output);
        break;
      case InvalidResponder:
        (value as InvalidResponder).encodeTo(output);
        break;
      case InvalidResponderVersion:
        (value as InvalidResponderVersion).encodeTo(output);
        break;
      case ResponseTaken:
        (value as ResponseTaken).encodeTo(output);
        break;
      case AssetsTrapped:
        (value as AssetsTrapped).encodeTo(output);
        break;
      case VersionChangeNotified:
        (value as VersionChangeNotified).encodeTo(output);
        break;
      case SupportedVersionChanged:
        (value as SupportedVersionChanged).encodeTo(output);
        break;
      case NotifyTargetSendFail:
        (value as NotifyTargetSendFail).encodeTo(output);
        break;
      case NotifyTargetMigrationFail:
        (value as NotifyTargetMigrationFail).encodeTo(output);
        break;
      case InvalidQuerierVersion:
        (value as InvalidQuerierVersion).encodeTo(output);
        break;
      case InvalidQuerier:
        (value as InvalidQuerier).encodeTo(output);
        break;
      case VersionNotifyStarted:
        (value as VersionNotifyStarted).encodeTo(output);
        break;
      case VersionNotifyRequested:
        (value as VersionNotifyRequested).encodeTo(output);
        break;
      case VersionNotifyUnrequested:
        (value as VersionNotifyUnrequested).encodeTo(output);
        break;
      case FeesPaid:
        (value as FeesPaid).encodeTo(output);
        break;
      case AssetsClaimed:
        (value as AssetsClaimed).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Attempted:
        return (value as Attempted)._sizeHint();
      case Sent:
        return (value as Sent)._sizeHint();
      case UnexpectedResponse:
        return (value as UnexpectedResponse)._sizeHint();
      case ResponseReady:
        return (value as ResponseReady)._sizeHint();
      case Notified:
        return (value as Notified)._sizeHint();
      case NotifyOverweight:
        return (value as NotifyOverweight)._sizeHint();
      case NotifyDispatchError:
        return (value as NotifyDispatchError)._sizeHint();
      case NotifyDecodeFailed:
        return (value as NotifyDecodeFailed)._sizeHint();
      case InvalidResponder:
        return (value as InvalidResponder)._sizeHint();
      case InvalidResponderVersion:
        return (value as InvalidResponderVersion)._sizeHint();
      case ResponseTaken:
        return (value as ResponseTaken)._sizeHint();
      case AssetsTrapped:
        return (value as AssetsTrapped)._sizeHint();
      case VersionChangeNotified:
        return (value as VersionChangeNotified)._sizeHint();
      case SupportedVersionChanged:
        return (value as SupportedVersionChanged)._sizeHint();
      case NotifyTargetSendFail:
        return (value as NotifyTargetSendFail)._sizeHint();
      case NotifyTargetMigrationFail:
        return (value as NotifyTargetMigrationFail)._sizeHint();
      case InvalidQuerierVersion:
        return (value as InvalidQuerierVersion)._sizeHint();
      case InvalidQuerier:
        return (value as InvalidQuerier)._sizeHint();
      case VersionNotifyStarted:
        return (value as VersionNotifyStarted)._sizeHint();
      case VersionNotifyRequested:
        return (value as VersionNotifyRequested)._sizeHint();
      case VersionNotifyUnrequested:
        return (value as VersionNotifyUnrequested)._sizeHint();
      case FeesPaid:
        return (value as FeesPaid)._sizeHint();
      case AssetsClaimed:
        return (value as AssetsClaimed)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Execution of an XCM message was attempted.
class Attempted extends Event {
  const Attempted({required this.outcome});

  factory Attempted._decode(_i1.Input input) {
    return Attempted(
      outcome: _i3.Outcome.codec.decode(input),
    );
  }

  final _i3.Outcome outcome;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'Attempted': {'outcome': outcome.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Outcome.codec.sizeHint(outcome);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Outcome.codec.encodeTo(
      outcome,
      output,
    );
  }
}

/// A XCM message was sent.
class Sent extends Event {
  const Sent({
    required this.origin,
    required this.destination,
    required this.message,
    required this.messageId,
  });

  factory Sent._decode(_i1.Input input) {
    return Sent(
      origin: _i4.MultiLocation.codec.decode(input),
      destination: _i4.MultiLocation.codec.decode(input),
      message: const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i4.MultiLocation origin;

  final _i4.MultiLocation destination;

  final _i5.Xcm message;

  final List<int> messageId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Sent': {
          'origin': origin.toJson(),
          'destination': destination.toJson(),
          'message': message.map((value) => value.toJson()).toList(),
          'messageId': messageId.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i4.MultiLocation.codec.sizeHint(destination);
    size = size + const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).sizeHint(message);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      destination,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
      message,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
  }
}

/// Query response received which does not match a registered query. This may be because a
/// matching query was never registered, it may be because it is a duplicate response, or
/// because the query timed out.
class UnexpectedResponse extends Event {
  const UnexpectedResponse({
    required this.origin,
    required this.queryId,
  });

  factory UnexpectedResponse._decode(_i1.Input input) {
    return UnexpectedResponse(
      origin: _i4.MultiLocation.codec.decode(input),
      queryId: _i1.U64Codec.codec.decode(input),
    );
  }

  final _i4.MultiLocation origin;

  final BigInt queryId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'UnexpectedResponse': {
          'origin': origin.toJson(),
          'queryId': queryId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
  }
}

/// Query response has been received and is ready for taking with `take_response`. There is
/// no registered notification call.
class ResponseReady extends Event {
  const ResponseReady({
    required this.queryId,
    required this.response,
  });

  factory ResponseReady._decode(_i1.Input input) {
    return ResponseReady(
      queryId: _i1.U64Codec.codec.decode(input),
      response: _i6.Response.codec.decode(input),
    );
  }

  final BigInt queryId;

  final _i6.Response response;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ResponseReady': {
          'queryId': queryId,
          'response': response.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + _i6.Response.codec.sizeHint(response);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    _i6.Response.codec.encodeTo(
      response,
      output,
    );
  }
}

/// Query response has been received and query is removed. The registered notification has
/// been dispatched and executed successfully.
class Notified extends Event {
  const Notified({
    required this.queryId,
    required this.palletIndex,
    required this.callIndex,
  });

  factory Notified._decode(_i1.Input input) {
    return Notified(
      queryId: _i1.U64Codec.codec.decode(input),
      palletIndex: _i1.U8Codec.codec.decode(input),
      callIndex: _i1.U8Codec.codec.decode(input),
    );
  }

  final BigInt queryId;

  final int palletIndex;

  final int callIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Notified': {
          'queryId': queryId,
          'palletIndex': palletIndex,
          'callIndex': callIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + _i1.U8Codec.codec.sizeHint(palletIndex);
    size = size + _i1.U8Codec.codec.sizeHint(callIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      palletIndex,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      callIndex,
      output,
    );
  }
}

/// Query response has been received and query is removed. The registered notification could
/// not be dispatched because the dispatch weight is greater than the maximum weight
/// originally budgeted by this runtime for the query result.
class NotifyOverweight extends Event {
  const NotifyOverweight({
    required this.queryId,
    required this.palletIndex,
    required this.callIndex,
    required this.actualWeight,
    required this.maxBudgetedWeight,
  });

  factory NotifyOverweight._decode(_i1.Input input) {
    return NotifyOverweight(
      queryId: _i1.U64Codec.codec.decode(input),
      palletIndex: _i1.U8Codec.codec.decode(input),
      callIndex: _i1.U8Codec.codec.decode(input),
      actualWeight: _i7.Weight.codec.decode(input),
      maxBudgetedWeight: _i7.Weight.codec.decode(input),
    );
  }

  final BigInt queryId;

  final int palletIndex;

  final int callIndex;

  final _i7.Weight actualWeight;

  final _i7.Weight maxBudgetedWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NotifyOverweight': {
          'queryId': queryId,
          'palletIndex': palletIndex,
          'callIndex': callIndex,
          'actualWeight': actualWeight.toJson(),
          'maxBudgetedWeight': maxBudgetedWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + _i1.U8Codec.codec.sizeHint(palletIndex);
    size = size + _i1.U8Codec.codec.sizeHint(callIndex);
    size = size + _i7.Weight.codec.sizeHint(actualWeight);
    size = size + _i7.Weight.codec.sizeHint(maxBudgetedWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      palletIndex,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      callIndex,
      output,
    );
    _i7.Weight.codec.encodeTo(
      actualWeight,
      output,
    );
    _i7.Weight.codec.encodeTo(
      maxBudgetedWeight,
      output,
    );
  }
}

/// Query response has been received and query is removed. There was a general error with
/// dispatching the notification call.
class NotifyDispatchError extends Event {
  const NotifyDispatchError({
    required this.queryId,
    required this.palletIndex,
    required this.callIndex,
  });

  factory NotifyDispatchError._decode(_i1.Input input) {
    return NotifyDispatchError(
      queryId: _i1.U64Codec.codec.decode(input),
      palletIndex: _i1.U8Codec.codec.decode(input),
      callIndex: _i1.U8Codec.codec.decode(input),
    );
  }

  final BigInt queryId;

  final int palletIndex;

  final int callIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NotifyDispatchError': {
          'queryId': queryId,
          'palletIndex': palletIndex,
          'callIndex': callIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + _i1.U8Codec.codec.sizeHint(palletIndex);
    size = size + _i1.U8Codec.codec.sizeHint(callIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      palletIndex,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      callIndex,
      output,
    );
  }
}

/// Query response has been received and query is removed. The dispatch was unable to be
/// decoded into a `Call`; this might be due to dispatch function having a signature which
/// is not `(origin, QueryId, Response)`.
class NotifyDecodeFailed extends Event {
  const NotifyDecodeFailed({
    required this.queryId,
    required this.palletIndex,
    required this.callIndex,
  });

  factory NotifyDecodeFailed._decode(_i1.Input input) {
    return NotifyDecodeFailed(
      queryId: _i1.U64Codec.codec.decode(input),
      palletIndex: _i1.U8Codec.codec.decode(input),
      callIndex: _i1.U8Codec.codec.decode(input),
    );
  }

  final BigInt queryId;

  final int palletIndex;

  final int callIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NotifyDecodeFailed': {
          'queryId': queryId,
          'palletIndex': palletIndex,
          'callIndex': callIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + _i1.U8Codec.codec.sizeHint(palletIndex);
    size = size + _i1.U8Codec.codec.sizeHint(callIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      palletIndex,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      callIndex,
      output,
    );
  }
}

/// Expected query response has been received but the origin location of the response does
/// not match that expected. The query remains registered for a later, valid, response to
/// be received and acted upon.
class InvalidResponder extends Event {
  const InvalidResponder({
    required this.origin,
    required this.queryId,
    this.expectedLocation,
  });

  factory InvalidResponder._decode(_i1.Input input) {
    return InvalidResponder(
      origin: _i4.MultiLocation.codec.decode(input),
      queryId: _i1.U64Codec.codec.decode(input),
      expectedLocation: const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).decode(input),
    );
  }

  final _i4.MultiLocation origin;

  final BigInt queryId;

  final _i4.MultiLocation? expectedLocation;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InvalidResponder': {
          'origin': origin.toJson(),
          'queryId': queryId,
          'expectedLocation': expectedLocation?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).sizeHint(expectedLocation);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).encodeTo(
      expectedLocation,
      output,
    );
  }
}

/// Expected query response has been received but the expected origin location placed in
/// storage by this runtime previously cannot be decoded. The query remains registered.
///
/// This is unexpected (since a location placed in storage in a previously executing
/// runtime should be readable prior to query timeout) and dangerous since the possibly
/// valid response will be dropped. Manual governance intervention is probably going to be
/// needed.
class InvalidResponderVersion extends Event {
  const InvalidResponderVersion({
    required this.origin,
    required this.queryId,
  });

  factory InvalidResponderVersion._decode(_i1.Input input) {
    return InvalidResponderVersion(
      origin: _i4.MultiLocation.codec.decode(input),
      queryId: _i1.U64Codec.codec.decode(input),
    );
  }

  final _i4.MultiLocation origin;

  final BigInt queryId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InvalidResponderVersion': {
          'origin': origin.toJson(),
          'queryId': queryId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
  }
}

/// Received query response has been read and removed.
class ResponseTaken extends Event {
  const ResponseTaken({required this.queryId});

  factory ResponseTaken._decode(_i1.Input input) {
    return ResponseTaken(
      queryId: _i1.U64Codec.codec.decode(input),
    );
  }

  final BigInt queryId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'ResponseTaken': {'queryId': queryId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
  }
}

/// Some assets have been placed in an asset trap.
class AssetsTrapped extends Event {
  const AssetsTrapped({
    required this.hash,
    required this.origin,
    required this.assets,
  });

  factory AssetsTrapped._decode(_i1.Input input) {
    return AssetsTrapped(
      hash: const _i1.U8ArrayCodec(32).decode(input),
      origin: _i4.MultiLocation.codec.decode(input),
      assets: _i9.VersionedMultiAssets.codec.decode(input),
    );
  }

  final _i8.H256 hash;

  final _i4.MultiLocation origin;

  final _i9.VersionedMultiAssets assets;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AssetsTrapped': {
          'hash': hash.toList(),
          'origin': origin.toJson(),
          'assets': assets.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(hash);
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i9.VersionedMultiAssets.codec.sizeHint(assets);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i9.VersionedMultiAssets.codec.encodeTo(
      assets,
      output,
    );
  }
}

/// An XCM version change notification message has been attempted to be sent.
///
/// The cost of sending it (borne by the chain) is included.
class VersionChangeNotified extends Event {
  const VersionChangeNotified({
    required this.destination,
    required this.result,
    required this.cost,
    required this.messageId,
  });

  factory VersionChangeNotified._decode(_i1.Input input) {
    return VersionChangeNotified(
      destination: _i4.MultiLocation.codec.decode(input),
      result: _i1.U32Codec.codec.decode(input),
      cost: const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i4.MultiLocation destination;

  final int result;

  final _i10.MultiAssets cost;

  final List<int> messageId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VersionChangeNotified': {
          'destination': destination.toJson(),
          'result': result,
          'cost': cost.map((value) => value.toJson()).toList(),
          'messageId': messageId.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(destination);
    size = size + _i1.U32Codec.codec.sizeHint(result);
    size = size + const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).sizeHint(cost);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      destination,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      result,
      output,
    );
    const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).encodeTo(
      cost,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
  }
}

/// The supported version of a location has been changed. This might be through an
/// automatic notification or a manual intervention.
class SupportedVersionChanged extends Event {
  const SupportedVersionChanged({
    required this.location,
    required this.version,
  });

  factory SupportedVersionChanged._decode(_i1.Input input) {
    return SupportedVersionChanged(
      location: _i4.MultiLocation.codec.decode(input),
      version: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i4.MultiLocation location;

  final int version;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SupportedVersionChanged': {
          'location': location.toJson(),
          'version': version,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(location);
    size = size + _i1.U32Codec.codec.sizeHint(version);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      location,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      version,
      output,
    );
  }
}

/// A given location which had a version change subscription was dropped owing to an error
/// sending the notification to it.
class NotifyTargetSendFail extends Event {
  const NotifyTargetSendFail({
    required this.location,
    required this.queryId,
    required this.error,
  });

  factory NotifyTargetSendFail._decode(_i1.Input input) {
    return NotifyTargetSendFail(
      location: _i4.MultiLocation.codec.decode(input),
      queryId: _i1.U64Codec.codec.decode(input),
      error: _i11.Error.codec.decode(input),
    );
  }

  final _i4.MultiLocation location;

  final BigInt queryId;

  final _i11.Error error;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NotifyTargetSendFail': {
          'location': location.toJson(),
          'queryId': queryId,
          'error': error.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(location);
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + _i11.Error.codec.sizeHint(error);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      location,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    _i11.Error.codec.encodeTo(
      error,
      output,
    );
  }
}

/// A given location which had a version change subscription was dropped owing to an error
/// migrating the location to our new XCM format.
class NotifyTargetMigrationFail extends Event {
  const NotifyTargetMigrationFail({
    required this.location,
    required this.queryId,
  });

  factory NotifyTargetMigrationFail._decode(_i1.Input input) {
    return NotifyTargetMigrationFail(
      location: _i12.VersionedMultiLocation.codec.decode(input),
      queryId: _i1.U64Codec.codec.decode(input),
    );
  }

  final _i12.VersionedMultiLocation location;

  final BigInt queryId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'NotifyTargetMigrationFail': {
          'location': location.toJson(),
          'queryId': queryId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.VersionedMultiLocation.codec.sizeHint(location);
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i12.VersionedMultiLocation.codec.encodeTo(
      location,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
  }
}

/// Expected query response has been received but the expected querier location placed in
/// storage by this runtime previously cannot be decoded. The query remains registered.
///
/// This is unexpected (since a location placed in storage in a previously executing
/// runtime should be readable prior to query timeout) and dangerous since the possibly
/// valid response will be dropped. Manual governance intervention is probably going to be
/// needed.
class InvalidQuerierVersion extends Event {
  const InvalidQuerierVersion({
    required this.origin,
    required this.queryId,
  });

  factory InvalidQuerierVersion._decode(_i1.Input input) {
    return InvalidQuerierVersion(
      origin: _i4.MultiLocation.codec.decode(input),
      queryId: _i1.U64Codec.codec.decode(input),
    );
  }

  final _i4.MultiLocation origin;

  final BigInt queryId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InvalidQuerierVersion': {
          'origin': origin.toJson(),
          'queryId': queryId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
  }
}

/// Expected query response has been received but the querier location of the response does
/// not match the expected. The query remains registered for a later, valid, response to
/// be received and acted upon.
class InvalidQuerier extends Event {
  const InvalidQuerier({
    required this.origin,
    required this.queryId,
    required this.expectedQuerier,
    this.maybeActualQuerier,
  });

  factory InvalidQuerier._decode(_i1.Input input) {
    return InvalidQuerier(
      origin: _i4.MultiLocation.codec.decode(input),
      queryId: _i1.U64Codec.codec.decode(input),
      expectedQuerier: _i4.MultiLocation.codec.decode(input),
      maybeActualQuerier: const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).decode(input),
    );
  }

  final _i4.MultiLocation origin;

  final BigInt queryId;

  final _i4.MultiLocation expectedQuerier;

  final _i4.MultiLocation? maybeActualQuerier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InvalidQuerier': {
          'origin': origin.toJson(),
          'queryId': queryId,
          'expectedQuerier': expectedQuerier.toJson(),
          'maybeActualQuerier': maybeActualQuerier?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i1.U64Codec.codec.sizeHint(queryId);
    size = size + _i4.MultiLocation.codec.sizeHint(expectedQuerier);
    size = size + const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).sizeHint(maybeActualQuerier);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      queryId,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      expectedQuerier,
      output,
    );
    const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).encodeTo(
      maybeActualQuerier,
      output,
    );
  }
}

/// A remote has requested XCM version change notification from us and we have honored it.
/// A version information message is sent to them and its cost is included.
class VersionNotifyStarted extends Event {
  const VersionNotifyStarted({
    required this.destination,
    required this.cost,
    required this.messageId,
  });

  factory VersionNotifyStarted._decode(_i1.Input input) {
    return VersionNotifyStarted(
      destination: _i4.MultiLocation.codec.decode(input),
      cost: const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i4.MultiLocation destination;

  final _i10.MultiAssets cost;

  final List<int> messageId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VersionNotifyStarted': {
          'destination': destination.toJson(),
          'cost': cost.map((value) => value.toJson()).toList(),
          'messageId': messageId.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(destination);
    size = size + const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).sizeHint(cost);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      destination,
      output,
    );
    const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).encodeTo(
      cost,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
  }
}

/// We have requested that a remote chain send us XCM version change notifications.
class VersionNotifyRequested extends Event {
  const VersionNotifyRequested({
    required this.destination,
    required this.cost,
    required this.messageId,
  });

  factory VersionNotifyRequested._decode(_i1.Input input) {
    return VersionNotifyRequested(
      destination: _i4.MultiLocation.codec.decode(input),
      cost: const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i4.MultiLocation destination;

  final _i10.MultiAssets cost;

  final List<int> messageId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VersionNotifyRequested': {
          'destination': destination.toJson(),
          'cost': cost.map((value) => value.toJson()).toList(),
          'messageId': messageId.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(destination);
    size = size + const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).sizeHint(cost);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      destination,
      output,
    );
    const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).encodeTo(
      cost,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
  }
}

/// We have requested that a remote chain stops sending us XCM version change notifications.
class VersionNotifyUnrequested extends Event {
  const VersionNotifyUnrequested({
    required this.destination,
    required this.cost,
    required this.messageId,
  });

  factory VersionNotifyUnrequested._decode(_i1.Input input) {
    return VersionNotifyUnrequested(
      destination: _i4.MultiLocation.codec.decode(input),
      cost: const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).decode(input),
      messageId: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i4.MultiLocation destination;

  final _i10.MultiAssets cost;

  final List<int> messageId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VersionNotifyUnrequested': {
          'destination': destination.toJson(),
          'cost': cost.map((value) => value.toJson()).toList(),
          'messageId': messageId.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(destination);
    size = size + const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).sizeHint(cost);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(messageId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      destination,
      output,
    );
    const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).encodeTo(
      cost,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      messageId,
      output,
    );
  }
}

/// Fees were paid from a location for an operation (often for using `SendXcm`).
class FeesPaid extends Event {
  const FeesPaid({
    required this.paying,
    required this.fees,
  });

  factory FeesPaid._decode(_i1.Input input) {
    return FeesPaid(
      paying: _i4.MultiLocation.codec.decode(input),
      fees: const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).decode(input),
    );
  }

  final _i4.MultiLocation paying;

  final _i10.MultiAssets fees;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'FeesPaid': {
          'paying': paying.toJson(),
          'fees': fees.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(paying);
    size = size + const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).sizeHint(fees);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      paying,
      output,
    );
    const _i1.SequenceCodec<_i14.MultiAsset>(_i14.MultiAsset.codec).encodeTo(
      fees,
      output,
    );
  }
}

/// Some assets have been claimed from an asset trap
class AssetsClaimed extends Event {
  const AssetsClaimed({
    required this.hash,
    required this.origin,
    required this.assets,
  });

  factory AssetsClaimed._decode(_i1.Input input) {
    return AssetsClaimed(
      hash: const _i1.U8ArrayCodec(32).decode(input),
      origin: _i4.MultiLocation.codec.decode(input),
      assets: _i9.VersionedMultiAssets.codec.decode(input),
    );
  }

  final _i8.H256 hash;

  final _i4.MultiLocation origin;

  final _i9.VersionedMultiAssets assets;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AssetsClaimed': {
          'hash': hash.toList(),
          'origin': origin.toJson(),
          'assets': assets.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(hash);
    size = size + _i4.MultiLocation.codec.sizeHint(origin);
    size = size + _i9.VersionedMultiAssets.codec.sizeHint(assets);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i9.VersionedMultiAssets.codec.encodeTo(
      assets,
      output,
    );
  }
}
