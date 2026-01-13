// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

class Tally {
  const Tally({
    required this.turnout,
    required this.ayes,
  });

  factory Tally.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// VoteCountType
  final BigInt turnout;

  /// VoteCountType
  final BigInt ayes;

  static const $TallyCodec codec = $TallyCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'turnout': turnout,
        'ayes': ayes,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Tally && other.turnout == turnout && other.ayes == ayes;

  @override
  int get hashCode => Object.hash(
        turnout,
        ayes,
      );
}

class $TallyCodec with _i1.Codec<Tally> {
  const $TallyCodec();

  @override
  void encodeTo(
    Tally obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.turnout,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.ayes,
      output,
    );
  }

  @override
  Tally decode(_i1.Input input) {
    return Tally(
      turnout: _i1.U128Codec.codec.decode(input),
      ayes: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Tally obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.turnout);
    size = size + _i1.U128Codec.codec.sizeHint(obj.ayes);
    return size;
  }

  @override
  bool isSizeZero() => _i1.U128Codec.codec.isSizeZero() && _i1.U128Codec.codec.isSizeZero();
}
