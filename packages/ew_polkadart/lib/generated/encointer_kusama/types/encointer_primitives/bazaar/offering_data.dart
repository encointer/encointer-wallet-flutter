// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;

class OfferingData {
  const OfferingData({required this.url});

  factory OfferingData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final List<int> url;

  static const $OfferingDataCodec codec = $OfferingDataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<int>> toJson() => {'url': url};
}

class $OfferingDataCodec with _i1.Codec<OfferingData> {
  const $OfferingDataCodec();

  @override
  void encodeTo(
    OfferingData obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.url,
      output,
    );
  }

  @override
  OfferingData decode(_i1.Input input) {
    return OfferingData(url: _i1.U8SequenceCodec.codec.decode(input));
  }

  @override
  int sizeHint(OfferingData obj) {
    int size = 0;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.url);
    return size;
  }
}
