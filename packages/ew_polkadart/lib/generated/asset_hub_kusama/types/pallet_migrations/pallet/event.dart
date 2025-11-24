// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  UpgradeStarted upgradeStarted({required int migrations}) {
    return UpgradeStarted(migrations: migrations);
  }

  UpgradeCompleted upgradeCompleted() {
    return UpgradeCompleted();
  }

  UpgradeFailed upgradeFailed() {
    return UpgradeFailed();
  }

  MigrationSkipped migrationSkipped({required int index}) {
    return MigrationSkipped(index: index);
  }

  MigrationAdvanced migrationAdvanced({
    required int index,
    required int took,
  }) {
    return MigrationAdvanced(
      index: index,
      took: took,
    );
  }

  MigrationCompleted migrationCompleted({
    required int index,
    required int took,
  }) {
    return MigrationCompleted(
      index: index,
      took: took,
    );
  }

  MigrationFailed migrationFailed({
    required int index,
    required int took,
  }) {
    return MigrationFailed(
      index: index,
      took: took,
    );
  }

  HistoricCleared historicCleared({List<int>? nextCursor}) {
    return HistoricCleared(nextCursor: nextCursor);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return UpgradeStarted._decode(input);
      case 1:
        return const UpgradeCompleted();
      case 2:
        return const UpgradeFailed();
      case 3:
        return MigrationSkipped._decode(input);
      case 4:
        return MigrationAdvanced._decode(input);
      case 5:
        return MigrationCompleted._decode(input);
      case 6:
        return MigrationFailed._decode(input);
      case 7:
        return HistoricCleared._decode(input);
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
      case UpgradeStarted:
        (value as UpgradeStarted).encodeTo(output);
        break;
      case UpgradeCompleted:
        (value as UpgradeCompleted).encodeTo(output);
        break;
      case UpgradeFailed:
        (value as UpgradeFailed).encodeTo(output);
        break;
      case MigrationSkipped:
        (value as MigrationSkipped).encodeTo(output);
        break;
      case MigrationAdvanced:
        (value as MigrationAdvanced).encodeTo(output);
        break;
      case MigrationCompleted:
        (value as MigrationCompleted).encodeTo(output);
        break;
      case MigrationFailed:
        (value as MigrationFailed).encodeTo(output);
        break;
      case HistoricCleared:
        (value as HistoricCleared).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case UpgradeStarted:
        return (value as UpgradeStarted)._sizeHint();
      case UpgradeCompleted:
        return 1;
      case UpgradeFailed:
        return 1;
      case MigrationSkipped:
        return (value as MigrationSkipped)._sizeHint();
      case MigrationAdvanced:
        return (value as MigrationAdvanced)._sizeHint();
      case MigrationCompleted:
        return (value as MigrationCompleted)._sizeHint();
      case MigrationFailed:
        return (value as MigrationFailed)._sizeHint();
      case HistoricCleared:
        return (value as HistoricCleared)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A Runtime upgrade started.
///
/// Its end is indicated by `UpgradeCompleted` or `UpgradeFailed`.
class UpgradeStarted extends Event {
  const UpgradeStarted({required this.migrations});

  factory UpgradeStarted._decode(_i1.Input input) {
    return UpgradeStarted(migrations: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  /// The number of migrations that this upgrade contains.
  ///
  /// This can be used to design a progress indicator in combination with counting the
  /// `MigrationCompleted` and `MigrationSkipped` events.
  final int migrations;

  @override
  Map<String, Map<String, int>> toJson() => {
        'UpgradeStarted': {'migrations': migrations}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(migrations);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      migrations,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpgradeStarted && other.migrations == migrations;

  @override
  int get hashCode => migrations.hashCode;
}

/// The current runtime upgrade completed.
///
/// This implies that all of its migrations completed successfully as well.
class UpgradeCompleted extends Event {
  const UpgradeCompleted();

  @override
  Map<String, dynamic> toJson() => {'UpgradeCompleted': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UpgradeCompleted;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Runtime upgrade failed.
///
/// This is very bad and will require governance intervention.
class UpgradeFailed extends Event {
  const UpgradeFailed();

  @override
  Map<String, dynamic> toJson() => {'UpgradeFailed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UpgradeFailed;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A migration was skipped since it was already executed in the past.
class MigrationSkipped extends Event {
  const MigrationSkipped({required this.index});

  factory MigrationSkipped._decode(_i1.Input input) {
    return MigrationSkipped(index: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  /// The index of the skipped migration within the [`Config::Migrations`] list.
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'MigrationSkipped': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrationSkipped && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A migration progressed.
class MigrationAdvanced extends Event {
  const MigrationAdvanced({
    required this.index,
    required this.took,
  });

  factory MigrationAdvanced._decode(_i1.Input input) {
    return MigrationAdvanced(
      index: _i1.U32Codec.codec.decode(input),
      took: _i1.U32Codec.codec.decode(input),
    );
  }

  /// u32
  /// The index of the migration within the [`Config::Migrations`] list.
  final int index;

  /// BlockNumberFor<T>
  /// The number of blocks that this migration took so far.
  final int took;

  @override
  Map<String, Map<String, int>> toJson() => {
        'MigrationAdvanced': {
          'index': index,
          'took': took,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U32Codec.codec.sizeHint(took);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      took,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrationAdvanced && other.index == index && other.took == took;

  @override
  int get hashCode => Object.hash(
        index,
        took,
      );
}

/// A Migration completed.
class MigrationCompleted extends Event {
  const MigrationCompleted({
    required this.index,
    required this.took,
  });

  factory MigrationCompleted._decode(_i1.Input input) {
    return MigrationCompleted(
      index: _i1.U32Codec.codec.decode(input),
      took: _i1.U32Codec.codec.decode(input),
    );
  }

  /// u32
  /// The index of the migration within the [`Config::Migrations`] list.
  final int index;

  /// BlockNumberFor<T>
  /// The number of blocks that this migration took so far.
  final int took;

  @override
  Map<String, Map<String, int>> toJson() => {
        'MigrationCompleted': {
          'index': index,
          'took': took,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U32Codec.codec.sizeHint(took);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      took,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrationCompleted && other.index == index && other.took == took;

  @override
  int get hashCode => Object.hash(
        index,
        took,
      );
}

/// A Migration failed.
///
/// This implies that the whole upgrade failed and governance intervention is required.
class MigrationFailed extends Event {
  const MigrationFailed({
    required this.index,
    required this.took,
  });

  factory MigrationFailed._decode(_i1.Input input) {
    return MigrationFailed(
      index: _i1.U32Codec.codec.decode(input),
      took: _i1.U32Codec.codec.decode(input),
    );
  }

  /// u32
  /// The index of the migration within the [`Config::Migrations`] list.
  final int index;

  /// BlockNumberFor<T>
  /// The number of blocks that this migration took so far.
  final int took;

  @override
  Map<String, Map<String, int>> toJson() => {
        'MigrationFailed': {
          'index': index,
          'took': took,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U32Codec.codec.sizeHint(took);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      took,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrationFailed && other.index == index && other.took == took;

  @override
  int get hashCode => Object.hash(
        index,
        took,
      );
}

/// The set of historical migrations has been cleared.
class HistoricCleared extends Event {
  const HistoricCleared({this.nextCursor});

  factory HistoricCleared._decode(_i1.Input input) {
    return HistoricCleared(nextCursor: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input));
  }

  /// Option<Vec<u8>>
  /// Should be passed to `clear_historic` in a successive call.
  final List<int>? nextCursor;

  @override
  Map<String, Map<String, List<int>?>> toJson() => {
        'HistoricCleared': {'nextCursor': nextCursor}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(nextCursor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      nextCursor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HistoricCleared && other.nextCursor == nextCursor;

  @override
  int get hashCode => nextCursor.hashCode;
}
