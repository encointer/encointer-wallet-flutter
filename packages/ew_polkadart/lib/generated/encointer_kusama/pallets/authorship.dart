// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/sp_core/crypto/account_id32.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<_i3.AccountId32> _author = const _i2.StorageValue<_i3.AccountId32>(
    prefix: 'Authorship',
    storage: 'Author',
    valueCodec: _i3.AccountId32Codec(),
  );

  /// Author of current block.
  _i4.Future<_i3.AccountId32?> author({_i1.BlockHash? at}) async {
    final hashedKey = _author.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _author.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `author`.
  _i5.Uint8List authorKey() {
    final hashedKey = _author.hashedKey();
    return hashedKey;
  }
}
