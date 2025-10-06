// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i3;

import 'sp_core/crypto/account_id32.dart' as _i2;
import 'tuples.dart' as _i1;

typedef BTreeMap = List<_i1.Tuple2<_i2.AccountId32, int?>>;

class BTreeMapCodec with _i3.Codec<BTreeMap> {
  const BTreeMapCodec();

  @override
  BTreeMap decode(_i3.Input input) {
    return const _i3.SequenceCodec<_i1.Tuple2<_i2.AccountId32, int?>>(_i1.Tuple2Codec<_i2.AccountId32, int?>(
      _i2.AccountId32Codec(),
      _i3.OptionCodec<int>(_i3.U32Codec.codec),
    )).decode(input);
  }

  @override
  void encodeTo(
    BTreeMap value,
    _i3.Output output,
  ) {
    const _i3.SequenceCodec<_i1.Tuple2<_i2.AccountId32, int?>>(_i1.Tuple2Codec<_i2.AccountId32, int?>(
      _i2.AccountId32Codec(),
      _i3.OptionCodec<int>(_i3.U32Codec.codec),
    )).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BTreeMap value) {
    return const _i3.SequenceCodec<_i1.Tuple2<_i2.AccountId32, int?>>(_i1.Tuple2Codec<_i2.AccountId32, int?>(
      _i2.AccountId32Codec(),
      _i3.OptionCodec<int>(_i3.U32Codec.codec),
    )).sizeHint(value);
  }
}
