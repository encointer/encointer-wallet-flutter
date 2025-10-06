// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class Details {
  const Details({
    required this.asset,
    required this.fractions,
    required this.deposit,
    required this.assetCreator,
  });

  factory Details.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AssetId
  final int asset;

  /// Fractions
  final BigInt fractions;

  /// Deposit
  final BigInt deposit;

  /// AccountId
  final _i2.AccountId32 assetCreator;

  static const $DetailsCodec codec = $DetailsCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'asset': asset,
        'fractions': fractions,
        'deposit': deposit,
        'assetCreator': assetCreator.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Details &&
          other.asset == asset &&
          other.fractions == fractions &&
          other.deposit == deposit &&
          _i4.listsEqual(
            other.assetCreator,
            assetCreator,
          );

  @override
  int get hashCode => Object.hash(
        asset,
        fractions,
        deposit,
        assetCreator,
      );
}

class $DetailsCodec with _i1.Codec<Details> {
  const $DetailsCodec();

  @override
  void encodeTo(
    Details obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.asset,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.fractions,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.assetCreator,
      output,
    );
  }

  @override
  Details decode(_i1.Input input) {
    return Details(
      asset: _i1.U32Codec.codec.decode(input),
      fractions: _i1.U128Codec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      assetCreator: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(Details obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.asset);
    size = size + _i1.U128Codec.codec.sizeHint(obj.fractions);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.assetCreator);
    return size;
  }
}
