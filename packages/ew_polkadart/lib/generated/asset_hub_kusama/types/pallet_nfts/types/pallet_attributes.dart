// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class PalletAttributes {
  const PalletAttributes();

  factory PalletAttributes.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $PalletAttributesCodec codec = $PalletAttributesCodec();

  static const $PalletAttributes values = $PalletAttributes();

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

class $PalletAttributes {
  const $PalletAttributes();

  UsedToClaim usedToClaim(int value0) {
    return UsedToClaim(value0);
  }

  TransferDisabled transferDisabled() {
    return TransferDisabled();
  }
}

class $PalletAttributesCodec with _i1.Codec<PalletAttributes> {
  const $PalletAttributesCodec();

  @override
  PalletAttributes decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return UsedToClaim._decode(input);
      case 1:
        return const TransferDisabled();
      default:
        throw Exception('PalletAttributes: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PalletAttributes value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case UsedToClaim:
        (value as UsedToClaim).encodeTo(output);
        break;
      case TransferDisabled:
        (value as TransferDisabled).encodeTo(output);
        break;
      default:
        throw Exception('PalletAttributes: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(PalletAttributes value) {
    switch (value.runtimeType) {
      case UsedToClaim:
        return (value as UsedToClaim)._sizeHint();
      case TransferDisabled:
        return 1;
      default:
        throw Exception('PalletAttributes: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class UsedToClaim extends PalletAttributes {
  const UsedToClaim(this.value0);

  factory UsedToClaim._decode(_i1.Input input) {
    return UsedToClaim(_i1.U32Codec.codec.decode(input));
  }

  /// CollectionId
  final int value0;

  @override
  Map<String, int> toJson() => {'UsedToClaim': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is UsedToClaim && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class TransferDisabled extends PalletAttributes {
  const TransferDisabled();

  @override
  Map<String, dynamic> toJson() => {'TransferDisabled': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is TransferDisabled;

  @override
  int get hashCode => runtimeType.hashCode;
}
