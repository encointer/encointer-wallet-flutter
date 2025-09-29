// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class CandidateInfo {
  const CandidateInfo({
    required this.who,
    required this.deposit,
  });

  factory CandidateInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 who;

  /// Balance
  final BigInt deposit;

  static const $CandidateInfoCodec codec = $CandidateInfoCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'who': who.toList(),
        'deposit': deposit,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateInfo &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        who,
        deposit,
      );
}

class $CandidateInfoCodec with _i1.Codec<CandidateInfo> {
  const $CandidateInfoCodec();

  @override
  void encodeTo(
    CandidateInfo obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
  }

  @override
  CandidateInfo decode(_i1.Input input) {
    return CandidateInfo(
      who: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CandidateInfo obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.who);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    return size;
  }
}
