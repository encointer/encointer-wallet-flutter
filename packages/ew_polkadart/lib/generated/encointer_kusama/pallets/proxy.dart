// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/polkadart.dart' as _i1;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/tuples.dart' as _i3;
import '../types/pallet_proxy/proxy_definition.dart' as _i4;
import 'package:polkadart/scale_codec.dart' as _i5;
import '../types/pallet_proxy/announcement.dart' as _i6;
import 'dart:async' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32, _i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>> _proxies =
      const _i1.StorageMap<_i2.AccountId32, _i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>>(
    prefix: 'Proxy',
    storage: 'Proxies',
    valueCodec: _i3.Tuple2Codec<List<_i4.ProxyDefinition>, BigInt>(
      _i5.SequenceCodec<_i4.ProxyDefinition>(_i4.ProxyDefinition.codec),
      _i5.U128Codec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.U8ArrayCodec(32)),
  );

  final _i1.StorageMap<_i2.AccountId32, _i3.Tuple2<List<_i6.Announcement>, BigInt>> _announcements =
      const _i1.StorageMap<_i2.AccountId32, _i3.Tuple2<List<_i6.Announcement>, BigInt>>(
    prefix: 'Proxy',
    storage: 'Announcements',
    valueCodec: _i3.Tuple2Codec<List<_i6.Announcement>, BigInt>(
      _i5.SequenceCodec<_i6.Announcement>(_i6.Announcement.codec),
      _i5.U128Codec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.U8ArrayCodec(32)),
  );

  /// The set of account proxies. Maps the account which has delegated to the accounts
  /// which are being delegated to, together with the amount held on deposit.
  _i7.Future<_i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>> proxies(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _proxies.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proxies.decodeValue(bytes);
    }
    return _i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>(
      const [],
      BigInt.zero,
    ); /* Default */
  }

  /// The announcements made by the proxy (key).
  _i7.Future<_i3.Tuple2<List<_i6.Announcement>, BigInt>> announcements(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _announcements.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _announcements.decodeValue(bytes);
    }
    return _i3.Tuple2<List<_i6.Announcement>, BigInt>(
      const [],
      BigInt.zero,
    ); /* Default */
  }
}

class Constants {
  Constants();

  /// The base amount of currency needed to reserve for creating a proxy.
  ///
  /// This is held for an additional storage item whose value size is
  /// `sizeof(Balance)` bytes and whose key size is `sizeof(AccountId)` bytes.
  final BigInt proxyDepositBase = BigInt.from(32);

  /// The amount of currency needed per proxy added.
  ///
  /// This is held for adding 32 bytes plus an instance of `ProxyType` more into a
  /// pre-existing storage value. Thus, when configuring `ProxyDepositFactor` one should take
  /// into account `32 + proxy_type.encode().len()` bytes of data.
  final BigInt proxyDepositFactor = BigInt.from(32);

  /// The maximum amount of proxies allowed for a single account.
  final int maxProxies = 32;

  /// The maximum amount of time-delayed announcements that are allowed to be pending.
  final int maxPending = 32;

  /// The base amount of currency needed to reserve for creating an announcement.
  ///
  /// This is held when a new storage item holding a `Balance` is created (typically 16
  /// bytes).
  final BigInt announcementDepositBase = BigInt.from(32);

  /// The amount of currency needed per announcement made.
  ///
  /// This is held for adding an `AccountId`, `Hash` and `BlockNumber` (typically 68 bytes)
  /// into a pre-existing storage value.
  final BigInt announcementDepositFactor = BigInt.from(32);
}
