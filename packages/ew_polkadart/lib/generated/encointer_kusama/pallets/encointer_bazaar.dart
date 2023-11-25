// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i7;

import '../types/encointer_primitives/bazaar/business_data.dart' as _i4;
import '../types/encointer_primitives/bazaar/business_identifier.dart' as _i5;
import '../types/encointer_primitives/bazaar/offering_data.dart' as _i6;
import '../types/encointer_primitives/communities/community_identifier.dart' as _i2;
import '../types/encointer_runtime/runtime_call.dart' as _i10;
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
}

class Txs {
  const Txs();

  /// See [`Pallet::create_business`].
  _i10.RuntimeCall createBusiness({
    required cid,
    required url,
  }) {
    final _call = _i11.Call.values.createBusiness(
      cid: cid,
      url: url,
    );
    return _i10.RuntimeCall.values.encointerBazaar(_call);
  }

  /// See [`Pallet::update_business`].
  _i10.RuntimeCall updateBusiness({
    required cid,
    required url,
  }) {
    final _call = _i11.Call.values.updateBusiness(
      cid: cid,
      url: url,
    );
    return _i10.RuntimeCall.values.encointerBazaar(_call);
  }

  /// See [`Pallet::delete_business`].
  _i10.RuntimeCall deleteBusiness({required cid}) {
    final _call = _i11.Call.values.deleteBusiness(cid: cid);
    return _i10.RuntimeCall.values.encointerBazaar(_call);
  }

  /// See [`Pallet::create_offering`].
  _i10.RuntimeCall createOffering({
    required cid,
    required url,
  }) {
    final _call = _i11.Call.values.createOffering(
      cid: cid,
      url: url,
    );
    return _i10.RuntimeCall.values.encointerBazaar(_call);
  }

  /// See [`Pallet::update_offering`].
  _i10.RuntimeCall updateOffering({
    required cid,
    required oid,
    required url,
  }) {
    final _call = _i11.Call.values.updateOffering(
      cid: cid,
      oid: oid,
      url: url,
    );
    return _i10.RuntimeCall.values.encointerBazaar(_call);
  }

  /// See [`Pallet::delete_offering`].
  _i10.RuntimeCall deleteOffering({
    required cid,
    required oid,
  }) {
    final _call = _i11.Call.values.deleteOffering(
      cid: cid,
      oid: oid,
    );
    return _i10.RuntimeCall.values.encointerBazaar(_call);
  }
}
