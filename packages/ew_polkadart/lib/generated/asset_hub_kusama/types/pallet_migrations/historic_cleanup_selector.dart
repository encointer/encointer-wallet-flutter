// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class HistoricCleanupSelector {
  const HistoricCleanupSelector();

  factory HistoricCleanupSelector.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $HistoricCleanupSelectorCodec codec = $HistoricCleanupSelectorCodec();

  static const $HistoricCleanupSelector values = $HistoricCleanupSelector();

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

class $HistoricCleanupSelector {
  const $HistoricCleanupSelector();

  Specific specific(List<List<int>> value0) {
    return Specific(value0);
  }

  Wildcard wildcard({
    int? limit,
    List<int>? previousCursor,
  }) {
    return Wildcard(
      limit: limit,
      previousCursor: previousCursor,
    );
  }
}

class $HistoricCleanupSelectorCodec with _i1.Codec<HistoricCleanupSelector> {
  const $HistoricCleanupSelectorCodec();

  @override
  HistoricCleanupSelector decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Specific._decode(input);
      case 1:
        return Wildcard._decode(input);
      default:
        throw Exception('HistoricCleanupSelector: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    HistoricCleanupSelector value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Specific:
        (value as Specific).encodeTo(output);
        break;
      case Wildcard:
        (value as Wildcard).encodeTo(output);
        break;
      default:
        throw Exception('HistoricCleanupSelector: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(HistoricCleanupSelector value) {
    switch (value.runtimeType) {
      case Specific:
        return (value as Specific)._sizeHint();
      case Wildcard:
        return (value as Wildcard)._sizeHint();
      default:
        throw Exception('HistoricCleanupSelector: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Specific extends HistoricCleanupSelector {
  const Specific(this.value0);

  factory Specific._decode(_i1.Input input) {
    return Specific(const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input));
  }

  /// Vec<Id>
  final List<List<int>> value0;

  @override
  Map<String, List<List<int>>> toJson() => {'Specific': value0.map((value) => value).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Specific &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Wildcard extends HistoricCleanupSelector {
  const Wildcard({
    this.limit,
    this.previousCursor,
  });

  factory Wildcard._decode(_i1.Input input) {
    return Wildcard(
      limit: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      previousCursor: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input),
    );
  }

  /// Option<u32>
  final int? limit;

  /// Option<Vec<u8>>
  final List<int>? previousCursor;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Wildcard': {
          'limit': limit,
          'previousCursor': previousCursor,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(limit);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(previousCursor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      limit,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      previousCursor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Wildcard && other.limit == limit && other.previousCursor == previousCursor;

  @override
  int get hashCode => Object.hash(
        limit,
        previousCursor,
      );
}
