// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class ActiveCursor {
  const ActiveCursor({
    required this.index,
    this.innerCursor,
    required this.startedAt,
  });

  factory ActiveCursor.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int index;

  /// Option<Cursor>
  final List<int>? innerCursor;

  /// BlockNumber
  final int startedAt;

  static const $ActiveCursorCodec codec = $ActiveCursorCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'innerCursor': innerCursor,
        'startedAt': startedAt,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ActiveCursor && other.index == index && other.innerCursor == innerCursor && other.startedAt == startedAt;

  @override
  int get hashCode => Object.hash(
        index,
        innerCursor,
        startedAt,
      );
}

class $ActiveCursorCodec with _i1.Codec<ActiveCursor> {
  const $ActiveCursorCodec();

  @override
  void encodeTo(
    ActiveCursor obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.index,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.innerCursor,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.startedAt,
      output,
    );
  }

  @override
  ActiveCursor decode(_i1.Input input) {
    return ActiveCursor(
      index: _i1.U32Codec.codec.decode(input),
      innerCursor: const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input),
      startedAt: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ActiveCursor obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.index);
    size = size + const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(obj.innerCursor);
    size = size + _i1.U32Codec.codec.sizeHint(obj.startedAt);
    return size;
  }
}
