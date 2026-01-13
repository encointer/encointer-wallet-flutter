// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i8;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i11;
import '../types/encointer_primitives/bazaar/business_data.dart' as _i5;
import '../types/encointer_primitives/bazaar/business_identifier.dart' as _i6;
import '../types/encointer_primitives/bazaar/offering_data.dart' as _i7;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i3;
import '../types/pallet_encointer_bazaar/pallet/call.dart' as _i12;
import '../types/sp_core/crypto/account_id32.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, _i5.BusinessData> _businessRegistry =
      const _i2.StorageDoubleMap<_i3.CommunityIdentifier, _i4.AccountId32, _i5.BusinessData>(
    prefix: 'EncointerBazaar',
    storage: 'BusinessRegistry',
    valueCodec: _i5.BusinessData.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i3.CommunityIdentifier.codec),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i2.StorageDoubleMap<_i6.BusinessIdentifier, int, _i7.OfferingData> _offeringRegistry =
      const _i2.StorageDoubleMap<_i6.BusinessIdentifier, int, _i7.OfferingData>(
    prefix: 'EncointerBazaar',
    storage: 'OfferingRegistry',
    valueCodec: _i7.OfferingData.codec,
    hasher1: _i2.StorageHasher.blake2b128Concat(_i6.BusinessIdentifier.codec),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i8.U32Codec.codec),
  );

  _i9.Future<_i5.BusinessData> businessRegistry(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2, {
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
    return _i5.BusinessData(
      url: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      lastOid: 0,
    ); /* Default */
  }

  _i9.Future<_i7.OfferingData> offeringRegistry(
    _i6.BusinessIdentifier key1,
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
    return _i7.OfferingData(
        url: List<int>.filled(
      0,
      0,
      growable: true,
    )); /* Default */
  }

  /// Returns the storage key for `businessRegistry`.
  _i10.Uint8List businessRegistryKey(
    _i3.CommunityIdentifier key1,
    _i4.AccountId32 key2,
  ) {
    final hashedKey = _businessRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `offeringRegistry`.
  _i10.Uint8List offeringRegistryKey(
    _i6.BusinessIdentifier key1,
    int key2,
  ) {
    final hashedKey = _offeringRegistry.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `businessRegistry`.
  _i10.Uint8List businessRegistryMapPrefix(_i3.CommunityIdentifier key1) {
    final hashedKey = _businessRegistry.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `offeringRegistry`.
  _i10.Uint8List offeringRegistryMapPrefix(_i6.BusinessIdentifier key1) {
    final hashedKey = _offeringRegistry.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i11.EncointerBazaar createBusiness({
    required _i3.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return _i11.EncointerBazaar(_i12.CreateBusiness(
      cid: cid,
      url: url,
    ));
  }

  _i11.EncointerBazaar updateBusiness({
    required _i3.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return _i11.EncointerBazaar(_i12.UpdateBusiness(
      cid: cid,
      url: url,
    ));
  }

  _i11.EncointerBazaar deleteBusiness({required _i3.CommunityIdentifier cid}) {
    return _i11.EncointerBazaar(_i12.DeleteBusiness(cid: cid));
  }

  _i11.EncointerBazaar createOffering({
    required _i3.CommunityIdentifier cid,
    required List<int> url,
  }) {
    return _i11.EncointerBazaar(_i12.CreateOffering(
      cid: cid,
      url: url,
    ));
  }

  _i11.EncointerBazaar updateOffering({
    required _i3.CommunityIdentifier cid,
    required int oid,
    required List<int> url,
  }) {
    return _i11.EncointerBazaar(_i12.UpdateOffering(
      cid: cid,
      oid: oid,
      url: url,
    ));
  }

  _i11.EncointerBazaar deleteOffering({
    required _i3.CommunityIdentifier cid,
    required int oid,
  }) {
    return _i11.EncointerBazaar(_i12.DeleteOffering(
      cid: cid,
      oid: oid,
    ));
  }
}
