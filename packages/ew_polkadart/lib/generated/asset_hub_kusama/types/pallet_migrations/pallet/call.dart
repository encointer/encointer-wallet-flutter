// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../historic_cleanup_selector.dart' as _i4;
import '../migration_cursor.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  ForceSetCursor forceSetCursor({_i3.MigrationCursor? cursor}) {
    return ForceSetCursor(cursor: cursor);
  }

  ForceSetActiveCursor forceSetActiveCursor({
    required int index,
    List<int>? innerCursor,
    int? startedAt,
  }) {
    return ForceSetActiveCursor(
      index: index,
      innerCursor: innerCursor,
      startedAt: startedAt,
    );
  }

  ForceOnboardMbms forceOnboardMbms() {
    return ForceOnboardMbms();
  }

  ClearHistoric clearHistoric({required _i4.HistoricCleanupSelector selector}) {
    return ClearHistoric(selector: selector);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ForceSetCursor._decode(input);
      case 1:
        return ForceSetActiveCursor._decode(input);
      case 2:
        return const ForceOnboardMbms();
      case 3:
        return ClearHistoric._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ForceSetCursor:
        (value as ForceSetCursor).encodeTo(output);
        break;
      case ForceSetActiveCursor:
        (value as ForceSetActiveCursor).encodeTo(output);
        break;
      case ForceOnboardMbms:
        (value as ForceOnboardMbms).encodeTo(output);
        break;
      case ClearHistoric:
        (value as ClearHistoric).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ForceSetCursor:
        return (value as ForceSetCursor)._sizeHint();
      case ForceSetActiveCursor:
        return (value as ForceSetActiveCursor)._sizeHint();
      case ForceOnboardMbms:
        return 1;
      case ClearHistoric:
        return (value as ClearHistoric)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Allows root to set a cursor to forcefully start, stop or forward the migration process.
///
/// Should normally not be needed and is only in place as emergency measure. Note that
/// restarting the migration process in this manner will not call the
/// [`MigrationStatusHandler::started`] hook or emit an `UpgradeStarted` event.
class ForceSetCursor extends Call {
  const ForceSetCursor({this.cursor});

  factory ForceSetCursor._decode(_i1.Input input) {
    return ForceSetCursor(cursor: const _i1.OptionCodec<_i3.MigrationCursor>(_i3.MigrationCursor.codec).decode(input));
  }

  /// Option<CursorOf<T>>
  final _i3.MigrationCursor? cursor;

  @override
  Map<String, Map<String, Map<String, dynamic>?>> toJson() => {
        'force_set_cursor': {'cursor': cursor?.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<_i3.MigrationCursor>(_i3.MigrationCursor.codec).sizeHint(cursor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.OptionCodec<_i3.MigrationCursor>(_i3.MigrationCursor.codec).encodeTo(
      cursor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceSetCursor && other.cursor == cursor;

  @override
  int get hashCode => cursor.hashCode;
}

/// Allows root to set an active cursor to forcefully start/forward the migration process.
///
/// This is an edge-case version of [`Self::force_set_cursor`] that allows to set the
/// `started_at` value to the next block number. Otherwise this would not be possible, since
/// `force_set_cursor` takes an absolute block number. Setting `started_at` to `None`
/// indicates that the current block number plus one should be used.
class ForceSetActiveCursor extends Call {
  const ForceSetActiveCursor({
    required this.index,
    this.innerCursor,
    this.startedAt,
  });

  factory ForceSetActiveCursor._decode(_i1.Input input) {
    return ForceSetActiveCursor(
      index: _i1.U32Codec.codec.decode(input),
      innerCursor: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input),
      startedAt: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// u32
  final int index;

  /// Option<RawCursorOf<T>>
  final List<int>? innerCursor;

  /// Option<BlockNumberFor<T>>
  final int? startedAt;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_set_active_cursor': {
          'index': index,
          'innerCursor': innerCursor,
          'startedAt': startedAt,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(innerCursor);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(startedAt);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      innerCursor,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      startedAt,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceSetActiveCursor &&
          other.index == index &&
          other.innerCursor == innerCursor &&
          other.startedAt == startedAt;

  @override
  int get hashCode => Object.hash(
        index,
        innerCursor,
        startedAt,
      );
}

/// Forces the onboarding of the migrations.
///
/// This process happens automatically on a runtime upgrade. It is in place as an emergency
/// measurement. The cursor needs to be `None` for this to succeed.
class ForceOnboardMbms extends Call {
  const ForceOnboardMbms();

  @override
  Map<String, dynamic> toJson() => {'force_onboard_mbms': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ForceOnboardMbms;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Clears the `Historic` set.
///
/// `map_cursor` must be set to the last value that was returned by the
/// `HistoricCleared` event. The first time `None` can be used. `limit` must be chosen in a
/// way that will result in a sensible weight.
class ClearHistoric extends Call {
  const ClearHistoric({required this.selector});

  factory ClearHistoric._decode(_i1.Input input) {
    return ClearHistoric(selector: _i4.HistoricCleanupSelector.codec.decode(input));
  }

  /// HistoricCleanupSelector<IdentifierOf<T>>
  final _i4.HistoricCleanupSelector selector;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'clear_historic': {'selector': selector.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.HistoricCleanupSelector.codec.sizeHint(selector);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i4.HistoricCleanupSelector.codec.encodeTo(
      selector,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearHistoric && other.selector == selector;

  @override
  int get hashCode => selector.hashCode;
}
