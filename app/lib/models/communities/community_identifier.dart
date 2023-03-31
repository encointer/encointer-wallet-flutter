import 'dart:convert';

import 'package:base58check/base58.dart';
import 'package:base58check/base58check.dart';
import 'package:flutter/foundation.dart';

import 'package:encointer_wallet/extras/utils/format.dart';

/// CommunityIdentifier consisting of a geohash and a 4-bytes crc code.
class CommunityIdentifier {
  const CommunityIdentifier(this.geohash, this.digest);

  factory CommunityIdentifier.fromFmtString(String cid) {
    const codec = Base58Codec(Base58CheckCodec.BITCOIN_ALPHABET);

    return CommunityIdentifier(utf8.encode(cid.substring(0, 5)), codec.decode(cid.substring(5)));
  }

  // JS-passes these values as hex-strings, but this would be more complicated to handle in dart.
  factory CommunityIdentifier.fromJson(Map<String, dynamic> json) =>
      CommunityIdentifier(Fmt.hexToBytes(json['geohash'] as String), Fmt.hexToBytes(json['digest'] as String));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'geohash': Fmt.bytesToHex(geohash),
        'digest': Fmt.bytesToHex(digest),
      };

  // [u8; 5]
  final List<int> geohash;

  // [u8; 4]
  final List<int> digest;

  @override
  String toString() {
    return jsonEncode(this);
  }

  String toFmtString() {
    const codec = Base58Codec(Base58CheckCodec.BITCOIN_ALPHABET);

    return utf8.decode(geohash) + codec.encode(digest);
  }

  // By default, the dart `==` operator returns only true iff both variables point to the same instance. We want to
  // override this behaviour, such that it is also true if the instances contain the same values.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityIdentifier &&
          runtimeType == other.runtimeType &&
          listEquals(geohash, other.geohash) &&
          listEquals(digest, other.digest);

  @override
  int get hashCode => toFmtString().hashCode;
}
