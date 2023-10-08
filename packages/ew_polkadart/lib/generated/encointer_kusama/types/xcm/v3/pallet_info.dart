// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class PalletInfo {
  const PalletInfo({
    required this.index,
    required this.name,
    required this.moduleName,
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory PalletInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt index;

  final List<int> name;

  final List<int> moduleName;

  final BigInt major;

  final BigInt minor;

  final BigInt patch;

  static const $PalletInfoCodec codec = $PalletInfoCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'name': name,
        'moduleName': moduleName,
        'major': major,
        'minor': minor,
        'patch': patch,
      };
}

class $PalletInfoCodec with _i1.Codec<PalletInfo> {
  const $PalletInfoCodec();

  @override
  void encodeTo(
    PalletInfo obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.index,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.name,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.moduleName,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.major,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.minor,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.patch,
      output,
    );
  }

  @override
  PalletInfo decode(_i1.Input input) {
    return PalletInfo(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      name: _i1.U8SequenceCodec.codec.decode(input),
      moduleName: _i1.U8SequenceCodec.codec.decode(input),
      major: _i1.CompactBigIntCodec.codec.decode(input),
      minor: _i1.CompactBigIntCodec.codec.decode(input),
      patch: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PalletInfo obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.index);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.name);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.moduleName);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.major);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.minor);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.patch);
    return size;
  }
}
