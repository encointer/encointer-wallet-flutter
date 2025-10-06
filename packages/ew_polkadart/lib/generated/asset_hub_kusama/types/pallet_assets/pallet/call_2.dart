// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i4;
import '../../staging_xcm/v5/location/location.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  Create create({
    required _i3.Location id,
    required _i4.MultiAddress admin,
    required BigInt minBalance,
  }) {
    return Create(
      id: id,
      admin: admin,
      minBalance: minBalance,
    );
  }

  ForceCreate forceCreate({
    required _i3.Location id,
    required _i4.MultiAddress owner,
    required bool isSufficient,
    required BigInt minBalance,
  }) {
    return ForceCreate(
      id: id,
      owner: owner,
      isSufficient: isSufficient,
      minBalance: minBalance,
    );
  }

  StartDestroy startDestroy({required _i3.Location id}) {
    return StartDestroy(id: id);
  }

  DestroyAccounts destroyAccounts({required _i3.Location id}) {
    return DestroyAccounts(id: id);
  }

  DestroyApprovals destroyApprovals({required _i3.Location id}) {
    return DestroyApprovals(id: id);
  }

  FinishDestroy finishDestroy({required _i3.Location id}) {
    return FinishDestroy(id: id);
  }

  Mint mint({
    required _i3.Location id,
    required _i4.MultiAddress beneficiary,
    required BigInt amount,
  }) {
    return Mint(
      id: id,
      beneficiary: beneficiary,
      amount: amount,
    );
  }

  Burn burn({
    required _i3.Location id,
    required _i4.MultiAddress who,
    required BigInt amount,
  }) {
    return Burn(
      id: id,
      who: who,
      amount: amount,
    );
  }

  Transfer transfer({
    required _i3.Location id,
    required _i4.MultiAddress target,
    required BigInt amount,
  }) {
    return Transfer(
      id: id,
      target: target,
      amount: amount,
    );
  }

  TransferKeepAlive transferKeepAlive({
    required _i3.Location id,
    required _i4.MultiAddress target,
    required BigInt amount,
  }) {
    return TransferKeepAlive(
      id: id,
      target: target,
      amount: amount,
    );
  }

  ForceTransfer forceTransfer({
    required _i3.Location id,
    required _i4.MultiAddress source,
    required _i4.MultiAddress dest,
    required BigInt amount,
  }) {
    return ForceTransfer(
      id: id,
      source: source,
      dest: dest,
      amount: amount,
    );
  }

  Freeze freeze({
    required _i3.Location id,
    required _i4.MultiAddress who,
  }) {
    return Freeze(
      id: id,
      who: who,
    );
  }

  Thaw thaw({
    required _i3.Location id,
    required _i4.MultiAddress who,
  }) {
    return Thaw(
      id: id,
      who: who,
    );
  }

  FreezeAsset freezeAsset({required _i3.Location id}) {
    return FreezeAsset(id: id);
  }

  ThawAsset thawAsset({required _i3.Location id}) {
    return ThawAsset(id: id);
  }

  TransferOwnership transferOwnership({
    required _i3.Location id,
    required _i4.MultiAddress owner,
  }) {
    return TransferOwnership(
      id: id,
      owner: owner,
    );
  }

  SetTeam setTeam({
    required _i3.Location id,
    required _i4.MultiAddress issuer,
    required _i4.MultiAddress admin,
    required _i4.MultiAddress freezer,
  }) {
    return SetTeam(
      id: id,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    );
  }

  SetMetadata setMetadata({
    required _i3.Location id,
    required List<int> name,
    required List<int> symbol,
    required int decimals,
  }) {
    return SetMetadata(
      id: id,
      name: name,
      symbol: symbol,
      decimals: decimals,
    );
  }

  ClearMetadata clearMetadata({required _i3.Location id}) {
    return ClearMetadata(id: id);
  }

  ForceSetMetadata forceSetMetadata({
    required _i3.Location id,
    required List<int> name,
    required List<int> symbol,
    required int decimals,
    required bool isFrozen,
  }) {
    return ForceSetMetadata(
      id: id,
      name: name,
      symbol: symbol,
      decimals: decimals,
      isFrozen: isFrozen,
    );
  }

  ForceClearMetadata forceClearMetadata({required _i3.Location id}) {
    return ForceClearMetadata(id: id);
  }

  ForceAssetStatus forceAssetStatus({
    required _i3.Location id,
    required _i4.MultiAddress owner,
    required _i4.MultiAddress issuer,
    required _i4.MultiAddress admin,
    required _i4.MultiAddress freezer,
    required BigInt minBalance,
    required bool isSufficient,
    required bool isFrozen,
  }) {
    return ForceAssetStatus(
      id: id,
      owner: owner,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
      minBalance: minBalance,
      isSufficient: isSufficient,
      isFrozen: isFrozen,
    );
  }

  ApproveTransfer approveTransfer({
    required _i3.Location id,
    required _i4.MultiAddress delegate,
    required BigInt amount,
  }) {
    return ApproveTransfer(
      id: id,
      delegate: delegate,
      amount: amount,
    );
  }

  CancelApproval cancelApproval({
    required _i3.Location id,
    required _i4.MultiAddress delegate,
  }) {
    return CancelApproval(
      id: id,
      delegate: delegate,
    );
  }

  ForceCancelApproval forceCancelApproval({
    required _i3.Location id,
    required _i4.MultiAddress owner,
    required _i4.MultiAddress delegate,
  }) {
    return ForceCancelApproval(
      id: id,
      owner: owner,
      delegate: delegate,
    );
  }

  TransferApproved transferApproved({
    required _i3.Location id,
    required _i4.MultiAddress owner,
    required _i4.MultiAddress destination,
    required BigInt amount,
  }) {
    return TransferApproved(
      id: id,
      owner: owner,
      destination: destination,
      amount: amount,
    );
  }

  Touch touch({required _i3.Location id}) {
    return Touch(id: id);
  }

  Refund refund({
    required _i3.Location id,
    required bool allowBurn,
  }) {
    return Refund(
      id: id,
      allowBurn: allowBurn,
    );
  }

  SetMinBalance setMinBalance({
    required _i3.Location id,
    required BigInt minBalance,
  }) {
    return SetMinBalance(
      id: id,
      minBalance: minBalance,
    );
  }

  TouchOther touchOther({
    required _i3.Location id,
    required _i4.MultiAddress who,
  }) {
    return TouchOther(
      id: id,
      who: who,
    );
  }

  RefundOther refundOther({
    required _i3.Location id,
    required _i4.MultiAddress who,
  }) {
    return RefundOther(
      id: id,
      who: who,
    );
  }

  Block block({
    required _i3.Location id,
    required _i4.MultiAddress who,
  }) {
    return Block(
      id: id,
      who: who,
    );
  }

  TransferAll transferAll({
    required _i3.Location id,
    required _i4.MultiAddress dest,
    required bool keepAlive,
  }) {
    return TransferAll(
      id: id,
      dest: dest,
      keepAlive: keepAlive,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Create._decode(input);
      case 1:
        return ForceCreate._decode(input);
      case 2:
        return StartDestroy._decode(input);
      case 3:
        return DestroyAccounts._decode(input);
      case 4:
        return DestroyApprovals._decode(input);
      case 5:
        return FinishDestroy._decode(input);
      case 6:
        return Mint._decode(input);
      case 7:
        return Burn._decode(input);
      case 8:
        return Transfer._decode(input);
      case 9:
        return TransferKeepAlive._decode(input);
      case 10:
        return ForceTransfer._decode(input);
      case 11:
        return Freeze._decode(input);
      case 12:
        return Thaw._decode(input);
      case 13:
        return FreezeAsset._decode(input);
      case 14:
        return ThawAsset._decode(input);
      case 15:
        return TransferOwnership._decode(input);
      case 16:
        return SetTeam._decode(input);
      case 17:
        return SetMetadata._decode(input);
      case 18:
        return ClearMetadata._decode(input);
      case 19:
        return ForceSetMetadata._decode(input);
      case 20:
        return ForceClearMetadata._decode(input);
      case 21:
        return ForceAssetStatus._decode(input);
      case 22:
        return ApproveTransfer._decode(input);
      case 23:
        return CancelApproval._decode(input);
      case 24:
        return ForceCancelApproval._decode(input);
      case 25:
        return TransferApproved._decode(input);
      case 26:
        return Touch._decode(input);
      case 27:
        return Refund._decode(input);
      case 28:
        return SetMinBalance._decode(input);
      case 29:
        return TouchOther._decode(input);
      case 30:
        return RefundOther._decode(input);
      case 31:
        return Block._decode(input);
      case 32:
        return TransferAll._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Create:
        (value as Create).encodeTo(output);
        break;
      case ForceCreate:
        (value as ForceCreate).encodeTo(output);
        break;
      case StartDestroy:
        (value as StartDestroy).encodeTo(output);
        break;
      case DestroyAccounts:
        (value as DestroyAccounts).encodeTo(output);
        break;
      case DestroyApprovals:
        (value as DestroyApprovals).encodeTo(output);
        break;
      case FinishDestroy:
        (value as FinishDestroy).encodeTo(output);
        break;
      case Mint:
        (value as Mint).encodeTo(output);
        break;
      case Burn:
        (value as Burn).encodeTo(output);
        break;
      case Transfer:
        (value as Transfer).encodeTo(output);
        break;
      case TransferKeepAlive:
        (value as TransferKeepAlive).encodeTo(output);
        break;
      case ForceTransfer:
        (value as ForceTransfer).encodeTo(output);
        break;
      case Freeze:
        (value as Freeze).encodeTo(output);
        break;
      case Thaw:
        (value as Thaw).encodeTo(output);
        break;
      case FreezeAsset:
        (value as FreezeAsset).encodeTo(output);
        break;
      case ThawAsset:
        (value as ThawAsset).encodeTo(output);
        break;
      case TransferOwnership:
        (value as TransferOwnership).encodeTo(output);
        break;
      case SetTeam:
        (value as SetTeam).encodeTo(output);
        break;
      case SetMetadata:
        (value as SetMetadata).encodeTo(output);
        break;
      case ClearMetadata:
        (value as ClearMetadata).encodeTo(output);
        break;
      case ForceSetMetadata:
        (value as ForceSetMetadata).encodeTo(output);
        break;
      case ForceClearMetadata:
        (value as ForceClearMetadata).encodeTo(output);
        break;
      case ForceAssetStatus:
        (value as ForceAssetStatus).encodeTo(output);
        break;
      case ApproveTransfer:
        (value as ApproveTransfer).encodeTo(output);
        break;
      case CancelApproval:
        (value as CancelApproval).encodeTo(output);
        break;
      case ForceCancelApproval:
        (value as ForceCancelApproval).encodeTo(output);
        break;
      case TransferApproved:
        (value as TransferApproved).encodeTo(output);
        break;
      case Touch:
        (value as Touch).encodeTo(output);
        break;
      case Refund:
        (value as Refund).encodeTo(output);
        break;
      case SetMinBalance:
        (value as SetMinBalance).encodeTo(output);
        break;
      case TouchOther:
        (value as TouchOther).encodeTo(output);
        break;
      case RefundOther:
        (value as RefundOther).encodeTo(output);
        break;
      case Block:
        (value as Block).encodeTo(output);
        break;
      case TransferAll:
        (value as TransferAll).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Create:
        return (value as Create)._sizeHint();
      case ForceCreate:
        return (value as ForceCreate)._sizeHint();
      case StartDestroy:
        return (value as StartDestroy)._sizeHint();
      case DestroyAccounts:
        return (value as DestroyAccounts)._sizeHint();
      case DestroyApprovals:
        return (value as DestroyApprovals)._sizeHint();
      case FinishDestroy:
        return (value as FinishDestroy)._sizeHint();
      case Mint:
        return (value as Mint)._sizeHint();
      case Burn:
        return (value as Burn)._sizeHint();
      case Transfer:
        return (value as Transfer)._sizeHint();
      case TransferKeepAlive:
        return (value as TransferKeepAlive)._sizeHint();
      case ForceTransfer:
        return (value as ForceTransfer)._sizeHint();
      case Freeze:
        return (value as Freeze)._sizeHint();
      case Thaw:
        return (value as Thaw)._sizeHint();
      case FreezeAsset:
        return (value as FreezeAsset)._sizeHint();
      case ThawAsset:
        return (value as ThawAsset)._sizeHint();
      case TransferOwnership:
        return (value as TransferOwnership)._sizeHint();
      case SetTeam:
        return (value as SetTeam)._sizeHint();
      case SetMetadata:
        return (value as SetMetadata)._sizeHint();
      case ClearMetadata:
        return (value as ClearMetadata)._sizeHint();
      case ForceSetMetadata:
        return (value as ForceSetMetadata)._sizeHint();
      case ForceClearMetadata:
        return (value as ForceClearMetadata)._sizeHint();
      case ForceAssetStatus:
        return (value as ForceAssetStatus)._sizeHint();
      case ApproveTransfer:
        return (value as ApproveTransfer)._sizeHint();
      case CancelApproval:
        return (value as CancelApproval)._sizeHint();
      case ForceCancelApproval:
        return (value as ForceCancelApproval)._sizeHint();
      case TransferApproved:
        return (value as TransferApproved)._sizeHint();
      case Touch:
        return (value as Touch)._sizeHint();
      case Refund:
        return (value as Refund)._sizeHint();
      case SetMinBalance:
        return (value as SetMinBalance)._sizeHint();
      case TouchOther:
        return (value as TouchOther)._sizeHint();
      case RefundOther:
        return (value as RefundOther)._sizeHint();
      case Block:
        return (value as Block)._sizeHint();
      case TransferAll:
        return (value as TransferAll)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Issue a new class of fungible assets from a public origin.
///
/// This new asset class has no assets initially and its owner is the origin.
///
/// The origin must conform to the configured `CreateOrigin` and have sufficient funds free.
///
/// Funds of sender are reserved by `AssetDeposit`.
///
/// Parameters:
/// - `id`: The identifier of the new asset. This must not be currently in use to identify
/// an existing asset. If [`NextAssetId`] is set, then this must be equal to it.
/// - `admin`: The admin of this class of assets. The admin is the initial address of each
/// member of the asset class's admin team.
/// - `min_balance`: The minimum balance of this new asset that any single account must
/// have. If an account's balance is reduced below this, then it collapses to zero.
///
/// Emits `Created` event when successful.
///
/// Weight: `O(1)`
class Create extends Call {
  const Create({
    required this.id,
    required this.admin,
    required this.minBalance,
  });

  factory Create._decode(_i1.Input input) {
    return Create(
      id: _i3.Location.codec.decode(input),
      admin: _i4.MultiAddress.codec.decode(input),
      minBalance: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress admin;

  /// T::Balance
  final BigInt minBalance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create': {
          'id': id.toJson(),
          'admin': admin.toJson(),
          'minBalance': minBalance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(admin);
    size = size + _i1.U128Codec.codec.sizeHint(minBalance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      admin,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      minBalance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Create && other.id == id && other.admin == admin && other.minBalance == minBalance;

  @override
  int get hashCode => Object.hash(
        id,
        admin,
        minBalance,
      );
}

/// Issue a new class of fungible assets from a privileged origin.
///
/// This new asset class has no assets initially.
///
/// The origin must conform to `ForceOrigin`.
///
/// Unlike `create`, no funds are reserved.
///
/// - `id`: The identifier of the new asset. This must not be currently in use to identify
/// an existing asset. If [`NextAssetId`] is set, then this must be equal to it.
/// - `owner`: The owner of this class of assets. The owner has full superuser permissions
/// over this asset, but may later change and configure the permissions using
/// `transfer_ownership` and `set_team`.
/// - `min_balance`: The minimum balance of this new asset that any single account must
/// have. If an account's balance is reduced below this, then it collapses to zero.
///
/// Emits `ForceCreated` event when successful.
///
/// Weight: `O(1)`
class ForceCreate extends Call {
  const ForceCreate({
    required this.id,
    required this.owner,
    required this.isSufficient,
    required this.minBalance,
  });

  factory ForceCreate._decode(_i1.Input input) {
    return ForceCreate(
      id: _i3.Location.codec.decode(input),
      owner: _i4.MultiAddress.codec.decode(input),
      isSufficient: _i1.BoolCodec.codec.decode(input),
      minBalance: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress owner;

  /// bool
  final bool isSufficient;

  /// T::Balance
  final BigInt minBalance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_create': {
          'id': id.toJson(),
          'owner': owner.toJson(),
          'isSufficient': isSufficient,
          'minBalance': minBalance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(owner);
    size = size + _i1.BoolCodec.codec.sizeHint(isSufficient);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(minBalance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isSufficient,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      minBalance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCreate &&
          other.id == id &&
          other.owner == owner &&
          other.isSufficient == isSufficient &&
          other.minBalance == minBalance;

  @override
  int get hashCode => Object.hash(
        id,
        owner,
        isSufficient,
        minBalance,
      );
}

/// Start the process of destroying a fungible asset class.
///
/// `start_destroy` is the first in a series of extrinsics that should be called, to allow
/// destruction of an asset class.
///
/// The origin must conform to `ForceOrigin` or must be `Signed` by the asset's `owner`.
///
/// - `id`: The identifier of the asset to be destroyed. This must identify an existing
///  asset.
///
/// It will fail with either [`Error::ContainsHolds`] or [`Error::ContainsFreezes`] if
/// an account contains holds or freezes in place.
class StartDestroy extends Call {
  const StartDestroy({required this.id});

  factory StartDestroy._decode(_i1.Input input) {
    return StartDestroy(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'start_destroy': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is StartDestroy && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Destroy all accounts associated with a given asset.
///
/// `destroy_accounts` should only be called after `start_destroy` has been called, and the
/// asset is in a `Destroying` state.
///
/// Due to weight restrictions, this function may need to be called multiple times to fully
/// destroy all accounts. It will destroy `RemoveItemsLimit` accounts at a time.
///
/// - `id`: The identifier of the asset to be destroyed. This must identify an existing
///  asset.
///
/// Each call emits the `Event::DestroyedAccounts` event.
class DestroyAccounts extends Call {
  const DestroyAccounts({required this.id});

  factory DestroyAccounts._decode(_i1.Input input) {
    return DestroyAccounts(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'destroy_accounts': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DestroyAccounts && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Destroy all approvals associated with a given asset up to the max (T::RemoveItemsLimit).
///
/// `destroy_approvals` should only be called after `start_destroy` has been called, and the
/// asset is in a `Destroying` state.
///
/// Due to weight restrictions, this function may need to be called multiple times to fully
/// destroy all approvals. It will destroy `RemoveItemsLimit` approvals at a time.
///
/// - `id`: The identifier of the asset to be destroyed. This must identify an existing
///  asset.
///
/// Each call emits the `Event::DestroyedApprovals` event.
class DestroyApprovals extends Call {
  const DestroyApprovals({required this.id});

  factory DestroyApprovals._decode(_i1.Input input) {
    return DestroyApprovals(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'destroy_approvals': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DestroyApprovals && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Complete destroying asset and unreserve currency.
///
/// `finish_destroy` should only be called after `start_destroy` has been called, and the
/// asset is in a `Destroying` state. All accounts or approvals should be destroyed before
/// hand.
///
/// - `id`: The identifier of the asset to be destroyed. This must identify an existing
///  asset.
///
/// Each successful call emits the `Event::Destroyed` event.
class FinishDestroy extends Call {
  const FinishDestroy({required this.id});

  factory FinishDestroy._decode(_i1.Input input) {
    return FinishDestroy(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'finish_destroy': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FinishDestroy && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Mint assets of a particular class.
///
/// The origin must be Signed and the sender must be the Issuer of the asset `id`.
///
/// - `id`: The identifier of the asset to have some amount minted.
/// - `beneficiary`: The account to be credited with the minted assets.
/// - `amount`: The amount of the asset to be minted.
///
/// Emits `Issued` event when successful.
///
/// Weight: `O(1)`
/// Modes: Pre-existing balance of `beneficiary`; Account pre-existence of `beneficiary`.
class Mint extends Call {
  const Mint({
    required this.id,
    required this.beneficiary,
    required this.amount,
  });

  factory Mint._decode(_i1.Input input) {
    return Mint(
      id: _i3.Location.codec.decode(input),
      beneficiary: _i4.MultiAddress.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress beneficiary;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'mint': {
          'id': id.toJson(),
          'beneficiary': beneficiary.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(beneficiary);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      beneficiary,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Mint && other.id == id && other.beneficiary == beneficiary && other.amount == amount;

  @override
  int get hashCode => Object.hash(
        id,
        beneficiary,
        amount,
      );
}

/// Reduce the balance of `who` by as much as possible up to `amount` assets of `id`.
///
/// Origin must be Signed and the sender should be the Manager of the asset `id`.
///
/// Bails with `NoAccount` if the `who` is already dead.
///
/// - `id`: The identifier of the asset to have some amount burned.
/// - `who`: The account to be debited from.
/// - `amount`: The maximum amount by which `who`'s balance should be reduced.
///
/// Emits `Burned` with the actual amount burned. If this takes the balance to below the
/// minimum for the asset, then the amount burned is increased to take it to zero.
///
/// Weight: `O(1)`
/// Modes: Post-existence of `who`; Pre & post Zombie-status of `who`.
class Burn extends Call {
  const Burn({
    required this.id,
    required this.who,
    required this.amount,
  });

  factory Burn._decode(_i1.Input input) {
    return Burn(
      id: _i3.Location.codec.decode(input),
      who: _i4.MultiAddress.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress who;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'burn': {
          'id': id.toJson(),
          'who': who.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(who);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      who,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Burn && other.id == id && other.who == who && other.amount == amount;

  @override
  int get hashCode => Object.hash(
        id,
        who,
        amount,
      );
}

/// Move some assets from the sender account to another.
///
/// Origin must be Signed.
///
/// - `id`: The identifier of the asset to have some amount transferred.
/// - `target`: The account to be credited.
/// - `amount`: The amount by which the sender's balance of assets should be reduced and
/// `target`'s balance increased. The amount actually transferred may be slightly greater in
/// the case that the transfer would otherwise take the sender balance above zero but below
/// the minimum balance. Must be greater than zero.
///
/// Emits `Transferred` with the actual amount transferred. If this takes the source balance
/// to below the minimum for the asset, then the amount transferred is increased to take it
/// to zero.
///
/// Weight: `O(1)`
/// Modes: Pre-existence of `target`; Post-existence of sender; Account pre-existence of
/// `target`.
class Transfer extends Call {
  const Transfer({
    required this.id,
    required this.target,
    required this.amount,
  });

  factory Transfer._decode(_i1.Input input) {
    return Transfer(
      id: _i3.Location.codec.decode(input),
      target: _i4.MultiAddress.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress target;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer': {
          'id': id.toJson(),
          'target': target.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(target);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transfer && other.id == id && other.target == target && other.amount == amount;

  @override
  int get hashCode => Object.hash(
        id,
        target,
        amount,
      );
}

/// Move some assets from the sender account to another, keeping the sender account alive.
///
/// Origin must be Signed.
///
/// - `id`: The identifier of the asset to have some amount transferred.
/// - `target`: The account to be credited.
/// - `amount`: The amount by which the sender's balance of assets should be reduced and
/// `target`'s balance increased. The amount actually transferred may be slightly greater in
/// the case that the transfer would otherwise take the sender balance above zero but below
/// the minimum balance. Must be greater than zero.
///
/// Emits `Transferred` with the actual amount transferred. If this takes the source balance
/// to below the minimum for the asset, then the amount transferred is increased to take it
/// to zero.
///
/// Weight: `O(1)`
/// Modes: Pre-existence of `target`; Post-existence of sender; Account pre-existence of
/// `target`.
class TransferKeepAlive extends Call {
  const TransferKeepAlive({
    required this.id,
    required this.target,
    required this.amount,
  });

  factory TransferKeepAlive._decode(_i1.Input input) {
    return TransferKeepAlive(
      id: _i3.Location.codec.decode(input),
      target: _i4.MultiAddress.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress target;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer_keep_alive': {
          'id': id.toJson(),
          'target': target.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(target);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferKeepAlive && other.id == id && other.target == target && other.amount == amount;

  @override
  int get hashCode => Object.hash(
        id,
        target,
        amount,
      );
}

/// Move some assets from one account to another.
///
/// Origin must be Signed and the sender should be the Admin of the asset `id`.
///
/// - `id`: The identifier of the asset to have some amount transferred.
/// - `source`: The account to be debited.
/// - `dest`: The account to be credited.
/// - `amount`: The amount by which the `source`'s balance of assets should be reduced and
/// `dest`'s balance increased. The amount actually transferred may be slightly greater in
/// the case that the transfer would otherwise take the `source` balance above zero but
/// below the minimum balance. Must be greater than zero.
///
/// Emits `Transferred` with the actual amount transferred. If this takes the source balance
/// to below the minimum for the asset, then the amount transferred is increased to take it
/// to zero.
///
/// Weight: `O(1)`
/// Modes: Pre-existence of `dest`; Post-existence of `source`; Account pre-existence of
/// `dest`.
class ForceTransfer extends Call {
  const ForceTransfer({
    required this.id,
    required this.source,
    required this.dest,
    required this.amount,
  });

  factory ForceTransfer._decode(_i1.Input input) {
    return ForceTransfer(
      id: _i3.Location.codec.decode(input),
      source: _i4.MultiAddress.codec.decode(input),
      dest: _i4.MultiAddress.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress source;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress dest;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_transfer': {
          'id': id.toJson(),
          'source': source.toJson(),
          'dest': dest.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(source);
    size = size + _i4.MultiAddress.codec.sizeHint(dest);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      source,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      dest,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceTransfer &&
          other.id == id &&
          other.source == source &&
          other.dest == dest &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        id,
        source,
        dest,
        amount,
      );
}

/// Disallow further unprivileged transfers of an asset `id` from an account `who`. `who`
/// must already exist as an entry in `Account`s of the asset. If you want to freeze an
/// account that does not have an entry, use `touch_other` first.
///
/// Origin must be Signed and the sender should be the Freezer of the asset `id`.
///
/// - `id`: The identifier of the asset to be frozen.
/// - `who`: The account to be frozen.
///
/// Emits `Frozen`.
///
/// Weight: `O(1)`
class Freeze extends Call {
  const Freeze({
    required this.id,
    required this.who,
  });

  factory Freeze._decode(_i1.Input input) {
    return Freeze(
      id: _i3.Location.codec.decode(input),
      who: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'freeze': {
          'id': id.toJson(),
          'who': who.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Freeze && other.id == id && other.who == who;

  @override
  int get hashCode => Object.hash(
        id,
        who,
      );
}

/// Allow unprivileged transfers to and from an account again.
///
/// Origin must be Signed and the sender should be the Admin of the asset `id`.
///
/// - `id`: The identifier of the asset to be frozen.
/// - `who`: The account to be unfrozen.
///
/// Emits `Thawed`.
///
/// Weight: `O(1)`
class Thaw extends Call {
  const Thaw({
    required this.id,
    required this.who,
  });

  factory Thaw._decode(_i1.Input input) {
    return Thaw(
      id: _i3.Location.codec.decode(input),
      who: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'thaw': {
          'id': id.toJson(),
          'who': who.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Thaw && other.id == id && other.who == who;

  @override
  int get hashCode => Object.hash(
        id,
        who,
      );
}

/// Disallow further unprivileged transfers for the asset class.
///
/// Origin must be Signed and the sender should be the Freezer of the asset `id`.
///
/// - `id`: The identifier of the asset to be frozen.
///
/// Emits `Frozen`.
///
/// Weight: `O(1)`
class FreezeAsset extends Call {
  const FreezeAsset({required this.id});

  factory FreezeAsset._decode(_i1.Input input) {
    return FreezeAsset(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'freeze_asset': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FreezeAsset && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Allow unprivileged transfers for the asset again.
///
/// Origin must be Signed and the sender should be the Admin of the asset `id`.
///
/// - `id`: The identifier of the asset to be thawed.
///
/// Emits `Thawed`.
///
/// Weight: `O(1)`
class ThawAsset extends Call {
  const ThawAsset({required this.id});

  factory ThawAsset._decode(_i1.Input input) {
    return ThawAsset(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'thaw_asset': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ThawAsset && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Change the Owner of an asset.
///
/// Origin must be Signed and the sender should be the Owner of the asset `id`.
///
/// - `id`: The identifier of the asset.
/// - `owner`: The new Owner of this asset.
///
/// Emits `OwnerChanged`.
///
/// Weight: `O(1)`
class TransferOwnership extends Call {
  const TransferOwnership({
    required this.id,
    required this.owner,
  });

  factory TransferOwnership._decode(_i1.Input input) {
    return TransferOwnership(
      id: _i3.Location.codec.decode(input),
      owner: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress owner;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'transfer_ownership': {
          'id': id.toJson(),
          'owner': owner.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferOwnership && other.id == id && other.owner == owner;

  @override
  int get hashCode => Object.hash(
        id,
        owner,
      );
}

/// Change the Issuer, Admin and Freezer of an asset.
///
/// Origin must be Signed and the sender should be the Owner of the asset `id`.
///
/// - `id`: The identifier of the asset to be frozen.
/// - `issuer`: The new Issuer of this asset.
/// - `admin`: The new Admin of this asset.
/// - `freezer`: The new Freezer of this asset.
///
/// Emits `TeamChanged`.
///
/// Weight: `O(1)`
class SetTeam extends Call {
  const SetTeam({
    required this.id,
    required this.issuer,
    required this.admin,
    required this.freezer,
  });

  factory SetTeam._decode(_i1.Input input) {
    return SetTeam(
      id: _i3.Location.codec.decode(input),
      issuer: _i4.MultiAddress.codec.decode(input),
      admin: _i4.MultiAddress.codec.decode(input),
      freezer: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress issuer;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress admin;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress freezer;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_team': {
          'id': id.toJson(),
          'issuer': issuer.toJson(),
          'admin': admin.toJson(),
          'freezer': freezer.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(issuer);
    size = size + _i4.MultiAddress.codec.sizeHint(admin);
    size = size + _i4.MultiAddress.codec.sizeHint(freezer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      issuer,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      admin,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      freezer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetTeam && other.id == id && other.issuer == issuer && other.admin == admin && other.freezer == freezer;

  @override
  int get hashCode => Object.hash(
        id,
        issuer,
        admin,
        freezer,
      );
}

/// Set the metadata for an asset.
///
/// Origin must be Signed and the sender should be the Owner of the asset `id`.
///
/// Funds of sender are reserved according to the formula:
/// `MetadataDepositBase + MetadataDepositPerByte * (name.len + symbol.len)` taking into
/// account any already reserved funds.
///
/// - `id`: The identifier of the asset to update.
/// - `name`: The user friendly name of this asset. Limited in length by `StringLimit`.
/// - `symbol`: The exchange symbol for this asset. Limited in length by `StringLimit`.
/// - `decimals`: The number of decimals this asset uses to represent one unit.
///
/// Emits `MetadataSet`.
///
/// Weight: `O(1)`
class SetMetadata extends Call {
  const SetMetadata({
    required this.id,
    required this.name,
    required this.symbol,
    required this.decimals,
  });

  factory SetMetadata._decode(_i1.Input input) {
    return SetMetadata(
      id: _i3.Location.codec.decode(input),
      name: _i1.U8SequenceCodec.codec.decode(input),
      symbol: _i1.U8SequenceCodec.codec.decode(input),
      decimals: _i1.U8Codec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// Vec<u8>
  final List<int> name;

  /// Vec<u8>
  final List<int> symbol;

  /// u8
  final int decimals;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_metadata': {
          'id': id.toJson(),
          'name': name,
          'symbol': symbol,
          'decimals': decimals,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(name);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(symbol);
    size = size + _i1.U8Codec.codec.sizeHint(decimals);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      name,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      symbol,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      decimals,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMetadata &&
          other.id == id &&
          _i5.listsEqual(
            other.name,
            name,
          ) &&
          _i5.listsEqual(
            other.symbol,
            symbol,
          ) &&
          other.decimals == decimals;

  @override
  int get hashCode => Object.hash(
        id,
        name,
        symbol,
        decimals,
      );
}

/// Clear the metadata for an asset.
///
/// Origin must be Signed and the sender should be the Owner of the asset `id`.
///
/// Any deposit is freed for the asset owner.
///
/// - `id`: The identifier of the asset to clear.
///
/// Emits `MetadataCleared`.
///
/// Weight: `O(1)`
class ClearMetadata extends Call {
  const ClearMetadata({required this.id});

  factory ClearMetadata._decode(_i1.Input input) {
    return ClearMetadata(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'clear_metadata': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearMetadata && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Force the metadata for an asset to some value.
///
/// Origin must be ForceOrigin.
///
/// Any deposit is left alone.
///
/// - `id`: The identifier of the asset to update.
/// - `name`: The user friendly name of this asset. Limited in length by `StringLimit`.
/// - `symbol`: The exchange symbol for this asset. Limited in length by `StringLimit`.
/// - `decimals`: The number of decimals this asset uses to represent one unit.
///
/// Emits `MetadataSet`.
///
/// Weight: `O(N + S)` where N and S are the length of the name and symbol respectively.
class ForceSetMetadata extends Call {
  const ForceSetMetadata({
    required this.id,
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.isFrozen,
  });

  factory ForceSetMetadata._decode(_i1.Input input) {
    return ForceSetMetadata(
      id: _i3.Location.codec.decode(input),
      name: _i1.U8SequenceCodec.codec.decode(input),
      symbol: _i1.U8SequenceCodec.codec.decode(input),
      decimals: _i1.U8Codec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// Vec<u8>
  final List<int> name;

  /// Vec<u8>
  final List<int> symbol;

  /// u8
  final int decimals;

  /// bool
  final bool isFrozen;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_set_metadata': {
          'id': id.toJson(),
          'name': name,
          'symbol': symbol,
          'decimals': decimals,
          'isFrozen': isFrozen,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(name);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(symbol);
    size = size + _i1.U8Codec.codec.sizeHint(decimals);
    size = size + _i1.BoolCodec.codec.sizeHint(isFrozen);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      name,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      symbol,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      decimals,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isFrozen,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceSetMetadata &&
          other.id == id &&
          _i5.listsEqual(
            other.name,
            name,
          ) &&
          _i5.listsEqual(
            other.symbol,
            symbol,
          ) &&
          other.decimals == decimals &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        id,
        name,
        symbol,
        decimals,
        isFrozen,
      );
}

/// Clear the metadata for an asset.
///
/// Origin must be ForceOrigin.
///
/// Any deposit is returned.
///
/// - `id`: The identifier of the asset to clear.
///
/// Emits `MetadataCleared`.
///
/// Weight: `O(1)`
class ForceClearMetadata extends Call {
  const ForceClearMetadata({required this.id});

  factory ForceClearMetadata._decode(_i1.Input input) {
    return ForceClearMetadata(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'force_clear_metadata': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceClearMetadata && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Alter the attributes of a given asset.
///
/// Origin must be `ForceOrigin`.
///
/// - `id`: The identifier of the asset.
/// - `owner`: The new Owner of this asset.
/// - `issuer`: The new Issuer of this asset.
/// - `admin`: The new Admin of this asset.
/// - `freezer`: The new Freezer of this asset.
/// - `min_balance`: The minimum balance of this new asset that any single account must
/// have. If an account's balance is reduced below this, then it collapses to zero.
/// - `is_sufficient`: Whether a non-zero balance of this asset is deposit of sufficient
/// value to account for the state bloat associated with its balance storage. If set to
/// `true`, then non-zero balances may be stored without a `consumer` reference (and thus
/// an ED in the Balances pallet or whatever else is used to control user-account state
/// growth).
/// - `is_frozen`: Whether this asset class is frozen except for permissioned/admin
/// instructions.
///
/// Emits `AssetStatusChanged` with the identity of the asset.
///
/// Weight: `O(1)`
class ForceAssetStatus extends Call {
  const ForceAssetStatus({
    required this.id,
    required this.owner,
    required this.issuer,
    required this.admin,
    required this.freezer,
    required this.minBalance,
    required this.isSufficient,
    required this.isFrozen,
  });

  factory ForceAssetStatus._decode(_i1.Input input) {
    return ForceAssetStatus(
      id: _i3.Location.codec.decode(input),
      owner: _i4.MultiAddress.codec.decode(input),
      issuer: _i4.MultiAddress.codec.decode(input),
      admin: _i4.MultiAddress.codec.decode(input),
      freezer: _i4.MultiAddress.codec.decode(input),
      minBalance: _i1.CompactBigIntCodec.codec.decode(input),
      isSufficient: _i1.BoolCodec.codec.decode(input),
      isFrozen: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress owner;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress issuer;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress admin;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress freezer;

  /// T::Balance
  final BigInt minBalance;

  /// bool
  final bool isSufficient;

  /// bool
  final bool isFrozen;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_asset_status': {
          'id': id.toJson(),
          'owner': owner.toJson(),
          'issuer': issuer.toJson(),
          'admin': admin.toJson(),
          'freezer': freezer.toJson(),
          'minBalance': minBalance,
          'isSufficient': isSufficient,
          'isFrozen': isFrozen,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(owner);
    size = size + _i4.MultiAddress.codec.sizeHint(issuer);
    size = size + _i4.MultiAddress.codec.sizeHint(admin);
    size = size + _i4.MultiAddress.codec.sizeHint(freezer);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(minBalance);
    size = size + _i1.BoolCodec.codec.sizeHint(isSufficient);
    size = size + _i1.BoolCodec.codec.sizeHint(isFrozen);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      issuer,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      admin,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      freezer,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      minBalance,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isSufficient,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isFrozen,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceAssetStatus &&
          other.id == id &&
          other.owner == owner &&
          other.issuer == issuer &&
          other.admin == admin &&
          other.freezer == freezer &&
          other.minBalance == minBalance &&
          other.isSufficient == isSufficient &&
          other.isFrozen == isFrozen;

  @override
  int get hashCode => Object.hash(
        id,
        owner,
        issuer,
        admin,
        freezer,
        minBalance,
        isSufficient,
        isFrozen,
      );
}

/// Approve an amount of asset for transfer by a delegated third-party account.
///
/// Origin must be Signed.
///
/// Ensures that `ApprovalDeposit` worth of `Currency` is reserved from signing account
/// for the purpose of holding the approval. If some non-zero amount of assets is already
/// approved from signing account to `delegate`, then it is topped up or unreserved to
/// meet the right value.
///
/// NOTE: The signing account does not need to own `amount` of assets at the point of
/// making this call.
///
/// - `id`: The identifier of the asset.
/// - `delegate`: The account to delegate permission to transfer asset.
/// - `amount`: The amount of asset that may be transferred by `delegate`. If there is
/// already an approval in place, then this acts additively.
///
/// Emits `ApprovedTransfer` on success.
///
/// Weight: `O(1)`
class ApproveTransfer extends Call {
  const ApproveTransfer({
    required this.id,
    required this.delegate,
    required this.amount,
  });

  factory ApproveTransfer._decode(_i1.Input input) {
    return ApproveTransfer(
      id: _i3.Location.codec.decode(input),
      delegate: _i4.MultiAddress.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress delegate;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'approve_transfer': {
          'id': id.toJson(),
          'delegate': delegate.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(delegate);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApproveTransfer && other.id == id && other.delegate == delegate && other.amount == amount;

  @override
  int get hashCode => Object.hash(
        id,
        delegate,
        amount,
      );
}

/// Cancel all of some asset approved for delegated transfer by a third-party account.
///
/// Origin must be Signed and there must be an approval in place between signer and
/// `delegate`.
///
/// Unreserves any deposit previously reserved by `approve_transfer` for the approval.
///
/// - `id`: The identifier of the asset.
/// - `delegate`: The account delegated permission to transfer asset.
///
/// Emits `ApprovalCancelled` on success.
///
/// Weight: `O(1)`
class CancelApproval extends Call {
  const CancelApproval({
    required this.id,
    required this.delegate,
  });

  factory CancelApproval._decode(_i1.Input input) {
    return CancelApproval(
      id: _i3.Location.codec.decode(input),
      delegate: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress delegate;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'cancel_approval': {
          'id': id.toJson(),
          'delegate': delegate.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelApproval && other.id == id && other.delegate == delegate;

  @override
  int get hashCode => Object.hash(
        id,
        delegate,
      );
}

/// Cancel all of some asset approved for delegated transfer by a third-party account.
///
/// Origin must be either ForceOrigin or Signed origin with the signer being the Admin
/// account of the asset `id`.
///
/// Unreserves any deposit previously reserved by `approve_transfer` for the approval.
///
/// - `id`: The identifier of the asset.
/// - `delegate`: The account delegated permission to transfer asset.
///
/// Emits `ApprovalCancelled` on success.
///
/// Weight: `O(1)`
class ForceCancelApproval extends Call {
  const ForceCancelApproval({
    required this.id,
    required this.owner,
    required this.delegate,
  });

  factory ForceCancelApproval._decode(_i1.Input input) {
    return ForceCancelApproval(
      id: _i3.Location.codec.decode(input),
      owner: _i4.MultiAddress.codec.decode(input),
      delegate: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress owner;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress delegate;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'force_cancel_approval': {
          'id': id.toJson(),
          'owner': owner.toJson(),
          'delegate': delegate.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(owner);
    size = size + _i4.MultiAddress.codec.sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCancelApproval && other.id == id && other.owner == owner && other.delegate == delegate;

  @override
  int get hashCode => Object.hash(
        id,
        owner,
        delegate,
      );
}

/// Transfer some asset balance from a previously delegated account to some third-party
/// account.
///
/// Origin must be Signed and there must be an approval in place by the `owner` to the
/// signer.
///
/// If the entire amount approved for transfer is transferred, then any deposit previously
/// reserved by `approve_transfer` is unreserved.
///
/// - `id`: The identifier of the asset.
/// - `owner`: The account which previously approved for a transfer of at least `amount` and
/// from which the asset balance will be withdrawn.
/// - `destination`: The account to which the asset balance of `amount` will be transferred.
/// - `amount`: The amount of assets to transfer.
///
/// Emits `TransferredApproved` on success.
///
/// Weight: `O(1)`
class TransferApproved extends Call {
  const TransferApproved({
    required this.id,
    required this.owner,
    required this.destination,
    required this.amount,
  });

  factory TransferApproved._decode(_i1.Input input) {
    return TransferApproved(
      id: _i3.Location.codec.decode(input),
      owner: _i4.MultiAddress.codec.decode(input),
      destination: _i4.MultiAddress.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress owner;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress destination;

  /// T::Balance
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer_approved': {
          'id': id.toJson(),
          'owner': owner.toJson(),
          'destination': destination.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(owner);
    size = size + _i4.MultiAddress.codec.sizeHint(destination);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      destination,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferApproved &&
          other.id == id &&
          other.owner == owner &&
          other.destination == destination &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        id,
        owner,
        destination,
        amount,
      );
}

/// Create an asset account for non-provider assets.
///
/// A deposit will be taken from the signer account.
///
/// - `origin`: Must be Signed; the signer account must have sufficient funds for a deposit
///  to be taken.
/// - `id`: The identifier of the asset for the account to be created.
///
/// Emits `Touched` event when successful.
class Touch extends Call {
  const Touch({required this.id});

  factory Touch._decode(_i1.Input input) {
    return Touch(id: _i3.Location.codec.decode(input));
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'touch': {'id': id.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Touch && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Return the deposit (if any) of an asset account or a consumer reference (if any) of an
/// account.
///
/// The origin must be Signed.
///
/// - `id`: The identifier of the asset for which the caller would like the deposit
///  refunded.
/// - `allow_burn`: If `true` then assets may be destroyed in order to complete the refund.
///
/// It will fail with either [`Error::ContainsHolds`] or [`Error::ContainsFreezes`] if
/// the asset account contains holds or freezes in place.
///
/// Emits `Refunded` event when successful.
class Refund extends Call {
  const Refund({
    required this.id,
    required this.allowBurn,
  });

  factory Refund._decode(_i1.Input input) {
    return Refund(
      id: _i3.Location.codec.decode(input),
      allowBurn: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// bool
  final bool allowBurn;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'refund': {
          'id': id.toJson(),
          'allowBurn': allowBurn,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i1.BoolCodec.codec.sizeHint(allowBurn);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      allowBurn,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Refund && other.id == id && other.allowBurn == allowBurn;

  @override
  int get hashCode => Object.hash(
        id,
        allowBurn,
      );
}

/// Sets the minimum balance of an asset.
///
/// Only works if there aren't any accounts that are holding the asset or if
/// the new value of `min_balance` is less than the old one.
///
/// Origin must be Signed and the sender has to be the Owner of the
/// asset `id`.
///
/// - `id`: The identifier of the asset.
/// - `min_balance`: The new value of `min_balance`.
///
/// Emits `AssetMinBalanceChanged` event when successful.
class SetMinBalance extends Call {
  const SetMinBalance({
    required this.id,
    required this.minBalance,
  });

  factory SetMinBalance._decode(_i1.Input input) {
    return SetMinBalance(
      id: _i3.Location.codec.decode(input),
      minBalance: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// T::Balance
  final BigInt minBalance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_min_balance': {
          'id': id.toJson(),
          'minBalance': minBalance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i1.U128Codec.codec.sizeHint(minBalance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      minBalance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMinBalance && other.id == id && other.minBalance == minBalance;

  @override
  int get hashCode => Object.hash(
        id,
        minBalance,
      );
}

/// Create an asset account for `who`.
///
/// A deposit will be taken from the signer account.
///
/// - `origin`: Must be Signed by `Freezer` or `Admin` of the asset `id`; the signer account
///  must have sufficient funds for a deposit to be taken.
/// - `id`: The identifier of the asset for the account to be created.
/// - `who`: The account to be created.
///
/// Emits `Touched` event when successful.
class TouchOther extends Call {
  const TouchOther({
    required this.id,
    required this.who,
  });

  factory TouchOther._decode(_i1.Input input) {
    return TouchOther(
      id: _i3.Location.codec.decode(input),
      who: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'touch_other': {
          'id': id.toJson(),
          'who': who.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TouchOther && other.id == id && other.who == who;

  @override
  int get hashCode => Object.hash(
        id,
        who,
      );
}

/// Return the deposit (if any) of a target asset account. Useful if you are the depositor.
///
/// The origin must be Signed and either the account owner, depositor, or asset `Admin`. In
/// order to burn a non-zero balance of the asset, the caller must be the account and should
/// use `refund`.
///
/// - `id`: The identifier of the asset for the account holding a deposit.
/// - `who`: The account to refund.
///
/// It will fail with either [`Error::ContainsHolds`] or [`Error::ContainsFreezes`] if
/// the asset account contains holds or freezes in place.
///
/// Emits `Refunded` event when successful.
class RefundOther extends Call {
  const RefundOther({
    required this.id,
    required this.who,
  });

  factory RefundOther._decode(_i1.Input input) {
    return RefundOther(
      id: _i3.Location.codec.decode(input),
      who: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'refund_other': {
          'id': id.toJson(),
          'who': who.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RefundOther && other.id == id && other.who == who;

  @override
  int get hashCode => Object.hash(
        id,
        who,
      );
}

/// Disallow further unprivileged transfers of an asset `id` to and from an account `who`.
///
/// Origin must be Signed and the sender should be the Freezer of the asset `id`.
///
/// - `id`: The identifier of the account's asset.
/// - `who`: The account to be unblocked.
///
/// Emits `Blocked`.
///
/// Weight: `O(1)`
class Block extends Call {
  const Block({
    required this.id,
    required this.who,
  });

  factory Block._decode(_i1.Input input) {
    return Block(
      id: _i3.Location.codec.decode(input),
      who: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress who;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'block': {
          'id': id.toJson(),
          'who': who.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Block && other.id == id && other.who == who;

  @override
  int get hashCode => Object.hash(
        id,
        who,
      );
}

/// Transfer the entire transferable balance from the caller asset account.
///
/// NOTE: This function only attempts to transfer _transferable_ balances. This means that
/// any held, frozen, or minimum balance (when `keep_alive` is `true`), will not be
/// transferred by this function. To ensure that this function results in a killed account,
/// you might need to prepare the account by removing any reference counters, storage
/// deposits, etc...
///
/// The dispatch origin of this call must be Signed.
///
/// - `id`: The identifier of the asset for the account holding a deposit.
/// - `dest`: The recipient of the transfer.
/// - `keep_alive`: A boolean to determine if the `transfer_all` operation should send all
///  of the funds the asset account has, causing the sender asset account to be killed
///  (false), or transfer everything except at least the minimum balance, which will
///  guarantee to keep the sender asset account alive (true).
class TransferAll extends Call {
  const TransferAll({
    required this.id,
    required this.dest,
    required this.keepAlive,
  });

  factory TransferAll._decode(_i1.Input input) {
    return TransferAll(
      id: _i3.Location.codec.decode(input),
      dest: _i4.MultiAddress.codec.decode(input),
      keepAlive: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::AssetIdParameter
  final _i3.Location id;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress dest;

  /// bool
  final bool keepAlive;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer_all': {
          'id': id.toJson(),
          'dest': dest.toJson(),
          'keepAlive': keepAlive,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Location.codec.sizeHint(id);
    size = size + _i4.MultiAddress.codec.sizeHint(dest);
    size = size + _i1.BoolCodec.codec.sizeHint(keepAlive);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i3.Location.codec.encodeTo(
      id,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      dest,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      keepAlive,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferAll && other.id == id && other.dest == dest && other.keepAlive == keepAlive;

  @override
  int get hashCode => Object.hash(
        id,
        dest,
        keepAlive,
      );
}
