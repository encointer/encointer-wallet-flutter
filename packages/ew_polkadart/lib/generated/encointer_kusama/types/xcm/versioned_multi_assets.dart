// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import 'v2/multiasset/multi_assets.dart' as _i3;
import 'v3/multiasset/multi_assets.dart' as _i4;
import 'v2/multiasset/multi_asset.dart' as _i5;
import 'v3/multiasset/multi_asset.dart' as _i6;

abstract class VersionedMultiAssets {
  const VersionedMultiAssets();

  factory VersionedMultiAssets.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionedMultiAssetsCodec codec = $VersionedMultiAssetsCodec();

  static const $VersionedMultiAssets values = $VersionedMultiAssets();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<Map<String, Map<String, dynamic>>>> toJson();
}

class $VersionedMultiAssets {
  const $VersionedMultiAssets();

  V2 v2({required _i3.MultiAssets value0}) {
    return V2(
      value0: value0,
    );
  }

  V3 v3({required _i4.MultiAssets value0}) {
    return V3(
      value0: value0,
    );
  }
}

class $VersionedMultiAssetsCodec with _i1.Codec<VersionedMultiAssets> {
  const $VersionedMultiAssetsCodec();

  @override
  VersionedMultiAssets decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return V2._decode(input);
      case 3:
        return V3._decode(input);
      default:
        throw Exception(
            'VersionedMultiAssets: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionedMultiAssets value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case V2:
        (value as V2).encodeTo(output);
        break;
      case V3:
        (value as V3).encodeTo(output);
        break;
      default:
        throw Exception(
            'VersionedMultiAssets: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionedMultiAssets value) {
    switch (value.runtimeType) {
      case V2:
        return (value as V2)._sizeHint();
      case V3:
        return (value as V3)._sizeHint();
      default:
        throw Exception(
            'VersionedMultiAssets: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V2 extends VersionedMultiAssets {
  const V2({required this.value0});

  factory V2._decode(_i1.Input input) {
    return V2(
      value0: const _i1.SequenceCodec<_i5.MultiAsset>(_i5.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'V2': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i5.MultiAsset>(_i5.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.SequenceCodec<_i5.MultiAsset>(_i5.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class V3 extends VersionedMultiAssets {
  const V3({required this.value0});

  factory V3._decode(_i1.Input input) {
    return V3(
      value0: const _i1.SequenceCodec<_i6.MultiAsset>(_i6.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i4.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'V3': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i6.MultiAsset>(_i6.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.SequenceCodec<_i6.MultiAsset>(_i6.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}
