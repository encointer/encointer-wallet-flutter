// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class PoolInfo {
  const PoolInfo({required this.lpToken});

  factory PoolInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// PoolAssetId
  final int lpToken;

  static const $PoolInfoCodec codec = $PoolInfoCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {'lpToken': lpToken};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PoolInfo && other.lpToken == lpToken;

  @override
  int get hashCode => lpToken.hashCode;
}

class $PoolInfoCodec with _i1.Codec<PoolInfo> {
  const $PoolInfoCodec();

  @override
  void encodeTo(
    PoolInfo obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.lpToken,
      output,
    );
  }

  @override
  PoolInfo decode(_i1.Input input) {
    return PoolInfo(lpToken: _i1.U32Codec.codec.decode(input));
  }

  @override
  int sizeHint(PoolInfo obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.lpToken);
    return size;
  }
}
