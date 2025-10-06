// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class CollectionDetails {
  const CollectionDetails({
    required this.owner,
    required this.issuer,
    required this.admin,
    required this.freezer,
    required this.totalDeposit,
    required this.freeHolding,
    required this.items,
    required this.itemMetadatas,
    required this.attributes,
    required this.isFrozen,
  });

  factory CollectionDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 owner;

  /// AccountId
  final _i2.AccountId32 issuer;

  /// AccountId
  final _i2.AccountId32 admin;

  /// AccountId
  final _i2.AccountId32 freezer;

  /// DepositBalance
  final BigInt totalDeposit;

  /// bool
  final bool freeHolding;

  /// u32
  final int items;

  /// u32
  final int itemMetadatas;

  /// u32
  final int attributes;

  /// bool
  final bool isFrozen;

  static const $CollectionDetailsCodec codec = $CollectionDetailsCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'owner': owner.toList(),
        'issuer': issuer.toList(),
        'admin': admin.toList(),
        'freezer': freezer.toList(),
        'totalDeposit': totalDeposit,
        'freeHolding': freeHolding,
        'items': items,
        'itemMetadatas': itemMetadatas,
        'attributes': attributes,
        'isFrozen': isFrozen,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CollectionDetails &&
          _i4.listsEqual(
            other.owner,
            owner,
          ) &&
          _i4.listsEqual(
            other.issuer,
            issuer,
          ) &&
          _i4.listsEqual(
            other.admin,
            admin,
          ) &&
          _i4.listsEqual(
            other.freezer,
            freezer,
          ) &&
          other.totalDeposit == totalDeposit &&
          other.freeHolding == freeHolding &&
          other.items == items &&
          other.itemMetadatas == itemMetadatas &&
          other.attributes == attributes &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        owner,
        issuer,
        admin,
        freezer,
        totalDeposit,
        freeHolding,
        items,
        itemMetadatas,
        attributes,
        isFrozen,
      );
}

class $CollectionDetailsCodec with _i1.Codec<CollectionDetails> {
  const $CollectionDetailsCodec();

  @override
  void encodeTo(
    CollectionDetails obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.issuer,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.admin,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.freezer,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.totalDeposit,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.freeHolding,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.items,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.itemMetadatas,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.attributes,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.isFrozen,
      output,
    );
  }

  @override
  CollectionDetails decode(_i1.Input input) {
    return CollectionDetails(
      owner: const _i1.U8ArrayCodec(32).decode(input),
      issuer: const _i1.U8ArrayCodec(32).decode(input),
      admin: const _i1.U8ArrayCodec(32).decode(input),
      freezer: const _i1.U8ArrayCodec(32).decode(input),
      totalDeposit: _i1.U128Codec.codec.decode(input),
      freeHolding: _i1.BoolCodec.codec.decode(input),
      items: _i1.U32Codec.codec.decode(input),
      itemMetadatas: _i1.U32Codec.codec.decode(input),
      attributes: _i1.U32Codec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CollectionDetails obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.owner);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.issuer);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.admin);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.freezer);
    size = size + _i1.U128Codec.codec.sizeHint(obj.totalDeposit);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.freeHolding);
    size = size + _i1.U32Codec.codec.sizeHint(obj.items);
    size = size + _i1.U32Codec.codec.sizeHint(obj.itemMetadatas);
    size = size + _i1.U32Codec.codec.sizeHint(obj.attributes);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.isFrozen);
    return size;
  }
}
