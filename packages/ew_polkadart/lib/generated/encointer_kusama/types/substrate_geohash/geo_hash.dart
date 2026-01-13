// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

typedef GeoHash = List<int>;

class GeoHashCodec with _i1.Codec<GeoHash> {
  const GeoHashCodec();

  @override
  GeoHash decode(_i1.Input input) {
    return const _i1.U8ArrayCodec(5).decode(input);
  }

  @override
  void encodeTo(
    GeoHash value,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(5).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(GeoHash value) {
    return const _i1.U8ArrayCodec(5).sizeHint(value);
  }

  @override
  bool isSizeZero() {
    return const _i1.U8ArrayCodec(5).isSizeZero();
  }
}
