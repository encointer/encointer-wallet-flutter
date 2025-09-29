// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef MaxAuthorizedAliases = dynamic;

class MaxAuthorizedAliasesCodec with _i1.Codec<MaxAuthorizedAliases> {
  const MaxAuthorizedAliasesCodec();

  @override
  MaxAuthorizedAliases decode(_i1.Input input) {
    return _i1.NullCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    MaxAuthorizedAliases value,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(MaxAuthorizedAliases value) {
    return _i1.NullCodec.codec.sizeHint(value);
  }
}
