// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i7;

import '../types/encointer_primitives/bazaar/business_data.dart' as _i4;
import '../types/encointer_primitives/bazaar/business_identifier.dart' as _i5;
import '../types/encointer_primitives/bazaar/offering_data.dart' as _i6;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i2;
import '../types/sp_core/crypto/account_id32.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i3.AccountId32, _i4.BusinessData> _businessRegistry =
      const _i1.StorageDoubleMap<_i2.CommunityIdentifier, _i3.AccountId32, _i4.BusinessData>(
    prefix: 'EncointerBazaar',
    storage: 'BusinessRegistry',
    valueCodec: _i4.BusinessData.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i2.CommunityIdentifier.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageDoubleMap<_i5.BusinessIdentifier, int, _i6.OfferingData> _offeringRegistry =
      const _i1.StorageDoubleMap<_i5.BusinessIdentifier, int, _i6.OfferingData>(
    prefix: 'EncointerBazaar',
    storage: 'OfferingRegistry',
    valueCodec: _i6.OfferingData.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i5.BusinessIdentifier.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i7.U32Codec.codec),
  );

  _i8.Future<_i4.BusinessData> businessRegistry(
    _i2.CommunityIdentifier key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _businessRegistry.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _businessRegistry.decodeValue(bytes);
    }
    return _i4.BusinessData(
      url: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      lastOid: 0,
    ); /* Default */
  }

  _i8.Future<_i6.OfferingData> offeringRegistry(
    _i5.BusinessIdentifier key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _offeringRegistry.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _offeringRegistry.decodeValue(bytes);
    }
    return _i6.OfferingData(
        url: List<int>.filled(
      0,
      0,
      growable: true,
    )); /* Default */
  }
}
