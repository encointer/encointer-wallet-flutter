// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i7;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i10;
import '../types/encointer_primitives/bazaar/business_data.dart' as _i4;
import '../types/encointer_primitives/bazaar/business_identifier.dart' as _i5;
import '../types/encointer_primitives/bazaar/offering_data.dart' as _i6;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i2;
import '../types/pallet_encointer_bazaar/pallet/call.dart' as _i11;
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

  /// Returns the storage key for `businessRegistry`.
  _i9.Uint8List businessRegistryKey(
    _i2.CommunityIdentifier key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _businessRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `offeringRegistry`.
  _i9.Uint8List offeringRegistryKey(
    _i5.BusinessIdentifier key1,
    int key2,
  ) {
    final hashedKey = _offeringRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `businessRegistry`.
  _i9.Uint8List businessRegistryMapPrefix(_i2.CommunityIdentifier key1) {
    final hashedKey = _businessRegistry.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `offeringRegistry`.
  _i9.Uint8List offeringRegistryMapPrefix(_i5.BusinessIdentifier key1) {
    final hashedKey = _offeringRegistry.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i10.EncointerBazaar createBusiness({
    required _i2.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return _i10.EncointerBazaar(_i11.CreateBusiness(
      cid: cid,
      url: url,
    ));
  }

  _i10.EncointerBazaar updateBusiness({
    required _i2.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return _i10.EncointerBazaar(_i11.UpdateBusiness(
      cid: cid,
      url: url,
    ));
  }

  _i10.EncointerBazaar deleteBusiness({required _i2.CommunityIdentifier cid}) {
    return _i10.EncointerBazaar(_i11.DeleteBusiness(cid: cid));
  }

  _i10.EncointerBazaar createOffering({
    required _i2.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return _i10.EncointerBazaar(_i11.CreateOffering(
      cid: cid,
      url: url,
    ));
  }

  _i10.EncointerBazaar updateOffering({
    required _i2.CommunityIdentifier cid,
    required int oid,
    required List<int> url,
  }) {
    return _i10.EncointerBazaar(_i11.UpdateOffering(
      cid: cid,
      oid: oid,
      url: url,
    ));
  }

  _i10.EncointerBazaar deleteOffering({
    required _i2.CommunityIdentifier cid,
    required int oid,
  }) {
    return _i10.EncointerBazaar(_i11.DeleteOffering(
      cid: cid,
      oid: oid,
    ));
  }
}
