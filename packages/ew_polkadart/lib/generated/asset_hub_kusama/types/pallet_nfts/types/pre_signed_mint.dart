// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../tuples.dart' as _i2;

class PreSignedMint {
  const PreSignedMint({
    required this.collection,
    required this.item,
    required this.attributes,
    required this.metadata,
    this.onlyAccount,
    required this.deadline,
    this.mintPrice,
  });

  factory PreSignedMint.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CollectionId
  final int collection;

  /// ItemId
  final int item;

  /// Vec<(Vec<u8>, Vec<u8>)>
  final List<_i2.Tuple2<List<int>, List<int>>> attributes;

  /// Vec<u8>
  final List<int> metadata;

  /// Option<AccountId>
  final _i3.AccountId32? onlyAccount;

  /// Deadline
  final int deadline;

  /// Option<Balance>
  final BigInt? mintPrice;

  static const $PreSignedMintCodec codec = $PreSignedMintCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'collection': collection,
        'item': item,
        'attributes': attributes
            .map((value) => [
                  value.value0,
                  value.value1,
                ])
            .toList(),
        'metadata': metadata,
        'onlyAccount': onlyAccount?.toList(),
        'deadline': deadline,
        'mintPrice': mintPrice,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PreSignedMint &&
          other.collection == collection &&
          other.item == item &&
          _i5.listsEqual(
            other.attributes,
            attributes,
          ) &&
          _i5.listsEqual(
            other.metadata,
            metadata,
          ) &&
          other.onlyAccount == onlyAccount &&
          other.deadline == deadline &&
          other.mintPrice == mintPrice;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        attributes,
        metadata,
        onlyAccount,
        deadline,
        mintPrice,
      );
}

class $PreSignedMintCodec with _i1.Codec<PreSignedMint> {
  const $PreSignedMintCodec();

  @override
  void encodeTo(
    PreSignedMint obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.item,
      output,
    );
    const _i1.SequenceCodec<_i2.Tuple2<List<int>, List<int>>>(_i2.Tuple2Codec<List<int>, List<int>>(
      _i1.U8SequenceCodec.codec,
      _i1.U8SequenceCodec.codec,
    )).encodeTo(
      obj.attributes,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.metadata,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      obj.onlyAccount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.deadline,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).encodeTo(
      obj.mintPrice,
      output,
    );
  }

  @override
  PreSignedMint decode(_i1.Input input) {
    return PreSignedMint(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      attributes: const _i1.SequenceCodec<_i2.Tuple2<List<int>, List<int>>>(_i2.Tuple2Codec<List<int>, List<int>>(
        _i1.U8SequenceCodec.codec,
        _i1.U8SequenceCodec.codec,
      )).decode(input),
      metadata: _i1.U8SequenceCodec.codec.decode(input),
      onlyAccount: const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).decode(input),
      deadline: _i1.U32Codec.codec.decode(input),
      mintPrice: const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(PreSignedMint obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.collection);
    size = size + _i1.U32Codec.codec.sizeHint(obj.item);
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<List<int>, List<int>>>(_i2.Tuple2Codec<List<int>, List<int>>(
          _i1.U8SequenceCodec.codec,
          _i1.U8SequenceCodec.codec,
        )).sizeHint(obj.attributes);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.metadata);
    size = size + const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).sizeHint(obj.onlyAccount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.deadline);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).sizeHint(obj.mintPrice);
    return size;
  }
}
