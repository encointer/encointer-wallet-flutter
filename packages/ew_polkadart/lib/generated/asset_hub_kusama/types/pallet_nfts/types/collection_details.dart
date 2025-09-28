// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class CollectionDetails {
  const CollectionDetails({
    required this.owner,
    required this.ownerDeposit,
    required this.items,
    required this.itemMetadatas,
    required this.itemConfigs,
    required this.attributes,
  });

  factory CollectionDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 owner;

  /// DepositBalance
  final BigInt ownerDeposit;

  /// u32
  final int items;

  /// u32
  final int itemMetadatas;

  /// u32
  final int itemConfigs;

  /// u32
  final int attributes;

  static const $CollectionDetailsCodec codec = $CollectionDetailsCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'owner': owner.toList(),
        'ownerDeposit': ownerDeposit,
        'items': items,
        'itemMetadatas': itemMetadatas,
        'itemConfigs': itemConfigs,
        'attributes': attributes,
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
          other.ownerDeposit == ownerDeposit &&
          other.items == items &&
          other.itemMetadatas == itemMetadatas &&
          other.itemConfigs == itemConfigs &&
          other.attributes == attributes;

  @override
  int get hashCode => Object.hash(
        owner,
        ownerDeposit,
        items,
        itemMetadatas,
        itemConfigs,
        attributes,
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
    _i1.U128Codec.codec.encodeTo(
      obj.ownerDeposit,
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
      obj.itemConfigs,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.attributes,
      output,
    );
  }

  @override
  CollectionDetails decode(_i1.Input input) {
    return CollectionDetails(
      owner: const _i1.U8ArrayCodec(32).decode(input),
      ownerDeposit: _i1.U128Codec.codec.decode(input),
      items: _i1.U32Codec.codec.decode(input),
      itemMetadatas: _i1.U32Codec.codec.decode(input),
      itemConfigs: _i1.U32Codec.codec.decode(input),
      attributes: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CollectionDetails obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.owner);
    size = size + _i1.U128Codec.codec.sizeHint(obj.ownerDeposit);
    size = size + _i1.U32Codec.codec.sizeHint(obj.items);
    size = size + _i1.U32Codec.codec.sizeHint(obj.itemMetadatas);
    size = size + _i1.U32Codec.codec.sizeHint(obj.itemConfigs);
    size = size + _i1.U32Codec.codec.sizeHint(obj.attributes);
    return size;
  }
}
