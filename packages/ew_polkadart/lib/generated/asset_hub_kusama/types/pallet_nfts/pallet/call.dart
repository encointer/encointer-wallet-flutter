// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i18;

import '../../sp_core/crypto/account_id32.dart' as _i10;
import '../../sp_runtime/multi_signature.dart' as _i16;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import '../types/attribute_namespace.dart' as _i9;
import '../types/bit_flags_1.dart' as _i8;
import '../types/cancel_attributes_approval_witness.dart' as _i11;
import '../types/collection_config.dart' as _i4;
import '../types/destroy_witness.dart' as _i5;
import '../types/item_config.dart' as _i7;
import '../types/item_tip.dart' as _i13;
import '../types/mint_settings.dart' as _i12;
import '../types/mint_witness.dart' as _i6;
import '../types/pre_signed_attributes.dart' as _i17;
import '../types/pre_signed_mint.dart' as _i15;
import '../types/price_with_direction.dart' as _i14;

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
    required _i3.MultiAddress admin,
    required _i4.CollectionConfig config,
  }) {
    return Create(
      admin: admin,
      config: config,
    );
  }

  ForceCreate forceCreate({
    required _i3.MultiAddress owner,
    required _i4.CollectionConfig config,
  }) {
    return ForceCreate(
      owner: owner,
      config: config,
    );
  }

  Destroy destroy({
    required int collection,
    required _i5.DestroyWitness witness,
  }) {
    return Destroy(
      collection: collection,
      witness: witness,
    );
  }

  Mint mint({
    required int collection,
    required int item,
    required _i3.MultiAddress mintTo,
    _i6.MintWitness? witnessData,
  }) {
    return Mint(
      collection: collection,
      item: item,
      mintTo: mintTo,
      witnessData: witnessData,
    );
  }

  ForceMint forceMint({
    required int collection,
    required int item,
    required _i3.MultiAddress mintTo,
    required _i7.ItemConfig itemConfig,
  }) {
    return ForceMint(
      collection: collection,
      item: item,
      mintTo: mintTo,
      itemConfig: itemConfig,
    );
  }

  Burn burn({
    required int collection,
    required int item,
  }) {
    return Burn(
      collection: collection,
      item: item,
    );
  }

  Transfer transfer({
    required int collection,
    required int item,
    required _i3.MultiAddress dest,
  }) {
    return Transfer(
      collection: collection,
      item: item,
      dest: dest,
    );
  }

  Redeposit redeposit({
    required int collection,
    required List<int> items,
  }) {
    return Redeposit(
      collection: collection,
      items: items,
    );
  }

  LockItemTransfer lockItemTransfer({
    required int collection,
    required int item,
  }) {
    return LockItemTransfer(
      collection: collection,
      item: item,
    );
  }

  UnlockItemTransfer unlockItemTransfer({
    required int collection,
    required int item,
  }) {
    return UnlockItemTransfer(
      collection: collection,
      item: item,
    );
  }

  LockCollection lockCollection({
    required int collection,
    required _i8.BitFlags lockSettings,
  }) {
    return LockCollection(
      collection: collection,
      lockSettings: lockSettings,
    );
  }

  TransferOwnership transferOwnership({
    required int collection,
    required _i3.MultiAddress newOwner,
  }) {
    return TransferOwnership(
      collection: collection,
      newOwner: newOwner,
    );
  }

  SetTeam setTeam({
    required int collection,
    _i3.MultiAddress? issuer,
    _i3.MultiAddress? admin,
    _i3.MultiAddress? freezer,
  }) {
    return SetTeam(
      collection: collection,
      issuer: issuer,
      admin: admin,
      freezer: freezer,
    );
  }

  ForceCollectionOwner forceCollectionOwner({
    required int collection,
    required _i3.MultiAddress owner,
  }) {
    return ForceCollectionOwner(
      collection: collection,
      owner: owner,
    );
  }

  ForceCollectionConfig forceCollectionConfig({
    required int collection,
    required _i4.CollectionConfig config,
  }) {
    return ForceCollectionConfig(
      collection: collection,
      config: config,
    );
  }

  ApproveTransfer approveTransfer({
    required int collection,
    required int item,
    required _i3.MultiAddress delegate,
    int? maybeDeadline,
  }) {
    return ApproveTransfer(
      collection: collection,
      item: item,
      delegate: delegate,
      maybeDeadline: maybeDeadline,
    );
  }

  CancelApproval cancelApproval({
    required int collection,
    required int item,
    required _i3.MultiAddress delegate,
  }) {
    return CancelApproval(
      collection: collection,
      item: item,
      delegate: delegate,
    );
  }

  ClearAllTransferApprovals clearAllTransferApprovals({
    required int collection,
    required int item,
  }) {
    return ClearAllTransferApprovals(
      collection: collection,
      item: item,
    );
  }

  LockItemProperties lockItemProperties({
    required int collection,
    required int item,
    required bool lockMetadata,
    required bool lockAttributes,
  }) {
    return LockItemProperties(
      collection: collection,
      item: item,
      lockMetadata: lockMetadata,
      lockAttributes: lockAttributes,
    );
  }

  SetAttribute setAttribute({
    required int collection,
    int? maybeItem,
    required _i9.AttributeNamespace namespace,
    required List<int> key,
    required List<int> value,
  }) {
    return SetAttribute(
      collection: collection,
      maybeItem: maybeItem,
      namespace: namespace,
      key: key,
      value: value,
    );
  }

  ForceSetAttribute forceSetAttribute({
    _i10.AccountId32? setAs,
    required int collection,
    int? maybeItem,
    required _i9.AttributeNamespace namespace,
    required List<int> key,
    required List<int> value,
  }) {
    return ForceSetAttribute(
      setAs: setAs,
      collection: collection,
      maybeItem: maybeItem,
      namespace: namespace,
      key: key,
      value: value,
    );
  }

  ClearAttribute clearAttribute({
    required int collection,
    int? maybeItem,
    required _i9.AttributeNamespace namespace,
    required List<int> key,
  }) {
    return ClearAttribute(
      collection: collection,
      maybeItem: maybeItem,
      namespace: namespace,
      key: key,
    );
  }

  ApproveItemAttributes approveItemAttributes({
    required int collection,
    required int item,
    required _i3.MultiAddress delegate,
  }) {
    return ApproveItemAttributes(
      collection: collection,
      item: item,
      delegate: delegate,
    );
  }

  CancelItemAttributesApproval cancelItemAttributesApproval({
    required int collection,
    required int item,
    required _i3.MultiAddress delegate,
    required _i11.CancelAttributesApprovalWitness witness,
  }) {
    return CancelItemAttributesApproval(
      collection: collection,
      item: item,
      delegate: delegate,
      witness: witness,
    );
  }

  SetMetadata setMetadata({
    required int collection,
    required int item,
    required List<int> data,
  }) {
    return SetMetadata(
      collection: collection,
      item: item,
      data: data,
    );
  }

  ClearMetadata clearMetadata({
    required int collection,
    required int item,
  }) {
    return ClearMetadata(
      collection: collection,
      item: item,
    );
  }

  SetCollectionMetadata setCollectionMetadata({
    required int collection,
    required List<int> data,
  }) {
    return SetCollectionMetadata(
      collection: collection,
      data: data,
    );
  }

  ClearCollectionMetadata clearCollectionMetadata({required int collection}) {
    return ClearCollectionMetadata(collection: collection);
  }

  SetAcceptOwnership setAcceptOwnership({int? maybeCollection}) {
    return SetAcceptOwnership(maybeCollection: maybeCollection);
  }

  SetCollectionMaxSupply setCollectionMaxSupply({
    required int collection,
    required int maxSupply,
  }) {
    return SetCollectionMaxSupply(
      collection: collection,
      maxSupply: maxSupply,
    );
  }

  UpdateMintSettings updateMintSettings({
    required int collection,
    required _i12.MintSettings mintSettings,
  }) {
    return UpdateMintSettings(
      collection: collection,
      mintSettings: mintSettings,
    );
  }

  SetPrice setPrice({
    required int collection,
    required int item,
    BigInt? price,
    _i3.MultiAddress? whitelistedBuyer,
  }) {
    return SetPrice(
      collection: collection,
      item: item,
      price: price,
      whitelistedBuyer: whitelistedBuyer,
    );
  }

  BuyItem buyItem({
    required int collection,
    required int item,
    required BigInt bidPrice,
  }) {
    return BuyItem(
      collection: collection,
      item: item,
      bidPrice: bidPrice,
    );
  }

  PayTips payTips({required List<_i13.ItemTip> tips}) {
    return PayTips(tips: tips);
  }

  CreateSwap createSwap({
    required int offeredCollection,
    required int offeredItem,
    required int desiredCollection,
    int? maybeDesiredItem,
    _i14.PriceWithDirection? maybePrice,
    required int duration,
  }) {
    return CreateSwap(
      offeredCollection: offeredCollection,
      offeredItem: offeredItem,
      desiredCollection: desiredCollection,
      maybeDesiredItem: maybeDesiredItem,
      maybePrice: maybePrice,
      duration: duration,
    );
  }

  CancelSwap cancelSwap({
    required int offeredCollection,
    required int offeredItem,
  }) {
    return CancelSwap(
      offeredCollection: offeredCollection,
      offeredItem: offeredItem,
    );
  }

  ClaimSwap claimSwap({
    required int sendCollection,
    required int sendItem,
    required int receiveCollection,
    required int receiveItem,
    _i14.PriceWithDirection? witnessPrice,
  }) {
    return ClaimSwap(
      sendCollection: sendCollection,
      sendItem: sendItem,
      receiveCollection: receiveCollection,
      receiveItem: receiveItem,
      witnessPrice: witnessPrice,
    );
  }

  MintPreSigned mintPreSigned({
    required _i15.PreSignedMint mintData,
    required _i16.MultiSignature signature,
    required _i10.AccountId32 signer,
  }) {
    return MintPreSigned(
      mintData: mintData,
      signature: signature,
      signer: signer,
    );
  }

  SetAttributesPreSigned setAttributesPreSigned({
    required _i17.PreSignedAttributes data,
    required _i16.MultiSignature signature,
    required _i10.AccountId32 signer,
  }) {
    return SetAttributesPreSigned(
      data: data,
      signature: signature,
      signer: signer,
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
        return Destroy._decode(input);
      case 3:
        return Mint._decode(input);
      case 4:
        return ForceMint._decode(input);
      case 5:
        return Burn._decode(input);
      case 6:
        return Transfer._decode(input);
      case 7:
        return Redeposit._decode(input);
      case 8:
        return LockItemTransfer._decode(input);
      case 9:
        return UnlockItemTransfer._decode(input);
      case 10:
        return LockCollection._decode(input);
      case 11:
        return TransferOwnership._decode(input);
      case 12:
        return SetTeam._decode(input);
      case 13:
        return ForceCollectionOwner._decode(input);
      case 14:
        return ForceCollectionConfig._decode(input);
      case 15:
        return ApproveTransfer._decode(input);
      case 16:
        return CancelApproval._decode(input);
      case 17:
        return ClearAllTransferApprovals._decode(input);
      case 18:
        return LockItemProperties._decode(input);
      case 19:
        return SetAttribute._decode(input);
      case 20:
        return ForceSetAttribute._decode(input);
      case 21:
        return ClearAttribute._decode(input);
      case 22:
        return ApproveItemAttributes._decode(input);
      case 23:
        return CancelItemAttributesApproval._decode(input);
      case 24:
        return SetMetadata._decode(input);
      case 25:
        return ClearMetadata._decode(input);
      case 26:
        return SetCollectionMetadata._decode(input);
      case 27:
        return ClearCollectionMetadata._decode(input);
      case 28:
        return SetAcceptOwnership._decode(input);
      case 29:
        return SetCollectionMaxSupply._decode(input);
      case 30:
        return UpdateMintSettings._decode(input);
      case 31:
        return SetPrice._decode(input);
      case 32:
        return BuyItem._decode(input);
      case 33:
        return PayTips._decode(input);
      case 34:
        return CreateSwap._decode(input);
      case 35:
        return CancelSwap._decode(input);
      case 36:
        return ClaimSwap._decode(input);
      case 37:
        return MintPreSigned._decode(input);
      case 38:
        return SetAttributesPreSigned._decode(input);
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
      case Destroy:
        (value as Destroy).encodeTo(output);
        break;
      case Mint:
        (value as Mint).encodeTo(output);
        break;
      case ForceMint:
        (value as ForceMint).encodeTo(output);
        break;
      case Burn:
        (value as Burn).encodeTo(output);
        break;
      case Transfer:
        (value as Transfer).encodeTo(output);
        break;
      case Redeposit:
        (value as Redeposit).encodeTo(output);
        break;
      case LockItemTransfer:
        (value as LockItemTransfer).encodeTo(output);
        break;
      case UnlockItemTransfer:
        (value as UnlockItemTransfer).encodeTo(output);
        break;
      case LockCollection:
        (value as LockCollection).encodeTo(output);
        break;
      case TransferOwnership:
        (value as TransferOwnership).encodeTo(output);
        break;
      case SetTeam:
        (value as SetTeam).encodeTo(output);
        break;
      case ForceCollectionOwner:
        (value as ForceCollectionOwner).encodeTo(output);
        break;
      case ForceCollectionConfig:
        (value as ForceCollectionConfig).encodeTo(output);
        break;
      case ApproveTransfer:
        (value as ApproveTransfer).encodeTo(output);
        break;
      case CancelApproval:
        (value as CancelApproval).encodeTo(output);
        break;
      case ClearAllTransferApprovals:
        (value as ClearAllTransferApprovals).encodeTo(output);
        break;
      case LockItemProperties:
        (value as LockItemProperties).encodeTo(output);
        break;
      case SetAttribute:
        (value as SetAttribute).encodeTo(output);
        break;
      case ForceSetAttribute:
        (value as ForceSetAttribute).encodeTo(output);
        break;
      case ClearAttribute:
        (value as ClearAttribute).encodeTo(output);
        break;
      case ApproveItemAttributes:
        (value as ApproveItemAttributes).encodeTo(output);
        break;
      case CancelItemAttributesApproval:
        (value as CancelItemAttributesApproval).encodeTo(output);
        break;
      case SetMetadata:
        (value as SetMetadata).encodeTo(output);
        break;
      case ClearMetadata:
        (value as ClearMetadata).encodeTo(output);
        break;
      case SetCollectionMetadata:
        (value as SetCollectionMetadata).encodeTo(output);
        break;
      case ClearCollectionMetadata:
        (value as ClearCollectionMetadata).encodeTo(output);
        break;
      case SetAcceptOwnership:
        (value as SetAcceptOwnership).encodeTo(output);
        break;
      case SetCollectionMaxSupply:
        (value as SetCollectionMaxSupply).encodeTo(output);
        break;
      case UpdateMintSettings:
        (value as UpdateMintSettings).encodeTo(output);
        break;
      case SetPrice:
        (value as SetPrice).encodeTo(output);
        break;
      case BuyItem:
        (value as BuyItem).encodeTo(output);
        break;
      case PayTips:
        (value as PayTips).encodeTo(output);
        break;
      case CreateSwap:
        (value as CreateSwap).encodeTo(output);
        break;
      case CancelSwap:
        (value as CancelSwap).encodeTo(output);
        break;
      case ClaimSwap:
        (value as ClaimSwap).encodeTo(output);
        break;
      case MintPreSigned:
        (value as MintPreSigned).encodeTo(output);
        break;
      case SetAttributesPreSigned:
        (value as SetAttributesPreSigned).encodeTo(output);
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
      case Destroy:
        return (value as Destroy)._sizeHint();
      case Mint:
        return (value as Mint)._sizeHint();
      case ForceMint:
        return (value as ForceMint)._sizeHint();
      case Burn:
        return (value as Burn)._sizeHint();
      case Transfer:
        return (value as Transfer)._sizeHint();
      case Redeposit:
        return (value as Redeposit)._sizeHint();
      case LockItemTransfer:
        return (value as LockItemTransfer)._sizeHint();
      case UnlockItemTransfer:
        return (value as UnlockItemTransfer)._sizeHint();
      case LockCollection:
        return (value as LockCollection)._sizeHint();
      case TransferOwnership:
        return (value as TransferOwnership)._sizeHint();
      case SetTeam:
        return (value as SetTeam)._sizeHint();
      case ForceCollectionOwner:
        return (value as ForceCollectionOwner)._sizeHint();
      case ForceCollectionConfig:
        return (value as ForceCollectionConfig)._sizeHint();
      case ApproveTransfer:
        return (value as ApproveTransfer)._sizeHint();
      case CancelApproval:
        return (value as CancelApproval)._sizeHint();
      case ClearAllTransferApprovals:
        return (value as ClearAllTransferApprovals)._sizeHint();
      case LockItemProperties:
        return (value as LockItemProperties)._sizeHint();
      case SetAttribute:
        return (value as SetAttribute)._sizeHint();
      case ForceSetAttribute:
        return (value as ForceSetAttribute)._sizeHint();
      case ClearAttribute:
        return (value as ClearAttribute)._sizeHint();
      case ApproveItemAttributes:
        return (value as ApproveItemAttributes)._sizeHint();
      case CancelItemAttributesApproval:
        return (value as CancelItemAttributesApproval)._sizeHint();
      case SetMetadata:
        return (value as SetMetadata)._sizeHint();
      case ClearMetadata:
        return (value as ClearMetadata)._sizeHint();
      case SetCollectionMetadata:
        return (value as SetCollectionMetadata)._sizeHint();
      case ClearCollectionMetadata:
        return (value as ClearCollectionMetadata)._sizeHint();
      case SetAcceptOwnership:
        return (value as SetAcceptOwnership)._sizeHint();
      case SetCollectionMaxSupply:
        return (value as SetCollectionMaxSupply)._sizeHint();
      case UpdateMintSettings:
        return (value as UpdateMintSettings)._sizeHint();
      case SetPrice:
        return (value as SetPrice)._sizeHint();
      case BuyItem:
        return (value as BuyItem)._sizeHint();
      case PayTips:
        return (value as PayTips)._sizeHint();
      case CreateSwap:
        return (value as CreateSwap)._sizeHint();
      case CancelSwap:
        return (value as CancelSwap)._sizeHint();
      case ClaimSwap:
        return (value as ClaimSwap)._sizeHint();
      case MintPreSigned:
        return (value as MintPreSigned)._sizeHint();
      case SetAttributesPreSigned:
        return (value as SetAttributesPreSigned)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Issue a new collection of non-fungible items from a public origin.
///
/// This new collection has no items initially and its owner is the origin.
///
/// The origin must be Signed and the sender must have sufficient funds free.
///
/// `CollectionDeposit` funds of sender are reserved.
///
/// Parameters:
/// - `admin`: The admin of this collection. The admin is the initial address of each
/// member of the collection's admin team.
///
/// Emits `Created` event when successful.
///
/// Weight: `O(1)`
class Create extends Call {
  const Create({
    required this.admin,
    required this.config,
  });

  factory Create._decode(_i1.Input input) {
    return Create(
      admin: _i3.MultiAddress.codec.decode(input),
      config: _i4.CollectionConfig.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress admin;

  /// CollectionConfigFor<T, I>
  final _i4.CollectionConfig config;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'create': {
          'admin': admin.toJson(),
          'config': config.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(admin);
    size = size + _i4.CollectionConfig.codec.sizeHint(config);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      admin,
      output,
    );
    _i4.CollectionConfig.codec.encodeTo(
      config,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Create && other.admin == admin && other.config == config;

  @override
  int get hashCode => Object.hash(
        admin,
        config,
      );
}

/// Issue a new collection of non-fungible items from a privileged origin.
///
/// This new collection has no items initially.
///
/// The origin must conform to `ForceOrigin`.
///
/// Unlike `create`, no funds are reserved.
///
/// - `owner`: The owner of this collection of items. The owner has full superuser
///  permissions over this item, but may later change and configure the permissions using
///  `transfer_ownership` and `set_team`.
///
/// Emits `ForceCreated` event when successful.
///
/// Weight: `O(1)`
class ForceCreate extends Call {
  const ForceCreate({
    required this.owner,
    required this.config,
  });

  factory ForceCreate._decode(_i1.Input input) {
    return ForceCreate(
      owner: _i3.MultiAddress.codec.decode(input),
      config: _i4.CollectionConfig.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress owner;

  /// CollectionConfigFor<T, I>
  final _i4.CollectionConfig config;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'force_create': {
          'owner': owner.toJson(),
          'config': config.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(owner);
    size = size + _i4.CollectionConfig.codec.sizeHint(config);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      owner,
      output,
    );
    _i4.CollectionConfig.codec.encodeTo(
      config,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCreate && other.owner == owner && other.config == config;

  @override
  int get hashCode => Object.hash(
        owner,
        config,
      );
}

/// Destroy a collection of fungible items.
///
/// The origin must conform to `ForceOrigin` or must be `Signed` and the sender must be the
/// owner of the `collection`.
///
/// NOTE: The collection must have 0 items to be destroyed.
///
/// - `collection`: The identifier of the collection to be destroyed.
/// - `witness`: Information on the items minted in the collection. This must be
/// correct.
///
/// Emits `Destroyed` event when successful.
///
/// Weight: `O(m + c + a)` where:
/// - `m = witness.item_metadatas`
/// - `c = witness.item_configs`
/// - `a = witness.attributes`
class Destroy extends Call {
  const Destroy({
    required this.collection,
    required this.witness,
  });

  factory Destroy._decode(_i1.Input input) {
    return Destroy(
      collection: _i1.U32Codec.codec.decode(input),
      witness: _i5.DestroyWitness.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// DestroyWitness
  final _i5.DestroyWitness witness;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'destroy': {
          'collection': collection,
          'witness': witness.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i5.DestroyWitness.codec.sizeHint(witness);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i5.DestroyWitness.codec.encodeTo(
      witness,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Destroy && other.collection == collection && other.witness == witness;

  @override
  int get hashCode => Object.hash(
        collection,
        witness,
      );
}

/// Mint an item of a particular collection.
///
/// The origin must be Signed and the sender must comply with the `mint_settings` rules.
///
/// - `collection`: The collection of the item to be minted.
/// - `item`: An identifier of the new item.
/// - `mint_to`: Account into which the item will be minted.
/// - `witness_data`: When the mint type is `HolderOf(collection_id)`, then the owned
///  item_id from that collection needs to be provided within the witness data object. If
///  the mint price is set, then it should be additionally confirmed in the `witness_data`.
///
/// Note: the deposit will be taken from the `origin` and not the `owner` of the `item`.
///
/// Emits `Issued` event when successful.
///
/// Weight: `O(1)`
class Mint extends Call {
  const Mint({
    required this.collection,
    required this.item,
    required this.mintTo,
    this.witnessData,
  });

  factory Mint._decode(_i1.Input input) {
    return Mint(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      mintTo: _i3.MultiAddress.codec.decode(input),
      witnessData: const _i1.OptionCodec<_i6.MintWitness>(_i6.MintWitness.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress mintTo;

  /// Option<MintWitness<T::ItemId, DepositBalanceOf<T, I>>>
  final _i6.MintWitness? witnessData;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'mint': {
          'collection': collection,
          'item': item,
          'mintTo': mintTo.toJson(),
          'witnessData': witnessData?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(mintTo);
    size = size + const _i1.OptionCodec<_i6.MintWitness>(_i6.MintWitness.codec).sizeHint(witnessData);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      mintTo,
      output,
    );
    const _i1.OptionCodec<_i6.MintWitness>(_i6.MintWitness.codec).encodeTo(
      witnessData,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Mint &&
          other.collection == collection &&
          other.item == item &&
          other.mintTo == mintTo &&
          other.witnessData == witnessData;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        mintTo,
        witnessData,
      );
}

/// Mint an item of a particular collection from a privileged origin.
///
/// The origin must conform to `ForceOrigin` or must be `Signed` and the sender must be the
/// Issuer of the `collection`.
///
/// - `collection`: The collection of the item to be minted.
/// - `item`: An identifier of the new item.
/// - `mint_to`: Account into which the item will be minted.
/// - `item_config`: A config of the new item.
///
/// Emits `Issued` event when successful.
///
/// Weight: `O(1)`
class ForceMint extends Call {
  const ForceMint({
    required this.collection,
    required this.item,
    required this.mintTo,
    required this.itemConfig,
  });

  factory ForceMint._decode(_i1.Input input) {
    return ForceMint(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      mintTo: _i3.MultiAddress.codec.decode(input),
      itemConfig: _i7.ItemConfig.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress mintTo;

  /// ItemConfig
  final _i7.ItemConfig itemConfig;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_mint': {
          'collection': collection,
          'item': item,
          'mintTo': mintTo.toJson(),
          'itemConfig': itemConfig.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(mintTo);
    size = size + _i7.ItemConfig.codec.sizeHint(itemConfig);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      mintTo,
      output,
    );
    _i7.ItemConfig.codec.encodeTo(
      itemConfig,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceMint &&
          other.collection == collection &&
          other.item == item &&
          other.mintTo == mintTo &&
          other.itemConfig == itemConfig;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        mintTo,
        itemConfig,
      );
}

/// Destroy a single item.
///
/// The origin must conform to `ForceOrigin` or must be Signed and the signing account must
/// be the owner of the `item`.
///
/// - `collection`: The collection of the item to be burned.
/// - `item`: The item to be burned.
///
/// Emits `Burned`.
///
/// Weight: `O(1)`
class Burn extends Call {
  const Burn({
    required this.collection,
    required this.item,
  });

  factory Burn._decode(_i1.Input input) {
    return Burn(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'burn': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Burn && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Move an item from the sender account to another.
///
/// Origin must be Signed and the signing account must be either:
/// - the Owner of the `item`;
/// - the approved delegate for the `item` (in this case, the approval is reset).
///
/// Arguments:
/// - `collection`: The collection of the item to be transferred.
/// - `item`: The item to be transferred.
/// - `dest`: The account to receive ownership of the item.
///
/// Emits `Transferred`.
///
/// Weight: `O(1)`
class Transfer extends Call {
  const Transfer({
    required this.collection,
    required this.item,
    required this.dest,
  });

  factory Transfer._decode(_i1.Input input) {
    return Transfer(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      dest: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress dest;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer': {
          'collection': collection,
          'item': item,
          'dest': dest.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(dest);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      dest,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transfer && other.collection == collection && other.item == item && other.dest == dest;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        dest,
      );
}

/// Re-evaluate the deposits on some items.
///
/// Origin must be Signed and the sender should be the Owner of the `collection`.
///
/// - `collection`: The collection of the items to be reevaluated.
/// - `items`: The items of the collection whose deposits will be reevaluated.
///
/// NOTE: This exists as a best-effort function. Any items which are unknown or
/// in the case that the owner account does not have reservable funds to pay for a
/// deposit increase are ignored. Generally the owner isn't going to call this on items
/// whose existing deposit is less than the refreshed deposit as it would only cost them,
/// so it's of little consequence.
///
/// It will still return an error in the case that the collection is unknown or the signer
/// is not permitted to call it.
///
/// Weight: `O(items.len())`
class Redeposit extends Call {
  const Redeposit({
    required this.collection,
    required this.items,
  });

  factory Redeposit._decode(_i1.Input input) {
    return Redeposit(
      collection: _i1.U32Codec.codec.decode(input),
      items: _i1.U32SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Vec<T::ItemId>
  final List<int> items;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'redeposit': {
          'collection': collection,
          'items': items,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32SequenceCodec.codec.sizeHint(items);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32SequenceCodec.codec.encodeTo(
      items,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Redeposit &&
          other.collection == collection &&
          _i18.listsEqual(
            other.items,
            items,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        items,
      );
}

/// Disallow further unprivileged transfer of an item.
///
/// Origin must be Signed and the sender should be the Freezer of the `collection`.
///
/// - `collection`: The collection of the item to be changed.
/// - `item`: The item to become non-transferable.
///
/// Emits `ItemTransferLocked`.
///
/// Weight: `O(1)`
class LockItemTransfer extends Call {
  const LockItemTransfer({
    required this.collection,
    required this.item,
  });

  factory LockItemTransfer._decode(_i1.Input input) {
    return LockItemTransfer(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'lock_item_transfer': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LockItemTransfer && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Re-allow unprivileged transfer of an item.
///
/// Origin must be Signed and the sender should be the Freezer of the `collection`.
///
/// - `collection`: The collection of the item to be changed.
/// - `item`: The item to become transferable.
///
/// Emits `ItemTransferUnlocked`.
///
/// Weight: `O(1)`
class UnlockItemTransfer extends Call {
  const UnlockItemTransfer({
    required this.collection,
    required this.item,
  });

  factory UnlockItemTransfer._decode(_i1.Input input) {
    return UnlockItemTransfer(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'unlock_item_transfer': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnlockItemTransfer && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Disallows specified settings for the whole collection.
///
/// Origin must be Signed and the sender should be the Owner of the `collection`.
///
/// - `collection`: The collection to be locked.
/// - `lock_settings`: The settings to be locked.
///
/// Note: it's possible to only lock(set) the setting, but not to unset it.
///
/// Emits `CollectionLocked`.
///
/// Weight: `O(1)`
class LockCollection extends Call {
  const LockCollection({
    required this.collection,
    required this.lockSettings,
  });

  factory LockCollection._decode(_i1.Input input) {
    return LockCollection(
      collection: _i1.U32Codec.codec.decode(input),
      lockSettings: _i1.U64Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// CollectionSettings
  final _i8.BitFlags lockSettings;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'lock_collection': {
          'collection': collection,
          'lockSettings': lockSettings,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i8.BitFlagsCodec().sizeHint(lockSettings);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      lockSettings,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LockCollection && other.collection == collection && other.lockSettings == lockSettings;

  @override
  int get hashCode => Object.hash(
        collection,
        lockSettings,
      );
}

/// Change the Owner of a collection.
///
/// Origin must be Signed and the sender should be the Owner of the `collection`.
///
/// - `collection`: The collection whose owner should be changed.
/// - `owner`: The new Owner of this collection. They must have called
///  `set_accept_ownership` with `collection` in order for this operation to succeed.
///
/// Emits `OwnerChanged`.
///
/// Weight: `O(1)`
class TransferOwnership extends Call {
  const TransferOwnership({
    required this.collection,
    required this.newOwner,
  });

  factory TransferOwnership._decode(_i1.Input input) {
    return TransferOwnership(
      collection: _i1.U32Codec.codec.decode(input),
      newOwner: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress newOwner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer_ownership': {
          'collection': collection,
          'newOwner': newOwner.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i3.MultiAddress.codec.sizeHint(newOwner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      newOwner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferOwnership && other.collection == collection && other.newOwner == newOwner;

  @override
  int get hashCode => Object.hash(
        collection,
        newOwner,
      );
}

/// Change the Issuer, Admin and Freezer of a collection.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
/// `collection`.
///
/// Note: by setting the role to `None` only the `ForceOrigin` will be able to change it
/// after to `Some(account)`.
///
/// - `collection`: The collection whose team should be changed.
/// - `issuer`: The new Issuer of this collection.
/// - `admin`: The new Admin of this collection.
/// - `freezer`: The new Freezer of this collection.
///
/// Emits `TeamChanged`.
///
/// Weight: `O(1)`
class SetTeam extends Call {
  const SetTeam({
    required this.collection,
    this.issuer,
    this.admin,
    this.freezer,
  });

  factory SetTeam._decode(_i1.Input input) {
    return SetTeam(
      collection: _i1.U32Codec.codec.decode(input),
      issuer: const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).decode(input),
      admin: const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).decode(input),
      freezer: const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<AccountIdLookupOf<T>>
  final _i3.MultiAddress? issuer;

  /// Option<AccountIdLookupOf<T>>
  final _i3.MultiAddress? admin;

  /// Option<AccountIdLookupOf<T>>
  final _i3.MultiAddress? freezer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_team': {
          'collection': collection,
          'issuer': issuer?.toJson(),
          'admin': admin?.toJson(),
          'freezer': freezer?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).sizeHint(issuer);
    size = size + const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).sizeHint(admin);
    size = size + const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).sizeHint(freezer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).encodeTo(
      issuer,
      output,
    );
    const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).encodeTo(
      admin,
      output,
    );
    const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).encodeTo(
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
      other is SetTeam &&
          other.collection == collection &&
          other.issuer == issuer &&
          other.admin == admin &&
          other.freezer == freezer;

  @override
  int get hashCode => Object.hash(
        collection,
        issuer,
        admin,
        freezer,
      );
}

/// Change the Owner of a collection.
///
/// Origin must be `ForceOrigin`.
///
/// - `collection`: The identifier of the collection.
/// - `owner`: The new Owner of this collection.
///
/// Emits `OwnerChanged`.
///
/// Weight: `O(1)`
class ForceCollectionOwner extends Call {
  const ForceCollectionOwner({
    required this.collection,
    required this.owner,
  });

  factory ForceCollectionOwner._decode(_i1.Input input) {
    return ForceCollectionOwner(
      collection: _i1.U32Codec.codec.decode(input),
      owner: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress owner;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_collection_owner': {
          'collection': collection,
          'owner': owner.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i3.MultiAddress.codec.sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
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
      other is ForceCollectionOwner && other.collection == collection && other.owner == owner;

  @override
  int get hashCode => Object.hash(
        collection,
        owner,
      );
}

/// Change the config of a collection.
///
/// Origin must be `ForceOrigin`.
///
/// - `collection`: The identifier of the collection.
/// - `config`: The new config of this collection.
///
/// Emits `CollectionConfigChanged`.
///
/// Weight: `O(1)`
class ForceCollectionConfig extends Call {
  const ForceCollectionConfig({
    required this.collection,
    required this.config,
  });

  factory ForceCollectionConfig._decode(_i1.Input input) {
    return ForceCollectionConfig(
      collection: _i1.U32Codec.codec.decode(input),
      config: _i4.CollectionConfig.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// CollectionConfigFor<T, I>
  final _i4.CollectionConfig config;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_collection_config': {
          'collection': collection,
          'config': config.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i4.CollectionConfig.codec.sizeHint(config);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i4.CollectionConfig.codec.encodeTo(
      config,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCollectionConfig && other.collection == collection && other.config == config;

  @override
  int get hashCode => Object.hash(
        collection,
        config,
      );
}

/// Approve an item to be transferred by a delegated third-party account.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
/// `item`.
///
/// - `collection`: The collection of the item to be approved for delegated transfer.
/// - `item`: The item to be approved for delegated transfer.
/// - `delegate`: The account to delegate permission to transfer the item.
/// - `maybe_deadline`: Optional deadline for the approval. Specified by providing the
/// 	number of blocks after which the approval will expire
///
/// Emits `TransferApproved` on success.
///
/// Weight: `O(1)`
class ApproveTransfer extends Call {
  const ApproveTransfer({
    required this.collection,
    required this.item,
    required this.delegate,
    this.maybeDeadline,
  });

  factory ApproveTransfer._decode(_i1.Input input) {
    return ApproveTransfer(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      delegate: _i3.MultiAddress.codec.decode(input),
      maybeDeadline: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  /// Option<BlockNumberFor<T, I>>
  final int? maybeDeadline;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'approve_transfer': {
          'collection': collection,
          'item': item,
          'delegate': delegate.toJson(),
          'maybeDeadline': maybeDeadline,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeDeadline);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeDeadline,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApproveTransfer &&
          other.collection == collection &&
          other.item == item &&
          other.delegate == delegate &&
          other.maybeDeadline == maybeDeadline;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        delegate,
        maybeDeadline,
      );
}

/// Cancel one of the transfer approvals for a specific item.
///
/// Origin must be either:
/// - the `Force` origin;
/// - `Signed` with the signer being the Owner of the `item`;
///
/// Arguments:
/// - `collection`: The collection of the item of whose approval will be cancelled.
/// - `item`: The item of the collection of whose approval will be cancelled.
/// - `delegate`: The account that is going to loose their approval.
///
/// Emits `ApprovalCancelled` on success.
///
/// Weight: `O(1)`
class CancelApproval extends Call {
  const CancelApproval({
    required this.collection,
    required this.item,
    required this.delegate,
  });

  factory CancelApproval._decode(_i1.Input input) {
    return CancelApproval(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      delegate: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'cancel_approval': {
          'collection': collection,
          'item': item,
          'delegate': delegate.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
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
      other is CancelApproval && other.collection == collection && other.item == item && other.delegate == delegate;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        delegate,
      );
}

/// Cancel all the approvals of a specific item.
///
/// Origin must be either:
/// - the `Force` origin;
/// - `Signed` with the signer being the Owner of the `item`;
///
/// Arguments:
/// - `collection`: The collection of the item of whose approvals will be cleared.
/// - `item`: The item of the collection of whose approvals will be cleared.
///
/// Emits `AllApprovalsCancelled` on success.
///
/// Weight: `O(1)`
class ClearAllTransferApprovals extends Call {
  const ClearAllTransferApprovals({
    required this.collection,
    required this.item,
  });

  factory ClearAllTransferApprovals._decode(_i1.Input input) {
    return ClearAllTransferApprovals(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'clear_all_transfer_approvals': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearAllTransferApprovals && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Disallows changing the metadata or attributes of the item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Admin
/// of the `collection`.
///
/// - `collection`: The collection if the `item`.
/// - `item`: An item to be locked.
/// - `lock_metadata`: Specifies whether the metadata should be locked.
/// - `lock_attributes`: Specifies whether the attributes in the `CollectionOwner` namespace
///  should be locked.
///
/// Note: `lock_attributes` affects the attributes in the `CollectionOwner` namespace only.
/// When the metadata or attributes are locked, it won't be possible the unlock them.
///
/// Emits `ItemPropertiesLocked`.
///
/// Weight: `O(1)`
class LockItemProperties extends Call {
  const LockItemProperties({
    required this.collection,
    required this.item,
    required this.lockMetadata,
    required this.lockAttributes,
  });

  factory LockItemProperties._decode(_i1.Input input) {
    return LockItemProperties(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      lockMetadata: _i1.BoolCodec.codec.decode(input),
      lockAttributes: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// bool
  final bool lockMetadata;

  /// bool
  final bool lockAttributes;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'lock_item_properties': {
          'collection': collection,
          'item': item,
          'lockMetadata': lockMetadata,
          'lockAttributes': lockAttributes,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.BoolCodec.codec.sizeHint(lockMetadata);
    size = size + _i1.BoolCodec.codec.sizeHint(lockAttributes);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      lockMetadata,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      lockAttributes,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LockItemProperties &&
          other.collection == collection &&
          other.item == item &&
          other.lockMetadata == lockMetadata &&
          other.lockAttributes == lockAttributes;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        lockMetadata,
        lockAttributes,
      );
}

/// Set an attribute for a collection or item.
///
/// Origin must be Signed and must conform to the namespace ruleset:
/// - `CollectionOwner` namespace could be modified by the `collection` Admin only;
/// - `ItemOwner` namespace could be modified by the `maybe_item` owner only. `maybe_item`
///  should be set in that case;
/// - `Account(AccountId)` namespace could be modified only when the `origin` was given a
///  permission to do so;
///
/// The funds of `origin` are reserved according to the formula:
/// `AttributeDepositBase + DepositPerByte * (key.len + value.len)` taking into
/// account any already reserved funds.
///
/// - `collection`: The identifier of the collection whose item's metadata to set.
/// - `maybe_item`: The identifier of the item whose metadata to set.
/// - `namespace`: Attribute's namespace.
/// - `key`: The key of the attribute.
/// - `value`: The value to which to set the attribute.
///
/// Emits `AttributeSet`.
///
/// Weight: `O(1)`
class SetAttribute extends Call {
  const SetAttribute({
    required this.collection,
    this.maybeItem,
    required this.namespace,
    required this.key,
    required this.value,
  });

  factory SetAttribute._decode(_i1.Input input) {
    return SetAttribute(
      collection: _i1.U32Codec.codec.decode(input),
      maybeItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      namespace: _i9.AttributeNamespace.codec.decode(input),
      key: _i1.U8SequenceCodec.codec.decode(input),
      value: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<T::ItemId>
  final int? maybeItem;

  /// AttributeNamespace<T::AccountId>
  final _i9.AttributeNamespace namespace;

  /// BoundedVec<u8, T::KeyLimit>
  final List<int> key;

  /// BoundedVec<u8, T::ValueLimit>
  final List<int> value;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_attribute': {
          'collection': collection,
          'maybeItem': maybeItem,
          'namespace': namespace.toJson(),
          'key': key,
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeItem);
    size = size + _i9.AttributeNamespace.codec.sizeHint(namespace);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(key);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeItem,
      output,
    );
    _i9.AttributeNamespace.codec.encodeTo(
      namespace,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      key,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetAttribute &&
          other.collection == collection &&
          other.maybeItem == maybeItem &&
          other.namespace == namespace &&
          _i18.listsEqual(
            other.key,
            key,
          ) &&
          _i18.listsEqual(
            other.value,
            value,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        maybeItem,
        namespace,
        key,
        value,
      );
}

/// Force-set an attribute for a collection or item.
///
/// Origin must be `ForceOrigin`.
///
/// If the attribute already exists and it was set by another account, the deposit
/// will be returned to the previous owner.
///
/// - `set_as`: An optional owner of the attribute.
/// - `collection`: The identifier of the collection whose item's metadata to set.
/// - `maybe_item`: The identifier of the item whose metadata to set.
/// - `namespace`: Attribute's namespace.
/// - `key`: The key of the attribute.
/// - `value`: The value to which to set the attribute.
///
/// Emits `AttributeSet`.
///
/// Weight: `O(1)`
class ForceSetAttribute extends Call {
  const ForceSetAttribute({
    this.setAs,
    required this.collection,
    this.maybeItem,
    required this.namespace,
    required this.key,
    required this.value,
  });

  factory ForceSetAttribute._decode(_i1.Input input) {
    return ForceSetAttribute(
      setAs: const _i1.OptionCodec<_i10.AccountId32>(_i10.AccountId32Codec()).decode(input),
      collection: _i1.U32Codec.codec.decode(input),
      maybeItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      namespace: _i9.AttributeNamespace.codec.decode(input),
      key: _i1.U8SequenceCodec.codec.decode(input),
      value: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// Option<T::AccountId>
  final _i10.AccountId32? setAs;

  /// T::CollectionId
  final int collection;

  /// Option<T::ItemId>
  final int? maybeItem;

  /// AttributeNamespace<T::AccountId>
  final _i9.AttributeNamespace namespace;

  /// BoundedVec<u8, T::KeyLimit>
  final List<int> key;

  /// BoundedVec<u8, T::ValueLimit>
  final List<int> value;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_set_attribute': {
          'setAs': setAs?.toList(),
          'collection': collection,
          'maybeItem': maybeItem,
          'namespace': namespace.toJson(),
          'key': key,
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<_i10.AccountId32>(_i10.AccountId32Codec()).sizeHint(setAs);
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeItem);
    size = size + _i9.AttributeNamespace.codec.sizeHint(namespace);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(key);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    const _i1.OptionCodec<_i10.AccountId32>(_i10.AccountId32Codec()).encodeTo(
      setAs,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeItem,
      output,
    );
    _i9.AttributeNamespace.codec.encodeTo(
      namespace,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      key,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceSetAttribute &&
          other.setAs == setAs &&
          other.collection == collection &&
          other.maybeItem == maybeItem &&
          other.namespace == namespace &&
          _i18.listsEqual(
            other.key,
            key,
          ) &&
          _i18.listsEqual(
            other.value,
            value,
          );

  @override
  int get hashCode => Object.hash(
        setAs,
        collection,
        maybeItem,
        namespace,
        key,
        value,
      );
}

/// Clear an attribute for a collection or item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Owner of the
/// attribute.
///
/// Any deposit is freed for the collection's owner.
///
/// - `collection`: The identifier of the collection whose item's metadata to clear.
/// - `maybe_item`: The identifier of the item whose metadata to clear.
/// - `namespace`: Attribute's namespace.
/// - `key`: The key of the attribute.
///
/// Emits `AttributeCleared`.
///
/// Weight: `O(1)`
class ClearAttribute extends Call {
  const ClearAttribute({
    required this.collection,
    this.maybeItem,
    required this.namespace,
    required this.key,
  });

  factory ClearAttribute._decode(_i1.Input input) {
    return ClearAttribute(
      collection: _i1.U32Codec.codec.decode(input),
      maybeItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      namespace: _i9.AttributeNamespace.codec.decode(input),
      key: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// Option<T::ItemId>
  final int? maybeItem;

  /// AttributeNamespace<T::AccountId>
  final _i9.AttributeNamespace namespace;

  /// BoundedVec<u8, T::KeyLimit>
  final List<int> key;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'clear_attribute': {
          'collection': collection,
          'maybeItem': maybeItem,
          'namespace': namespace.toJson(),
          'key': key,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeItem);
    size = size + _i9.AttributeNamespace.codec.sizeHint(namespace);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(key);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeItem,
      output,
    );
    _i9.AttributeNamespace.codec.encodeTo(
      namespace,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      key,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearAttribute &&
          other.collection == collection &&
          other.maybeItem == maybeItem &&
          other.namespace == namespace &&
          _i18.listsEqual(
            other.key,
            key,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        maybeItem,
        namespace,
        key,
      );
}

/// Approve item's attributes to be changed by a delegated third-party account.
///
/// Origin must be Signed and must be an owner of the `item`.
///
/// - `collection`: A collection of the item.
/// - `item`: The item that holds attributes.
/// - `delegate`: The account to delegate permission to change attributes of the item.
///
/// Emits `ItemAttributesApprovalAdded` on success.
class ApproveItemAttributes extends Call {
  const ApproveItemAttributes({
    required this.collection,
    required this.item,
    required this.delegate,
  });

  factory ApproveItemAttributes._decode(_i1.Input input) {
    return ApproveItemAttributes(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      delegate: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'approve_item_attributes': {
          'collection': collection,
          'item': item,
          'delegate': delegate.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
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
      other is ApproveItemAttributes &&
          other.collection == collection &&
          other.item == item &&
          other.delegate == delegate;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        delegate,
      );
}

/// Cancel the previously provided approval to change item's attributes.
/// All the previously set attributes by the `delegate` will be removed.
///
/// Origin must be Signed and must be an owner of the `item`.
///
/// - `collection`: Collection that the item is contained within.
/// - `item`: The item that holds attributes.
/// - `delegate`: The previously approved account to remove.
///
/// Emits `ItemAttributesApprovalRemoved` on success.
class CancelItemAttributesApproval extends Call {
  const CancelItemAttributesApproval({
    required this.collection,
    required this.item,
    required this.delegate,
    required this.witness,
  });

  factory CancelItemAttributesApproval._decode(_i1.Input input) {
    return CancelItemAttributesApproval(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      delegate: _i3.MultiAddress.codec.decode(input),
      witness: _i11.CancelAttributesApprovalWitness.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  /// CancelAttributesApprovalWitness
  final _i11.CancelAttributesApprovalWitness witness;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'cancel_item_attributes_approval': {
          'collection': collection,
          'item': item,
          'delegate': delegate.toJson(),
          'witness': witness.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + _i11.CancelAttributesApprovalWitness.codec.sizeHint(witness);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    _i11.CancelAttributesApprovalWitness.codec.encodeTo(
      witness,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelItemAttributesApproval &&
          other.collection == collection &&
          other.item == item &&
          other.delegate == delegate &&
          other.witness == witness;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        delegate,
        witness,
      );
}

/// Set the metadata for an item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Admin of the
/// `collection`.
///
/// If the origin is Signed, then funds of signer are reserved according to the formula:
/// `MetadataDepositBase + DepositPerByte * data.len` taking into
/// account any already reserved funds.
///
/// - `collection`: The identifier of the collection whose item's metadata to set.
/// - `item`: The identifier of the item whose metadata to set.
/// - `data`: The general information of this item. Limited in length by `StringLimit`.
///
/// Emits `ItemMetadataSet`.
///
/// Weight: `O(1)`
class SetMetadata extends Call {
  const SetMetadata({
    required this.collection,
    required this.item,
    required this.data,
  });

  factory SetMetadata._decode(_i1.Input input) {
    return SetMetadata(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// BoundedVec<u8, T::StringLimit>
  final List<int> data;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_metadata': {
          'collection': collection,
          'item': item,
          'data': data,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
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
          other.collection == collection &&
          other.item == item &&
          _i18.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        data,
      );
}

/// Clear the metadata for an item.
///
/// Origin must be either `ForceOrigin` or Signed and the sender should be the Admin of the
/// `collection`.
///
/// Any deposit is freed for the collection's owner.
///
/// - `collection`: The identifier of the collection whose item's metadata to clear.
/// - `item`: The identifier of the item whose metadata to clear.
///
/// Emits `ItemMetadataCleared`.
///
/// Weight: `O(1)`
class ClearMetadata extends Call {
  const ClearMetadata({
    required this.collection,
    required this.item,
  });

  factory ClearMetadata._decode(_i1.Input input) {
    return ClearMetadata(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  @override
  Map<String, Map<String, int>> toJson() => {
        'clear_metadata': {
          'collection': collection,
          'item': item,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearMetadata && other.collection == collection && other.item == item;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
      );
}

/// Set the metadata for a collection.
///
/// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Admin of
/// the `collection`.
///
/// If the origin is `Signed`, then funds of signer are reserved according to the formula:
/// `MetadataDepositBase + DepositPerByte * data.len` taking into
/// account any already reserved funds.
///
/// - `collection`: The identifier of the item whose metadata to update.
/// - `data`: The general information of this item. Limited in length by `StringLimit`.
///
/// Emits `CollectionMetadataSet`.
///
/// Weight: `O(1)`
class SetCollectionMetadata extends Call {
  const SetCollectionMetadata({
    required this.collection,
    required this.data,
  });

  factory SetCollectionMetadata._decode(_i1.Input input) {
    return SetCollectionMetadata(
      collection: _i1.U32Codec.codec.decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// BoundedVec<u8, T::StringLimit>
  final List<int> data;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_collection_metadata': {
          'collection': collection,
          'data': data,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCollectionMetadata &&
          other.collection == collection &&
          _i18.listsEqual(
            other.data,
            data,
          );

  @override
  int get hashCode => Object.hash(
        collection,
        data,
      );
}

/// Clear the metadata for a collection.
///
/// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Admin of
/// the `collection`.
///
/// Any deposit is freed for the collection's owner.
///
/// - `collection`: The identifier of the collection whose metadata to clear.
///
/// Emits `CollectionMetadataCleared`.
///
/// Weight: `O(1)`
class ClearCollectionMetadata extends Call {
  const ClearCollectionMetadata({required this.collection});

  factory ClearCollectionMetadata._decode(_i1.Input input) {
    return ClearCollectionMetadata(collection: _i1.U32Codec.codec.decode(input));
  }

  /// T::CollectionId
  final int collection;

  @override
  Map<String, Map<String, int>> toJson() => {
        'clear_collection_metadata': {'collection': collection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearCollectionMetadata && other.collection == collection;

  @override
  int get hashCode => collection.hashCode;
}

/// Set (or reset) the acceptance of ownership for a particular account.
///
/// Origin must be `Signed` and if `maybe_collection` is `Some`, then the signer must have a
/// provider reference.
///
/// - `maybe_collection`: The identifier of the collection whose ownership the signer is
///  willing to accept, or if `None`, an indication that the signer is willing to accept no
///  ownership transferal.
///
/// Emits `OwnershipAcceptanceChanged`.
class SetAcceptOwnership extends Call {
  const SetAcceptOwnership({this.maybeCollection});

  factory SetAcceptOwnership._decode(_i1.Input input) {
    return SetAcceptOwnership(maybeCollection: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input));
  }

  /// Option<T::CollectionId>
  final int? maybeCollection;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'set_accept_ownership': {'maybeCollection': maybeCollection}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeCollection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeCollection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetAcceptOwnership && other.maybeCollection == maybeCollection;

  @override
  int get hashCode => maybeCollection.hashCode;
}

/// Set the maximum number of items a collection could have.
///
/// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Owner of
/// the `collection`.
///
/// - `collection`: The identifier of the collection to change.
/// - `max_supply`: The maximum number of items a collection could have.
///
/// Emits `CollectionMaxSupplySet` event when successful.
class SetCollectionMaxSupply extends Call {
  const SetCollectionMaxSupply({
    required this.collection,
    required this.maxSupply,
  });

  factory SetCollectionMaxSupply._decode(_i1.Input input) {
    return SetCollectionMaxSupply(
      collection: _i1.U32Codec.codec.decode(input),
      maxSupply: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// u32
  final int maxSupply;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_collection_max_supply': {
          'collection': collection,
          'maxSupply': maxSupply,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(maxSupply);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      maxSupply,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCollectionMaxSupply && other.collection == collection && other.maxSupply == maxSupply;

  @override
  int get hashCode => Object.hash(
        collection,
        maxSupply,
      );
}

/// Update mint settings.
///
/// Origin must be either `ForceOrigin` or `Signed` and the sender should be the Issuer
/// of the `collection`.
///
/// - `collection`: The identifier of the collection to change.
/// - `mint_settings`: The new mint settings.
///
/// Emits `CollectionMintSettingsUpdated` event when successful.
class UpdateMintSettings extends Call {
  const UpdateMintSettings({
    required this.collection,
    required this.mintSettings,
  });

  factory UpdateMintSettings._decode(_i1.Input input) {
    return UpdateMintSettings(
      collection: _i1.U32Codec.codec.decode(input),
      mintSettings: _i12.MintSettings.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// MintSettings<BalanceOf<T, I>, BlockNumberFor<T, I>, T::
  ///CollectionId>
  final _i12.MintSettings mintSettings;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'update_mint_settings': {
          'collection': collection,
          'mintSettings': mintSettings.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i12.MintSettings.codec.sizeHint(mintSettings);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i12.MintSettings.codec.encodeTo(
      mintSettings,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateMintSettings && other.collection == collection && other.mintSettings == mintSettings;

  @override
  int get hashCode => Object.hash(
        collection,
        mintSettings,
      );
}

/// Set (or reset) the price for an item.
///
/// Origin must be Signed and must be the owner of the `item`.
///
/// - `collection`: The collection of the item.
/// - `item`: The item to set the price for.
/// - `price`: The price for the item. Pass `None`, to reset the price.
/// - `buyer`: Restricts the buy operation to a specific account.
///
/// Emits `ItemPriceSet` on success if the price is not `None`.
/// Emits `ItemPriceRemoved` on success if the price is `None`.
class SetPrice extends Call {
  const SetPrice({
    required this.collection,
    required this.item,
    this.price,
    this.whitelistedBuyer,
  });

  factory SetPrice._decode(_i1.Input input) {
    return SetPrice(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      price: const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).decode(input),
      whitelistedBuyer: const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// Option<ItemPrice<T, I>>
  final BigInt? price;

  /// Option<AccountIdLookupOf<T>>
  final _i3.MultiAddress? whitelistedBuyer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_price': {
          'collection': collection,
          'item': item,
          'price': price,
          'whitelistedBuyer': whitelistedBuyer?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).sizeHint(price);
    size = size + const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).sizeHint(whitelistedBuyer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U128Codec.codec).encodeTo(
      price,
      output,
    );
    const _i1.OptionCodec<_i3.MultiAddress>(_i3.MultiAddress.codec).encodeTo(
      whitelistedBuyer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetPrice &&
          other.collection == collection &&
          other.item == item &&
          other.price == price &&
          other.whitelistedBuyer == whitelistedBuyer;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        price,
        whitelistedBuyer,
      );
}

/// Allows to buy an item if it's up for sale.
///
/// Origin must be Signed and must not be the owner of the `item`.
///
/// - `collection`: The collection of the item.
/// - `item`: The item the sender wants to buy.
/// - `bid_price`: The price the sender is willing to pay.
///
/// Emits `ItemBought` on success.
class BuyItem extends Call {
  const BuyItem({
    required this.collection,
    required this.item,
    required this.bidPrice,
  });

  factory BuyItem._decode(_i1.Input input) {
    return BuyItem(
      collection: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
      bidPrice: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int collection;

  /// T::ItemId
  final int item;

  /// ItemPrice<T, I>
  final BigInt bidPrice;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'buy_item': {
          'collection': collection,
          'item': item,
          'bidPrice': bidPrice,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(collection);
    size = size + _i1.U32Codec.codec.sizeHint(item);
    size = size + _i1.U128Codec.codec.sizeHint(bidPrice);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      collection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      item,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      bidPrice,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BuyItem && other.collection == collection && other.item == item && other.bidPrice == bidPrice;

  @override
  int get hashCode => Object.hash(
        collection,
        item,
        bidPrice,
      );
}

/// Allows to pay the tips.
///
/// Origin must be Signed.
///
/// - `tips`: Tips array.
///
/// Emits `TipSent` on every tip transfer.
class PayTips extends Call {
  const PayTips({required this.tips});

  factory PayTips._decode(_i1.Input input) {
    return PayTips(tips: const _i1.SequenceCodec<_i13.ItemTip>(_i13.ItemTip.codec).decode(input));
  }

  /// BoundedVec<ItemTipOf<T, I>, T::MaxTips>
  final List<_i13.ItemTip> tips;

  @override
  Map<String, Map<String, List<Map<String, dynamic>>>> toJson() => {
        'pay_tips': {'tips': tips.map((value) => value.toJson()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i13.ItemTip>(_i13.ItemTip.codec).sizeHint(tips);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
    const _i1.SequenceCodec<_i13.ItemTip>(_i13.ItemTip.codec).encodeTo(
      tips,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PayTips &&
          _i18.listsEqual(
            other.tips,
            tips,
          );

  @override
  int get hashCode => tips.hashCode;
}

/// Register a new atomic swap, declaring an intention to send an `item` in exchange for
/// `desired_item` from origin to target on the current blockchain.
/// The target can execute the swap during the specified `duration` of blocks (if set).
/// Additionally, the price could be set for the desired `item`.
///
/// Origin must be Signed and must be an owner of the `item`.
///
/// - `collection`: The collection of the item.
/// - `item`: The item an owner wants to give.
/// - `desired_collection`: The collection of the desired item.
/// - `desired_item`: The desired item an owner wants to receive.
/// - `maybe_price`: The price an owner is willing to pay or receive for the desired `item`.
/// - `duration`: A deadline for the swap. Specified by providing the number of blocks
/// 	after which the swap will expire.
///
/// Emits `SwapCreated` on success.
class CreateSwap extends Call {
  const CreateSwap({
    required this.offeredCollection,
    required this.offeredItem,
    required this.desiredCollection,
    this.maybeDesiredItem,
    this.maybePrice,
    required this.duration,
  });

  factory CreateSwap._decode(_i1.Input input) {
    return CreateSwap(
      offeredCollection: _i1.U32Codec.codec.decode(input),
      offeredItem: _i1.U32Codec.codec.decode(input),
      desiredCollection: _i1.U32Codec.codec.decode(input),
      maybeDesiredItem: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      maybePrice: const _i1.OptionCodec<_i14.PriceWithDirection>(_i14.PriceWithDirection.codec).decode(input),
      duration: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int offeredCollection;

  /// T::ItemId
  final int offeredItem;

  /// T::CollectionId
  final int desiredCollection;

  /// Option<T::ItemId>
  final int? maybeDesiredItem;

  /// Option<PriceWithDirection<ItemPrice<T, I>>>
  final _i14.PriceWithDirection? maybePrice;

  /// BlockNumberFor<T, I>
  final int duration;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create_swap': {
          'offeredCollection': offeredCollection,
          'offeredItem': offeredItem,
          'desiredCollection': desiredCollection,
          'maybeDesiredItem': maybeDesiredItem,
          'maybePrice': maybePrice?.toJson(),
          'duration': duration,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(offeredCollection);
    size = size + _i1.U32Codec.codec.sizeHint(offeredItem);
    size = size + _i1.U32Codec.codec.sizeHint(desiredCollection);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeDesiredItem);
    size = size + const _i1.OptionCodec<_i14.PriceWithDirection>(_i14.PriceWithDirection.codec).sizeHint(maybePrice);
    size = size + _i1.U32Codec.codec.sizeHint(duration);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredItem,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      desiredCollection,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeDesiredItem,
      output,
    );
    const _i1.OptionCodec<_i14.PriceWithDirection>(_i14.PriceWithDirection.codec).encodeTo(
      maybePrice,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      duration,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CreateSwap &&
          other.offeredCollection == offeredCollection &&
          other.offeredItem == offeredItem &&
          other.desiredCollection == desiredCollection &&
          other.maybeDesiredItem == maybeDesiredItem &&
          other.maybePrice == maybePrice &&
          other.duration == duration;

  @override
  int get hashCode => Object.hash(
        offeredCollection,
        offeredItem,
        desiredCollection,
        maybeDesiredItem,
        maybePrice,
        duration,
      );
}

/// Cancel an atomic swap.
///
/// Origin must be Signed.
/// Origin must be an owner of the `item` if the deadline hasn't expired.
///
/// - `collection`: The collection of the item.
/// - `item`: The item an owner wants to give.
///
/// Emits `SwapCancelled` on success.
class CancelSwap extends Call {
  const CancelSwap({
    required this.offeredCollection,
    required this.offeredItem,
  });

  factory CancelSwap._decode(_i1.Input input) {
    return CancelSwap(
      offeredCollection: _i1.U32Codec.codec.decode(input),
      offeredItem: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::CollectionId
  final int offeredCollection;

  /// T::ItemId
  final int offeredItem;

  @override
  Map<String, Map<String, int>> toJson() => {
        'cancel_swap': {
          'offeredCollection': offeredCollection,
          'offeredItem': offeredItem,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(offeredCollection);
    size = size + _i1.U32Codec.codec.sizeHint(offeredItem);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      offeredItem,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelSwap && other.offeredCollection == offeredCollection && other.offeredItem == offeredItem;

  @override
  int get hashCode => Object.hash(
        offeredCollection,
        offeredItem,
      );
}

/// Claim an atomic swap.
/// This method executes a pending swap, that was created by a counterpart before.
///
/// Origin must be Signed and must be an owner of the `item`.
///
/// - `send_collection`: The collection of the item to be sent.
/// - `send_item`: The item to be sent.
/// - `receive_collection`: The collection of the item to be received.
/// - `receive_item`: The item to be received.
/// - `witness_price`: A price that was previously agreed on.
///
/// Emits `SwapClaimed` on success.
class ClaimSwap extends Call {
  const ClaimSwap({
    required this.sendCollection,
    required this.sendItem,
    required this.receiveCollection,
    required this.receiveItem,
    this.witnessPrice,
  });

  factory ClaimSwap._decode(_i1.Input input) {
    return ClaimSwap(
      sendCollection: _i1.U32Codec.codec.decode(input),
      sendItem: _i1.U32Codec.codec.decode(input),
      receiveCollection: _i1.U32Codec.codec.decode(input),
      receiveItem: _i1.U32Codec.codec.decode(input),
      witnessPrice: const _i1.OptionCodec<_i14.PriceWithDirection>(_i14.PriceWithDirection.codec).decode(input),
    );
  }

  /// T::CollectionId
  final int sendCollection;

  /// T::ItemId
  final int sendItem;

  /// T::CollectionId
  final int receiveCollection;

  /// T::ItemId
  final int receiveItem;

  /// Option<PriceWithDirection<ItemPrice<T, I>>>
  final _i14.PriceWithDirection? witnessPrice;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'claim_swap': {
          'sendCollection': sendCollection,
          'sendItem': sendItem,
          'receiveCollection': receiveCollection,
          'receiveItem': receiveItem,
          'witnessPrice': witnessPrice?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(sendCollection);
    size = size + _i1.U32Codec.codec.sizeHint(sendItem);
    size = size + _i1.U32Codec.codec.sizeHint(receiveCollection);
    size = size + _i1.U32Codec.codec.sizeHint(receiveItem);
    size = size + const _i1.OptionCodec<_i14.PriceWithDirection>(_i14.PriceWithDirection.codec).sizeHint(witnessPrice);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sendCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sendItem,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      receiveCollection,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      receiveItem,
      output,
    );
    const _i1.OptionCodec<_i14.PriceWithDirection>(_i14.PriceWithDirection.codec).encodeTo(
      witnessPrice,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimSwap &&
          other.sendCollection == sendCollection &&
          other.sendItem == sendItem &&
          other.receiveCollection == receiveCollection &&
          other.receiveItem == receiveItem &&
          other.witnessPrice == witnessPrice;

  @override
  int get hashCode => Object.hash(
        sendCollection,
        sendItem,
        receiveCollection,
        receiveItem,
        witnessPrice,
      );
}

/// Mint an item by providing the pre-signed approval.
///
/// Origin must be Signed.
///
/// - `mint_data`: The pre-signed approval that consists of the information about the item,
///  its metadata, attributes, who can mint it (`None` for anyone) and until what block
///  number.
/// - `signature`: The signature of the `data` object.
/// - `signer`: The `data` object's signer. Should be an Issuer of the collection.
///
/// Emits `Issued` on success.
/// Emits `AttributeSet` if the attributes were provided.
/// Emits `ItemMetadataSet` if the metadata was not empty.
class MintPreSigned extends Call {
  const MintPreSigned({
    required this.mintData,
    required this.signature,
    required this.signer,
  });

  factory MintPreSigned._decode(_i1.Input input) {
    return MintPreSigned(
      mintData: _i15.PreSignedMint.codec.decode(input),
      signature: _i16.MultiSignature.codec.decode(input),
      signer: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// Box<PreSignedMintOf<T, I>>
  final _i15.PreSignedMint mintData;

  /// T::OffchainSignature
  final _i16.MultiSignature signature;

  /// T::AccountId
  final _i10.AccountId32 signer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'mint_pre_signed': {
          'mintData': mintData.toJson(),
          'signature': signature.toJson(),
          'signer': signer.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i15.PreSignedMint.codec.sizeHint(mintData);
    size = size + _i16.MultiSignature.codec.sizeHint(signature);
    size = size + const _i10.AccountId32Codec().sizeHint(signer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
      output,
    );
    _i15.PreSignedMint.codec.encodeTo(
      mintData,
      output,
    );
    _i16.MultiSignature.codec.encodeTo(
      signature,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      signer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MintPreSigned &&
          other.mintData == mintData &&
          other.signature == signature &&
          _i18.listsEqual(
            other.signer,
            signer,
          );

  @override
  int get hashCode => Object.hash(
        mintData,
        signature,
        signer,
      );
}

/// Set attributes for an item by providing the pre-signed approval.
///
/// Origin must be Signed and must be an owner of the `data.item`.
///
/// - `data`: The pre-signed approval that consists of the information about the item,
///  attributes to update and until what block number.
/// - `signature`: The signature of the `data` object.
/// - `signer`: The `data` object's signer. Should be an Admin of the collection for the
///  `CollectionOwner` namespace.
///
/// Emits `AttributeSet` for each provided attribute.
/// Emits `ItemAttributesApprovalAdded` if the approval wasn't set before.
/// Emits `PreSignedAttributesSet` on success.
class SetAttributesPreSigned extends Call {
  const SetAttributesPreSigned({
    required this.data,
    required this.signature,
    required this.signer,
  });

  factory SetAttributesPreSigned._decode(_i1.Input input) {
    return SetAttributesPreSigned(
      data: _i17.PreSignedAttributes.codec.decode(input),
      signature: _i16.MultiSignature.codec.decode(input),
      signer: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// PreSignedAttributesOf<T, I>
  final _i17.PreSignedAttributes data;

  /// T::OffchainSignature
  final _i16.MultiSignature signature;

  /// T::AccountId
  final _i10.AccountId32 signer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_attributes_pre_signed': {
          'data': data.toJson(),
          'signature': signature.toJson(),
          'signer': signer.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i17.PreSignedAttributes.codec.sizeHint(data);
    size = size + _i16.MultiSignature.codec.sizeHint(signature);
    size = size + const _i10.AccountId32Codec().sizeHint(signer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      38,
      output,
    );
    _i17.PreSignedAttributes.codec.encodeTo(
      data,
      output,
    );
    _i16.MultiSignature.codec.encodeTo(
      signature,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      signer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetAttributesPreSigned &&
          other.data == data &&
          other.signature == signature &&
          _i18.listsEqual(
            other.signer,
            signer,
          );

  @override
  int get hashCode => Object.hash(
        data,
        signature,
        signer,
      );
}
