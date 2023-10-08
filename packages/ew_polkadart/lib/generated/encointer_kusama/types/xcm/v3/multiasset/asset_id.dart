// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../multilocation/multi_location.dart' as _i3;

abstract class AssetId {
  const AssetId();

  factory AssetId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AssetIdCodec codec = $AssetIdCodec();

  static const $AssetId values = $AssetId();

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

class $AssetId {
  const $AssetId();

  Concrete concrete({required _i3.MultiLocation value0}) {
    return Concrete(
      value0: value0,
    );
  }

  Abstract abstract({required List<int> value0}) {
    return Abstract(
      value0: value0,
    );
  }
}

class $AssetIdCodec with _i1.Codec<AssetId> {
  const $AssetIdCodec();

  @override
  AssetId decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Concrete._decode(input);
      case 1:
        return Abstract._decode(input);
      default:
        throw Exception('AssetId: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AssetId value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Concrete:
        (value as Concrete).encodeTo(output);
        break;
      case Abstract:
        (value as Abstract).encodeTo(output);
        break;
      default:
        throw Exception('AssetId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AssetId value) {
    switch (value.runtimeType) {
      case Concrete:
        return (value as Concrete)._sizeHint();
      case Abstract:
        return (value as Abstract)._sizeHint();
      default:
        throw Exception('AssetId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Concrete extends AssetId {
  const Concrete({required this.value0});

  factory Concrete._decode(_i1.Input input) {
    return Concrete(
      value0: _i3.MultiLocation.codec.decode(input),
    );
  }

  final _i3.MultiLocation value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Concrete': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiLocation.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Abstract extends AssetId {
  const Abstract({required this.value0});

  factory Abstract._decode(_i1.Input input) {
    return Abstract(
      value0: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Abstract': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
  }
}
