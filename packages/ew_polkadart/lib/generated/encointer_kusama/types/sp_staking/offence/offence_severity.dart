// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../../sp_arithmetic/per_things/perbill.dart' as _i1;

typedef OffenceSeverity = _i1.Perbill;

class OffenceSeverityCodec with _i2.Codec<OffenceSeverity> {
  const OffenceSeverityCodec();

  @override
  OffenceSeverity decode(_i2.Input input) {
    return _i2.U32Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    OffenceSeverity value,
    _i2.Output output,
  ) {
    _i2.U32Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(OffenceSeverity value) {
    return const _i1.PerbillCodec().sizeHint(value);
  }
}
