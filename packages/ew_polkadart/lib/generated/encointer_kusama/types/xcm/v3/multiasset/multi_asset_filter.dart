// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import 'multi_assets.dart' as _i3;
import 'wild_multi_asset.dart' as _i4;
import 'multi_asset.dart' as _i5;

abstract class MultiAssetFilter {
  const MultiAssetFilter();

  factory MultiAssetFilter.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $MultiAssetFilterCodec codec = $MultiAssetFilterCodec();

  static const $MultiAssetFilter values = $MultiAssetFilter();

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

class $MultiAssetFilter {
  const $MultiAssetFilter();

  Definite definite({required _i3.MultiAssets value0}) {
    return Definite(
      value0: value0,
    );
  }

  Wild wild({required _i4.WildMultiAsset value0}) {
    return Wild(
      value0: value0,
    );
  }
}

class $MultiAssetFilterCodec with _i1.Codec<MultiAssetFilter> {
  const $MultiAssetFilterCodec();

  @override
  MultiAssetFilter decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Definite._decode(input);
      case 1:
        return Wild._decode(input);
      default:
        throw Exception('MultiAssetFilter: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MultiAssetFilter value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Definite:
        (value as Definite).encodeTo(output);
        break;
      case Wild:
        (value as Wild).encodeTo(output);
        break;
      default:
        throw Exception('MultiAssetFilter: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(MultiAssetFilter value) {
    switch (value.runtimeType) {
      case Definite:
        return (value as Definite)._sizeHint();
      case Wild:
        return (value as Wild)._sizeHint();
      default:
        throw Exception('MultiAssetFilter: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Definite extends MultiAssetFilter {
  const Definite({required this.value0});

  factory Definite._decode(_i1.Input input) {
    return Definite(
      value0: const _i1.SequenceCodec<_i5.MultiAsset>(_i5.MultiAsset.codec).decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'Definite': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i5.MultiAsset>(_i5.MultiAsset.codec).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i5.MultiAsset>(_i5.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class Wild extends MultiAssetFilter {
  const Wild({required this.value0});

  factory Wild._decode(_i1.Input input) {
    return Wild(
      value0: _i4.WildMultiAsset.codec.decode(input),
    );
  }

  final _i4.WildMultiAsset value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Wild': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.WildMultiAsset.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.WildMultiAsset.codec.encodeTo(
      value0,
      output,
    );
  }
}
