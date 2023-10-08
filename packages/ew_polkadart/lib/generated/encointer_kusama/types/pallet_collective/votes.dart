// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../sp_core/crypto/account_id32.dart' as _i2;
import 'dart:typed_data' as _i3;

class Votes {
  const Votes({
    required this.index,
    required this.threshold,
    required this.ayes,
    required this.nays,
    required this.end,
  });

  factory Votes.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final int index;

  final int threshold;

  final List<_i2.AccountId32> ayes;

  final List<_i2.AccountId32> nays;

  final int end;

  static const $VotesCodec codec = $VotesCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'threshold': threshold,
        'ayes': ayes.map((value) => value.toList()).toList(),
        'nays': nays.map((value) => value.toList()).toList(),
        'end': end,
      };
}

class $VotesCodec with _i1.Codec<Votes> {
  const $VotesCodec();

  @override
  void encodeTo(
    Votes obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.index,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.threshold,
      output,
    );
    const _i1.SequenceCodec<_i2.AccountId32>(_i1.U8ArrayCodec(32)).encodeTo(
      obj.ayes,
      output,
    );
    const _i1.SequenceCodec<_i2.AccountId32>(_i1.U8ArrayCodec(32)).encodeTo(
      obj.nays,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.end,
      output,
    );
  }

  @override
  Votes decode(_i1.Input input) {
    return Votes(
      index: _i1.U32Codec.codec.decode(input),
      threshold: _i1.U32Codec.codec.decode(input),
      ayes: const _i1.SequenceCodec<_i2.AccountId32>(_i1.U8ArrayCodec(32))
          .decode(input),
      nays: const _i1.SequenceCodec<_i2.AccountId32>(_i1.U8ArrayCodec(32))
          .decode(input),
      end: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Votes obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.index);
    size = size + _i1.U32Codec.codec.sizeHint(obj.threshold);
    size = size +
        const _i1.SequenceCodec<_i2.AccountId32>(_i1.U8ArrayCodec(32))
            .sizeHint(obj.ayes);
    size = size +
        const _i1.SequenceCodec<_i2.AccountId32>(_i1.U8ArrayCodec(32))
            .sizeHint(obj.nays);
    size = size + _i1.U32Codec.codec.sizeHint(obj.end);
    return size;
  }
}
