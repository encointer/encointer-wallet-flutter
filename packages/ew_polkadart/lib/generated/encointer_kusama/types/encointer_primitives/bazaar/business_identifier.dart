// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../communities/community_identifier.dart' as _i2;

class BusinessIdentifier {
  const BusinessIdentifier({
    required this.communityIdentifier,
    required this.controller,
  });

  factory BusinessIdentifier.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CommunityIdentifier
  final _i2.CommunityIdentifier communityIdentifier;

  /// AccountId
  final _i3.AccountId32 controller;

  static const $BusinessIdentifierCodec codec = $BusinessIdentifierCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'communityIdentifier': communityIdentifier.toJson(),
        'controller': controller.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BusinessIdentifier &&
          other.communityIdentifier == communityIdentifier &&
          _i5.listsEqual(
            other.controller,
            controller,
          );

  @override
  int get hashCode => Object.hash(
        communityIdentifier,
        controller,
      );
}

class $BusinessIdentifierCodec with _i1.Codec<BusinessIdentifier> {
  const $BusinessIdentifierCodec();

  @override
  void encodeTo(
    BusinessIdentifier obj,
    _i1.Output output,
  ) {
    _i2.CommunityIdentifier.codec.encodeTo(
      obj.communityIdentifier,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.controller,
      output,
    );
  }

  @override
  BusinessIdentifier decode(_i1.Input input) {
    return BusinessIdentifier(
      communityIdentifier: _i2.CommunityIdentifier.codec.decode(input),
      controller: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(BusinessIdentifier obj) {
    int size = 0;
    size =
        size + _i2.CommunityIdentifier.codec.sizeHint(obj.communityIdentifier);
    size = size + const _i3.AccountId32Codec().sizeHint(obj.controller);
    return size;
  }
}
