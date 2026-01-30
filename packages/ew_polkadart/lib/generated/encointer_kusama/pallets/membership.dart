// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i6;
import '../types/pallet_membership/pallet/call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.AccountId32>> _members = const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'Membership',
    storage: 'Members',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<_i2.AccountId32> _prime = const _i1.StorageValue<_i2.AccountId32>(
    prefix: 'Membership',
    storage: 'Prime',
    valueCodec: _i2.AccountId32Codec(),
  );

  /// The current membership, stored as an ordered Vec.
  _i4.Future<List<_i2.AccountId32>> members({_i1.BlockHash? at}) async {
    final hashedKey = _members.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _members.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current prime member, if one exists.
  _i4.Future<_i2.AccountId32?> prime({_i1.BlockHash? at}) async {
    final hashedKey = _prime.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _prime.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `members`.
  _i5.Uint8List membersKey() {
    final hashedKey = _members.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `prime`.
  _i5.Uint8List primeKey() {
    final hashedKey = _prime.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Add a member `who` to the set.
  ///
  /// May only be called from `T::AddOrigin`.
  _i6.Membership addMember({required _i7.MultiAddress who}) {
    return _i6.Membership(_i8.AddMember(who: who));
  }

  /// Remove a member `who` from the set.
  ///
  /// May only be called from `T::RemoveOrigin`.
  _i6.Membership removeMember({required _i7.MultiAddress who}) {
    return _i6.Membership(_i8.RemoveMember(who: who));
  }

  /// Swap out one member `remove` for another `add`.
  ///
  /// May only be called from `T::SwapOrigin`.
  ///
  /// Prime membership is *not* passed from `remove` to `add`, if extant.
  _i6.Membership swapMember({
    required _i7.MultiAddress remove,
    required _i7.MultiAddress add,
  }) {
    return _i6.Membership(_i8.SwapMember(
      remove: remove,
      add: add,
    ));
  }

  /// Change the membership to a new set, disregarding the existing membership. Be nice and
  /// pass `members` pre-sorted.
  ///
  /// May only be called from `T::ResetOrigin`.
  _i6.Membership resetMembers({required List<_i2.AccountId32> members}) {
    return _i6.Membership(_i8.ResetMembers(members: members));
  }

  /// Swap out the sending member for some other key `new`.
  ///
  /// May only be called from `Signed` origin of a current member.
  ///
  /// Prime membership is passed from the origin account to `new`, if extant.
  _i6.Membership changeKey({required _i7.MultiAddress new_}) {
    return _i6.Membership(_i8.ChangeKey(new_: new_));
  }

  /// Set the prime member. Must be a current member.
  ///
  /// May only be called from `T::PrimeOrigin`.
  _i6.Membership setPrime({required _i7.MultiAddress who}) {
    return _i6.Membership(_i8.SetPrime(who: who));
  }

  /// Remove the prime member if it exists.
  ///
  /// May only be called from `T::PrimeOrigin`.
  _i6.Membership clearPrime() {
    return _i6.Membership(_i8.ClearPrime());
  }
}
