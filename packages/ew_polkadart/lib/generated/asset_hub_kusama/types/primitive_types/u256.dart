// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef U256 = List<BigInt>;

class U256Codec with _i1.Codec<U256> {
  const U256Codec();

  @override
  U256 decode(_i1.Input input) {
    return const _i1.U64ArrayCodec(4).decode(input);
  }

  @override
  void encodeTo(
    U256 value,
    _i1.Output output,
  ) {
    const _i1.U64ArrayCodec(4).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(U256 value) {
    return const _i1.U64ArrayCodec(4).sizeHint(value);
  }
}
