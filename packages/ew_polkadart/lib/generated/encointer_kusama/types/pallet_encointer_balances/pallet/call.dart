// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../encointer_primitives/communities/community_identifier.dart'
    as _i4;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../substrate_fixed/fixed_u128.dart' as _i5;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  Transfer transfer({
    required _i3.AccountId32 dest,
    required _i4.CommunityIdentifier communityId,
    required _i5.FixedU128 amount,
  }) {
    return Transfer(
      dest: dest,
      communityId: communityId,
      amount: amount,
    );
  }

  SetFeeConversionFactor setFeeConversionFactor(
      {required BigInt feeConversionFactor}) {
    return SetFeeConversionFactor(feeConversionFactor: feeConversionFactor);
  }

  TransferAll transferAll({
    required _i3.AccountId32 dest,
    required _i4.CommunityIdentifier cid,
  }) {
    return TransferAll(
      dest: dest,
      cid: cid,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Transfer._decode(input);
      case 1:
        return SetFeeConversionFactor._decode(input);
      case 2:
        return TransferAll._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Transfer:
        (value as Transfer).encodeTo(output);
        break;
      case SetFeeConversionFactor:
        (value as SetFeeConversionFactor).encodeTo(output);
        break;
      case TransferAll:
        (value as TransferAll).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Transfer:
        return (value as Transfer)._sizeHint();
      case SetFeeConversionFactor:
        return (value as SetFeeConversionFactor)._sizeHint();
      case TransferAll:
        return (value as TransferAll)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// See [`Pallet::transfer`].
class Transfer extends Call {
  const Transfer({
    required this.dest,
    required this.communityId,
    required this.amount,
  });

  factory Transfer._decode(_i1.Input input) {
    return Transfer(
      dest: const _i1.U8ArrayCodec(32).decode(input),
      communityId: _i4.CommunityIdentifier.codec.decode(input),
      amount: _i5.FixedU128.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 dest;

  /// CommunityIdentifier
  final _i4.CommunityIdentifier communityId;

  /// BalanceType
  final _i5.FixedU128 amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer': {
          'dest': dest.toList(),
          'communityId': communityId.toJson(),
          'amount': amount.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(dest);
    size = size + _i4.CommunityIdentifier.codec.sizeHint(communityId);
    size = size + _i5.FixedU128.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      dest,
      output,
    );
    _i4.CommunityIdentifier.codec.encodeTo(
      communityId,
      output,
    );
    _i5.FixedU128.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transfer &&
          _i6.listsEqual(
            other.dest,
            dest,
          ) &&
          other.communityId == communityId &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        dest,
        communityId,
        amount,
      );
}

/// See [`Pallet::set_fee_conversion_factor`].
class SetFeeConversionFactor extends Call {
  const SetFeeConversionFactor({required this.feeConversionFactor});

  factory SetFeeConversionFactor._decode(_i1.Input input) {
    return SetFeeConversionFactor(
        feeConversionFactor: _i1.U128Codec.codec.decode(input));
  }

  /// FeeConversionFactorType
  final BigInt feeConversionFactor;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_fee_conversion_factor': {
          'feeConversionFactor': feeConversionFactor
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(feeConversionFactor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      feeConversionFactor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetFeeConversionFactor &&
          other.feeConversionFactor == feeConversionFactor;

  @override
  int get hashCode => feeConversionFactor.hashCode;
}

/// See [`Pallet::transfer_all`].
class TransferAll extends Call {
  const TransferAll({
    required this.dest,
    required this.cid,
  });

  factory TransferAll._decode(_i1.Input input) {
    return TransferAll(
      dest: const _i1.U8ArrayCodec(32).decode(input),
      cid: _i4.CommunityIdentifier.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 dest;

  /// CommunityIdentifier
  final _i4.CommunityIdentifier cid;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer_all': {
          'dest': dest.toList(),
          'cid': cid.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(dest);
    size = size + _i4.CommunityIdentifier.codec.sizeHint(cid);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      dest,
      output,
    );
    _i4.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferAll &&
          _i6.listsEqual(
            other.dest,
            dest,
          ) &&
          other.cid == cid;

  @override
  int get hashCode => Object.hash(
        dest,
        cid,
      );
}
