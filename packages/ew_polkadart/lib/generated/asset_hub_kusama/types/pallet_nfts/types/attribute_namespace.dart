// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

abstract class AttributeNamespace {
  const AttributeNamespace();

  factory AttributeNamespace.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AttributeNamespaceCodec codec = $AttributeNamespaceCodec();

  static const $AttributeNamespace values = $AttributeNamespace();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $AttributeNamespace {
  const $AttributeNamespace();

  Pallet pallet() {
    return Pallet();
  }

  CollectionOwner collectionOwner() {
    return CollectionOwner();
  }

  ItemOwner itemOwner() {
    return ItemOwner();
  }

  Account account(_i3.AccountId32 value0) {
    return Account(value0);
  }
}

class $AttributeNamespaceCodec with _i1.Codec<AttributeNamespace> {
  const $AttributeNamespaceCodec();

  @override
  AttributeNamespace decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Pallet();
      case 1:
        return const CollectionOwner();
      case 2:
        return const ItemOwner();
      case 3:
        return Account._decode(input);
      default:
        throw Exception('AttributeNamespace: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AttributeNamespace value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Pallet:
        (value as Pallet).encodeTo(output);
        break;
      case CollectionOwner:
        (value as CollectionOwner).encodeTo(output);
        break;
      case ItemOwner:
        (value as ItemOwner).encodeTo(output);
        break;
      case Account:
        (value as Account).encodeTo(output);
        break;
      default:
        throw Exception('AttributeNamespace: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AttributeNamespace value) {
    switch (value.runtimeType) {
      case Pallet:
        return 1;
      case CollectionOwner:
        return 1;
      case ItemOwner:
        return 1;
      case Account:
        return (value as Account)._sizeHint();
      default:
        throw Exception('AttributeNamespace: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Pallet extends AttributeNamespace {
  const Pallet();

  @override
  Map<String, dynamic> toJson() => {'Pallet': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Pallet;

  @override
  int get hashCode => runtimeType.hashCode;
}

class CollectionOwner extends AttributeNamespace {
  const CollectionOwner();

  @override
  Map<String, dynamic> toJson() => {'CollectionOwner': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CollectionOwner;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ItemOwner extends AttributeNamespace {
  const ItemOwner();

  @override
  Map<String, dynamic> toJson() => {'ItemOwner': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ItemOwner;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Account extends AttributeNamespace {
  const Account(this.value0);

  factory Account._decode(_i1.Input input) {
    return Account(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// AccountId
  final _i3.AccountId32 value0;

  @override
  Map<String, List<int>> toJson() => {'Account': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Account &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
