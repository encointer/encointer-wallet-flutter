// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../communities/community_identifier.dart' as _i2;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import 'dart:typed_data' as _i4;

class BusinessIdentifier {
  const BusinessIdentifier({
    required this.communityIdentifier,
    required this.controller,
  });

  factory BusinessIdentifier.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final _i2.CommunityIdentifier communityIdentifier;

  final _i3.AccountId32 controller;

  static const $BusinessIdentifierCodec codec = $BusinessIdentifierCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'communityIdentifier': communityIdentifier.toJson(),
        'controller': controller.toList(),
      };
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
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.controller);
    return size;
  }
}
