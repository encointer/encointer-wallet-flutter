// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'sp_core/crypto/account_id32.dart' as _i1;

typedef BTreeSet = List<_i1.AccountId32>;

class BTreeSetCodec with _i2.Codec<BTreeSet> {
  const BTreeSetCodec();

  @override
  BTreeSet decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.AccountId32>(_i1.AccountId32Codec()).decode(input);
  }

  @override
  void encodeTo(
    BTreeSet value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.AccountId32>(_i1.AccountId32Codec()).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BTreeSet value) {
    return const _i2.SequenceCodec<_i1.AccountId32>(_i1.AccountId32Codec()).sizeHint(value);
  }
}
