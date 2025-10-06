// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum CollectionRole {
  issuer('Issuer', 1),
  freezer('Freezer', 2),
  admin('Admin', 4);

  const CollectionRole(
    this.variantName,
    this.codecIndex,
  );

  factory CollectionRole.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $CollectionRoleCodec codec = $CollectionRoleCodec();

  String toJson() => variantName;

  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $CollectionRoleCodec with _i1.Codec<CollectionRole> {
  const $CollectionRoleCodec();

  @override
  CollectionRole decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return CollectionRole.issuer;
      case 2:
        return CollectionRole.freezer;
      case 4:
        return CollectionRole.admin;
      default:
        throw Exception('CollectionRole: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    CollectionRole value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
