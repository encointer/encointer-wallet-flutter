// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class PageIndexData {
  const PageIndexData({
    required this.beginUsed,
    required this.endUsed,
    required this.overweightCount,
  });

  factory PageIndexData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// PageCounter
  final int beginUsed;

  /// PageCounter
  final int endUsed;

  /// OverweightIndex
  final BigInt overweightCount;

  static const $PageIndexDataCodec codec = $PageIndexDataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'beginUsed': beginUsed,
        'endUsed': endUsed,
        'overweightCount': overweightCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PageIndexData &&
          other.beginUsed == beginUsed &&
          other.endUsed == endUsed &&
          other.overweightCount == overweightCount;

  @override
  int get hashCode => Object.hash(
        beginUsed,
        endUsed,
        overweightCount,
      );
}

class $PageIndexDataCodec with _i1.Codec<PageIndexData> {
  const $PageIndexDataCodec();

  @override
  void encodeTo(
    PageIndexData obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.beginUsed,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.endUsed,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.overweightCount,
      output,
    );
  }

  @override
  PageIndexData decode(_i1.Input input) {
    return PageIndexData(
      beginUsed: _i1.U32Codec.codec.decode(input),
      endUsed: _i1.U32Codec.codec.decode(input),
      overweightCount: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PageIndexData obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.beginUsed);
    size = size + _i1.U32Codec.codec.sizeHint(obj.endUsed);
    size = size + _i1.U64Codec.codec.sizeHint(obj.overweightCount);
    return size;
  }
}
