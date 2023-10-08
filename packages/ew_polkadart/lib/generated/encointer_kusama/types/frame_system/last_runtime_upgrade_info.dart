// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class LastRuntimeUpgradeInfo {
  const LastRuntimeUpgradeInfo({
    required this.specVersion,
    required this.specName,
  });

  factory LastRuntimeUpgradeInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt specVersion;

  final String specName;

  static const $LastRuntimeUpgradeInfoCodec codec = $LastRuntimeUpgradeInfoCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'specVersion': specVersion,
        'specName': specName,
      };
}

class $LastRuntimeUpgradeInfoCodec with _i1.Codec<LastRuntimeUpgradeInfo> {
  const $LastRuntimeUpgradeInfoCodec();

  @override
  void encodeTo(
    LastRuntimeUpgradeInfo obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.specVersion,
      output,
    );
    _i1.StrCodec.codec.encodeTo(
      obj.specName,
      output,
    );
  }

  @override
  LastRuntimeUpgradeInfo decode(_i1.Input input) {
    return LastRuntimeUpgradeInfo(
      specVersion: _i1.CompactBigIntCodec.codec.decode(input),
      specName: _i1.StrCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(LastRuntimeUpgradeInfo obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.specVersion);
    size = size + _i1.StrCodec.codec.sizeHint(obj.specName);
    return size;
  }
}
