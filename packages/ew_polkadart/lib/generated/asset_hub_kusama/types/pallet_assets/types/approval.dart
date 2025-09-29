// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class Approval {
  const Approval({
    required this.amount,
    required this.deposit,
  });

  factory Approval.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt amount;

  /// DepositBalance
  final BigInt deposit;

  static const $ApprovalCodec codec = $ApprovalCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'amount': amount,
        'deposit': deposit,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Approval && other.amount == amount && other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        amount,
        deposit,
      );
}

class $ApprovalCodec with _i1.Codec<Approval> {
  const $ApprovalCodec();

  @override
  void encodeTo(
    Approval obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
  }

  @override
  Approval decode(_i1.Input input) {
    return Approval(
      amount: _i1.U128Codec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Approval obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    return size;
  }
}
