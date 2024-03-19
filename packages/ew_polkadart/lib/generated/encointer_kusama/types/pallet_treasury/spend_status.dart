// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../sp_core/crypto/account_id32.dart' as _i2;
import 'payment_state.dart' as _i3;

class SpendStatus {
  const SpendStatus({
    required this.assetKind,
    required this.amount,
    required this.beneficiary,
    required this.validFrom,
    required this.expireAt,
    required this.status,
  });

  factory SpendStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AssetKind
  final dynamic assetKind;

  /// AssetBalance
  final BigInt amount;

  /// Beneficiary
  final _i2.AccountId32 beneficiary;

  /// BlockNumber
  final int validFrom;

  /// BlockNumber
  final int expireAt;

  /// PaymentState<PaymentId>
  final _i3.PaymentState status;

  static const $SpendStatusCodec codec = $SpendStatusCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'assetKind': null,
        'amount': amount,
        'beneficiary': beneficiary.toList(),
        'validFrom': validFrom,
        'expireAt': expireAt,
        'status': status.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpendStatus &&
          other.assetKind == assetKind &&
          other.amount == amount &&
          _i5.listsEqual(
            other.beneficiary,
            beneficiary,
          ) &&
          other.validFrom == validFrom &&
          other.expireAt == expireAt &&
          other.status == status;

  @override
  int get hashCode => Object.hash(
        assetKind,
        amount,
        beneficiary,
        validFrom,
        expireAt,
        status,
      );
}

class $SpendStatusCodec with _i1.Codec<SpendStatus> {
  const $SpendStatusCodec();

  @override
  void encodeTo(
    SpendStatus obj,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      obj.assetKind,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.beneficiary,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validFrom,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.expireAt,
      output,
    );
    _i3.PaymentState.codec.encodeTo(
      obj.status,
      output,
    );
  }

  @override
  SpendStatus decode(_i1.Input input) {
    return SpendStatus(
      assetKind: _i1.NullCodec.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
      validFrom: _i1.U32Codec.codec.decode(input),
      expireAt: _i1.U32Codec.codec.decode(input),
      status: _i3.PaymentState.codec.decode(input),
    );
  }

  @override
  int sizeHint(SpendStatus obj) {
    int size = 0;
    size = size + _i1.NullCodec.codec.sizeHint(obj.assetKind);
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.beneficiary);
    size = size + _i1.U32Codec.codec.sizeHint(obj.validFrom);
    size = size + _i1.U32Codec.codec.sizeHint(obj.expireAt);
    size = size + _i3.PaymentState.codec.sizeHint(obj.status);
    return size;
  }
}
