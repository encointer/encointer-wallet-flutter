// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef BTreeSet = List<List<int>>;

class BTreeSetCodec with _i1.Codec<BTreeSet> {
  const BTreeSetCodec();

  @override
  BTreeSet decode(_i1.Input input) {
    return const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).decode(input);
  }

  @override
  void encodeTo(
    BTreeSet value,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BTreeSet value) {
    return const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).sizeHint(value);
  }
}
