// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../cow_1.dart' as _i2;

class LastRuntimeUpgradeInfo {
  const LastRuntimeUpgradeInfo({
    required this.specVersion,
    required this.specName,
  });

  factory LastRuntimeUpgradeInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// codec::Compact<u32>
  final BigInt specVersion;

  /// Cow<'static, str>
  final _i2.Cow specName;

  static const $LastRuntimeUpgradeInfoCodec codec = $LastRuntimeUpgradeInfoCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'specVersion': specVersion,
        'specName': specName,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LastRuntimeUpgradeInfo && other.specVersion == specVersion && other.specName == specName;

  @override
  int get hashCode => Object.hash(
        specVersion,
        specName,
      );
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
    size = size + const _i2.CowCodec().sizeHint(obj.specName);
    return size;
  }

  @override
  bool isSizeZero() => _i1.CompactBigIntCodec.codec.isSizeZero() && const _i2.CowCodec().isSizeZero();
}
