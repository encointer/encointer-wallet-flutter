// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import 'multiasset/multi_assets.dart' as _i3;
import 'response.dart' as _i4;
import '../../sp_weights/weight_v2/weight.dart' as _i5;
import 'multilocation/multi_location.dart' as _i6;
import 'xcm_1.dart' as _i7;
import '../v2/origin_kind.dart' as _i8;
import '../double_encoded/double_encoded_1.dart' as _i9;
import 'junctions/junctions.dart' as _i10;
import 'query_response_info.dart' as _i11;
import 'multiasset/multi_asset_filter.dart' as _i12;
import 'multiasset/multi_asset.dart' as _i13;
import 'weight_limit.dart' as _i14;
import '../../tuples_1.dart' as _i15;
import 'traits/error.dart' as _i16;
import 'maybe_error_code.dart' as _i17;
import 'junction/junction.dart' as _i18;
import 'junction/network_id.dart' as _i19;
import 'instruction_1.dart' as _i20;

abstract class Instruction {
  const Instruction();

  factory Instruction.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $InstructionCodec codec = $InstructionCodec();

  static const $Instruction values = $Instruction();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Instruction {
  const $Instruction();

  WithdrawAsset withdrawAsset({required _i3.MultiAssets value0}) {
    return WithdrawAsset(
      value0: value0,
    );
  }

  ReserveAssetDeposited reserveAssetDeposited(
      {required _i3.MultiAssets value0}) {
    return ReserveAssetDeposited(
      value0: value0,
    );
  }

  ReceiveTeleportedAsset receiveTeleportedAsset(
      {required _i3.MultiAssets value0}) {
    return ReceiveTeleportedAsset(
      value0: value0,
    );
  }

  QueryResponse queryResponse({
    required BigInt queryId,
    required _i4.Response response,
    required _i5.Weight maxWeight,
    _i6.MultiLocation? querier,
  }) {
    return QueryResponse(
      queryId: queryId,
      response: response,
      maxWeight: maxWeight,
      querier: querier,
    );
  }

  TransferAsset transferAsset({
    required _i3.MultiAssets assets,
    required _i6.MultiLocation beneficiary,
  }) {
    return TransferAsset(
      assets: assets,
      beneficiary: beneficiary,
    );
  }

  TransferReserveAsset transferReserveAsset({
    required _i3.MultiAssets assets,
    required _i6.MultiLocation dest,
    required _i7.Xcm xcm,
  }) {
    return TransferReserveAsset(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  Transact transact({
    required _i8.OriginKind originKind,
    required _i5.Weight requireWeightAtMost,
    required _i9.DoubleEncoded call,
  }) {
    return Transact(
      originKind: originKind,
      requireWeightAtMost: requireWeightAtMost,
      call: call,
    );
  }

  HrmpNewChannelOpenRequest hrmpNewChannelOpenRequest({
    required BigInt sender,
    required BigInt maxMessageSize,
    required BigInt maxCapacity,
  }) {
    return HrmpNewChannelOpenRequest(
      sender: sender,
      maxMessageSize: maxMessageSize,
      maxCapacity: maxCapacity,
    );
  }

  HrmpChannelAccepted hrmpChannelAccepted({required BigInt recipient}) {
    return HrmpChannelAccepted(
      recipient: recipient,
    );
  }

  HrmpChannelClosing hrmpChannelClosing({
    required BigInt initiator,
    required BigInt sender,
    required BigInt recipient,
  }) {
    return HrmpChannelClosing(
      initiator: initiator,
      sender: sender,
      recipient: recipient,
    );
  }

  ClearOrigin clearOrigin() {
    return const ClearOrigin();
  }

  DescendOrigin descendOrigin({required _i10.Junctions value0}) {
    return DescendOrigin(
      value0: value0,
    );
  }

  ReportError reportError({required _i11.QueryResponseInfo value0}) {
    return ReportError(
      value0: value0,
    );
  }

  DepositAsset depositAsset({
    required _i12.MultiAssetFilter assets,
    required _i6.MultiLocation beneficiary,
  }) {
    return DepositAsset(
      assets: assets,
      beneficiary: beneficiary,
    );
  }

  DepositReserveAsset depositReserveAsset({
    required _i12.MultiAssetFilter assets,
    required _i6.MultiLocation dest,
    required _i7.Xcm xcm,
  }) {
    return DepositReserveAsset(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  ExchangeAsset exchangeAsset({
    required _i12.MultiAssetFilter give,
    required _i3.MultiAssets want,
    required bool maximal,
  }) {
    return ExchangeAsset(
      give: give,
      want: want,
      maximal: maximal,
    );
  }

  InitiateReserveWithdraw initiateReserveWithdraw({
    required _i12.MultiAssetFilter assets,
    required _i6.MultiLocation reserve,
    required _i7.Xcm xcm,
  }) {
    return InitiateReserveWithdraw(
      assets: assets,
      reserve: reserve,
      xcm: xcm,
    );
  }

  InitiateTeleport initiateTeleport({
    required _i12.MultiAssetFilter assets,
    required _i6.MultiLocation dest,
    required _i7.Xcm xcm,
  }) {
    return InitiateTeleport(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  ReportHolding reportHolding({
    required _i11.QueryResponseInfo responseInfo,
    required _i12.MultiAssetFilter assets,
  }) {
    return ReportHolding(
      responseInfo: responseInfo,
      assets: assets,
    );
  }

  BuyExecution buyExecution({
    required _i13.MultiAsset fees,
    required _i14.WeightLimit weightLimit,
  }) {
    return BuyExecution(
      fees: fees,
      weightLimit: weightLimit,
    );
  }

  RefundSurplus refundSurplus() {
    return const RefundSurplus();
  }

  SetErrorHandler setErrorHandler({required _i7.Xcm value0}) {
    return SetErrorHandler(
      value0: value0,
    );
  }

  SetAppendix setAppendix({required _i7.Xcm value0}) {
    return SetAppendix(
      value0: value0,
    );
  }

  ClearError clearError() {
    return const ClearError();
  }

  ClaimAsset claimAsset({
    required _i3.MultiAssets assets,
    required _i6.MultiLocation ticket,
  }) {
    return ClaimAsset(
      assets: assets,
      ticket: ticket,
    );
  }

  Trap trap({required BigInt value0}) {
    return Trap(
      value0: value0,
    );
  }

  SubscribeVersion subscribeVersion({
    required BigInt queryId,
    required _i5.Weight maxResponseWeight,
  }) {
    return SubscribeVersion(
      queryId: queryId,
      maxResponseWeight: maxResponseWeight,
    );
  }

  UnsubscribeVersion unsubscribeVersion() {
    return const UnsubscribeVersion();
  }

  BurnAsset burnAsset({required _i3.MultiAssets value0}) {
    return BurnAsset(
      value0: value0,
    );
  }

  ExpectAsset expectAsset({required _i3.MultiAssets value0}) {
    return ExpectAsset(
      value0: value0,
    );
  }

  ExpectOrigin expectOrigin({_i6.MultiLocation? value0}) {
    return ExpectOrigin(
      value0: value0,
    );
  }

  ExpectError expectError({_i15.Tuple2<int, _i16.Error>? value0}) {
    return ExpectError(
      value0: value0,
    );
  }

  ExpectTransactStatus expectTransactStatus(
      {required _i17.MaybeErrorCode value0}) {
    return ExpectTransactStatus(
      value0: value0,
    );
  }

  QueryPallet queryPallet({
    required List<int> moduleName,
    required _i11.QueryResponseInfo responseInfo,
  }) {
    return QueryPallet(
      moduleName: moduleName,
      responseInfo: responseInfo,
    );
  }

  ExpectPallet expectPallet({
    required BigInt index,
    required List<int> name,
    required List<int> moduleName,
    required BigInt crateMajor,
    required BigInt minCrateMinor,
  }) {
    return ExpectPallet(
      index: index,
      name: name,
      moduleName: moduleName,
      crateMajor: crateMajor,
      minCrateMinor: minCrateMinor,
    );
  }

  ReportTransactStatus reportTransactStatus(
      {required _i11.QueryResponseInfo value0}) {
    return ReportTransactStatus(
      value0: value0,
    );
  }

  ClearTransactStatus clearTransactStatus() {
    return const ClearTransactStatus();
  }

  UniversalOrigin universalOrigin({required _i18.Junction value0}) {
    return UniversalOrigin(
      value0: value0,
    );
  }

  ExportMessage exportMessage({
    required _i19.NetworkId network,
    required _i10.Junctions destination,
    required _i7.Xcm xcm,
  }) {
    return ExportMessage(
      network: network,
      destination: destination,
      xcm: xcm,
    );
  }

  LockAsset lockAsset({
    required _i13.MultiAsset asset,
    required _i6.MultiLocation unlocker,
  }) {
    return LockAsset(
      asset: asset,
      unlocker: unlocker,
    );
  }

  UnlockAsset unlockAsset({
    required _i13.MultiAsset asset,
    required _i6.MultiLocation target,
  }) {
    return UnlockAsset(
      asset: asset,
      target: target,
    );
  }

  NoteUnlockable noteUnlockable({
    required _i13.MultiAsset asset,
    required _i6.MultiLocation owner,
  }) {
    return NoteUnlockable(
      asset: asset,
      owner: owner,
    );
  }

  RequestUnlock requestUnlock({
    required _i13.MultiAsset asset,
    required _i6.MultiLocation locker,
  }) {
    return RequestUnlock(
      asset: asset,
      locker: locker,
    );
  }

  SetFeesMode setFeesMode({required bool jitWithdraw}) {
    return SetFeesMode(
      jitWithdraw: jitWithdraw,
    );
  }

  SetTopic setTopic({required List<int> value0}) {
    return SetTopic(
      value0: value0,
    );
  }

  ClearTopic clearTopic() {
    return const ClearTopic();
  }

  AliasOrigin aliasOrigin({required _i6.MultiLocation value0}) {
    return AliasOrigin(
      value0: value0,
    );
  }

  UnpaidExecution unpaidExecution({
    required _i14.WeightLimit weightLimit,
    _i6.MultiLocation? checkOrigin,
  }) {
    return UnpaidExecution(
      weightLimit: weightLimit,
      checkOrigin: checkOrigin,
    );
  }
}

class $InstructionCodec with _i1.Codec<Instruction> {
  const $InstructionCodec();

  @override
  Instruction decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return WithdrawAsset._decode(input);
      case 1:
        return ReserveAssetDeposited._decode(input);
      case 2:
        return ReceiveTeleportedAsset._decode(input);
      case 3:
        return QueryResponse._decode(input);
      case 4:
        return TransferAsset._decode(input);
      case 5:
        return TransferReserveAsset._decode(input);
      case 6:
        return Transact._decode(input);
      case 7:
        return HrmpNewChannelOpenRequest._decode(input);
      case 8:
        return HrmpChannelAccepted._decode(input);
      case 9:
        return HrmpChannelClosing._decode(input);
      case 10:
        return const ClearOrigin();
      case 11:
        return DescendOrigin._decode(input);
      case 12:
        return ReportError._decode(input);
      case 13:
        return DepositAsset._decode(input);
      case 14:
        return DepositReserveAsset._decode(input);
      case 15:
        return ExchangeAsset._decode(input);
      case 16:
        return InitiateReserveWithdraw._decode(input);
      case 17:
        return InitiateTeleport._decode(input);
      case 18:
        return ReportHolding._decode(input);
      case 19:
        return BuyExecution._decode(input);
      case 20:
        return const RefundSurplus();
      case 21:
        return SetErrorHandler._decode(input);
      case 22:
        return SetAppendix._decode(input);
      case 23:
        return const ClearError();
      case 24:
        return ClaimAsset._decode(input);
      case 25:
        return Trap._decode(input);
      case 26:
        return SubscribeVersion._decode(input);
      case 27:
        return const UnsubscribeVersion();
      case 28:
        return BurnAsset._decode(input);
      case 29:
        return ExpectAsset._decode(input);
      case 30:
        return ExpectOrigin._decode(input);
      case 31:
        return ExpectError._decode(input);
      case 32:
        return ExpectTransactStatus._decode(input);
      case 33:
        return QueryPallet._decode(input);
      case 34:
        return ExpectPallet._decode(input);
      case 35:
        return ReportTransactStatus._decode(input);
      case 36:
        return const ClearTransactStatus();
      case 37:
        return UniversalOrigin._decode(input);
      case 38:
        return ExportMessage._decode(input);
      case 39:
        return LockAsset._decode(input);
      case 40:
        return UnlockAsset._decode(input);
      case 41:
        return NoteUnlockable._decode(input);
      case 42:
        return RequestUnlock._decode(input);
      case 43:
        return SetFeesMode._decode(input);
      case 44:
        return SetTopic._decode(input);
      case 45:
        return const ClearTopic();
      case 46:
        return AliasOrigin._decode(input);
      case 47:
        return UnpaidExecution._decode(input);
      default:
        throw Exception('Instruction: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Instruction value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case WithdrawAsset:
        (value as WithdrawAsset).encodeTo(output);
        break;
      case ReserveAssetDeposited:
        (value as ReserveAssetDeposited).encodeTo(output);
        break;
      case ReceiveTeleportedAsset:
        (value as ReceiveTeleportedAsset).encodeTo(output);
        break;
      case QueryResponse:
        (value as QueryResponse).encodeTo(output);
        break;
      case TransferAsset:
        (value as TransferAsset).encodeTo(output);
        break;
      case TransferReserveAsset:
        (value as TransferReserveAsset).encodeTo(output);
        break;
      case Transact:
        (value as Transact).encodeTo(output);
        break;
      case HrmpNewChannelOpenRequest:
        (value as HrmpNewChannelOpenRequest).encodeTo(output);
        break;
      case HrmpChannelAccepted:
        (value as HrmpChannelAccepted).encodeTo(output);
        break;
      case HrmpChannelClosing:
        (value as HrmpChannelClosing).encodeTo(output);
        break;
      case ClearOrigin:
        (value as ClearOrigin).encodeTo(output);
        break;
      case DescendOrigin:
        (value as DescendOrigin).encodeTo(output);
        break;
      case ReportError:
        (value as ReportError).encodeTo(output);
        break;
      case DepositAsset:
        (value as DepositAsset).encodeTo(output);
        break;
      case DepositReserveAsset:
        (value as DepositReserveAsset).encodeTo(output);
        break;
      case ExchangeAsset:
        (value as ExchangeAsset).encodeTo(output);
        break;
      case InitiateReserveWithdraw:
        (value as InitiateReserveWithdraw).encodeTo(output);
        break;
      case InitiateTeleport:
        (value as InitiateTeleport).encodeTo(output);
        break;
      case ReportHolding:
        (value as ReportHolding).encodeTo(output);
        break;
      case BuyExecution:
        (value as BuyExecution).encodeTo(output);
        break;
      case RefundSurplus:
        (value as RefundSurplus).encodeTo(output);
        break;
      case SetErrorHandler:
        (value as SetErrorHandler).encodeTo(output);
        break;
      case SetAppendix:
        (value as SetAppendix).encodeTo(output);
        break;
      case ClearError:
        (value as ClearError).encodeTo(output);
        break;
      case ClaimAsset:
        (value as ClaimAsset).encodeTo(output);
        break;
      case Trap:
        (value as Trap).encodeTo(output);
        break;
      case SubscribeVersion:
        (value as SubscribeVersion).encodeTo(output);
        break;
      case UnsubscribeVersion:
        (value as UnsubscribeVersion).encodeTo(output);
        break;
      case BurnAsset:
        (value as BurnAsset).encodeTo(output);
        break;
      case ExpectAsset:
        (value as ExpectAsset).encodeTo(output);
        break;
      case ExpectOrigin:
        (value as ExpectOrigin).encodeTo(output);
        break;
      case ExpectError:
        (value as ExpectError).encodeTo(output);
        break;
      case ExpectTransactStatus:
        (value as ExpectTransactStatus).encodeTo(output);
        break;
      case QueryPallet:
        (value as QueryPallet).encodeTo(output);
        break;
      case ExpectPallet:
        (value as ExpectPallet).encodeTo(output);
        break;
      case ReportTransactStatus:
        (value as ReportTransactStatus).encodeTo(output);
        break;
      case ClearTransactStatus:
        (value as ClearTransactStatus).encodeTo(output);
        break;
      case UniversalOrigin:
        (value as UniversalOrigin).encodeTo(output);
        break;
      case ExportMessage:
        (value as ExportMessage).encodeTo(output);
        break;
      case LockAsset:
        (value as LockAsset).encodeTo(output);
        break;
      case UnlockAsset:
        (value as UnlockAsset).encodeTo(output);
        break;
      case NoteUnlockable:
        (value as NoteUnlockable).encodeTo(output);
        break;
      case RequestUnlock:
        (value as RequestUnlock).encodeTo(output);
        break;
      case SetFeesMode:
        (value as SetFeesMode).encodeTo(output);
        break;
      case SetTopic:
        (value as SetTopic).encodeTo(output);
        break;
      case ClearTopic:
        (value as ClearTopic).encodeTo(output);
        break;
      case AliasOrigin:
        (value as AliasOrigin).encodeTo(output);
        break;
      case UnpaidExecution:
        (value as UnpaidExecution).encodeTo(output);
        break;
      default:
        throw Exception(
            'Instruction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Instruction value) {
    switch (value.runtimeType) {
      case WithdrawAsset:
        return (value as WithdrawAsset)._sizeHint();
      case ReserveAssetDeposited:
        return (value as ReserveAssetDeposited)._sizeHint();
      case ReceiveTeleportedAsset:
        return (value as ReceiveTeleportedAsset)._sizeHint();
      case QueryResponse:
        return (value as QueryResponse)._sizeHint();
      case TransferAsset:
        return (value as TransferAsset)._sizeHint();
      case TransferReserveAsset:
        return (value as TransferReserveAsset)._sizeHint();
      case Transact:
        return (value as Transact)._sizeHint();
      case HrmpNewChannelOpenRequest:
        return (value as HrmpNewChannelOpenRequest)._sizeHint();
      case HrmpChannelAccepted:
        return (value as HrmpChannelAccepted)._sizeHint();
      case HrmpChannelClosing:
        return (value as HrmpChannelClosing)._sizeHint();
      case ClearOrigin:
        return 1;
      case DescendOrigin:
        return (value as DescendOrigin)._sizeHint();
      case ReportError:
        return (value as ReportError)._sizeHint();
      case DepositAsset:
        return (value as DepositAsset)._sizeHint();
      case DepositReserveAsset:
        return (value as DepositReserveAsset)._sizeHint();
      case ExchangeAsset:
        return (value as ExchangeAsset)._sizeHint();
      case InitiateReserveWithdraw:
        return (value as InitiateReserveWithdraw)._sizeHint();
      case InitiateTeleport:
        return (value as InitiateTeleport)._sizeHint();
      case ReportHolding:
        return (value as ReportHolding)._sizeHint();
      case BuyExecution:
        return (value as BuyExecution)._sizeHint();
      case RefundSurplus:
        return 1;
      case SetErrorHandler:
        return (value as SetErrorHandler)._sizeHint();
      case SetAppendix:
        return (value as SetAppendix)._sizeHint();
      case ClearError:
        return 1;
      case ClaimAsset:
        return (value as ClaimAsset)._sizeHint();
      case Trap:
        return (value as Trap)._sizeHint();
      case SubscribeVersion:
        return (value as SubscribeVersion)._sizeHint();
      case UnsubscribeVersion:
        return 1;
      case BurnAsset:
        return (value as BurnAsset)._sizeHint();
      case ExpectAsset:
        return (value as ExpectAsset)._sizeHint();
      case ExpectOrigin:
        return (value as ExpectOrigin)._sizeHint();
      case ExpectError:
        return (value as ExpectError)._sizeHint();
      case ExpectTransactStatus:
        return (value as ExpectTransactStatus)._sizeHint();
      case QueryPallet:
        return (value as QueryPallet)._sizeHint();
      case ExpectPallet:
        return (value as ExpectPallet)._sizeHint();
      case ReportTransactStatus:
        return (value as ReportTransactStatus)._sizeHint();
      case ClearTransactStatus:
        return 1;
      case UniversalOrigin:
        return (value as UniversalOrigin)._sizeHint();
      case ExportMessage:
        return (value as ExportMessage)._sizeHint();
      case LockAsset:
        return (value as LockAsset)._sizeHint();
      case UnlockAsset:
        return (value as UnlockAsset)._sizeHint();
      case NoteUnlockable:
        return (value as NoteUnlockable)._sizeHint();
      case RequestUnlock:
        return (value as RequestUnlock)._sizeHint();
      case SetFeesMode:
        return (value as SetFeesMode)._sizeHint();
      case SetTopic:
        return (value as SetTopic)._sizeHint();
      case ClearTopic:
        return 1;
      case AliasOrigin:
        return (value as AliasOrigin)._sizeHint();
      case UnpaidExecution:
        return (value as UnpaidExecution)._sizeHint();
      default:
        throw Exception(
            'Instruction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class WithdrawAsset extends Instruction {
  const WithdrawAsset({required this.value0});

  factory WithdrawAsset._decode(_i1.Input input) {
    return WithdrawAsset(
      value0: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'WithdrawAsset': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ReserveAssetDeposited extends Instruction {
  const ReserveAssetDeposited({required this.value0});

  factory ReserveAssetDeposited._decode(_i1.Input input) {
    return ReserveAssetDeposited(
      value0: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'ReserveAssetDeposited': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ReceiveTeleportedAsset extends Instruction {
  const ReceiveTeleportedAsset({required this.value0});

  factory ReceiveTeleportedAsset._decode(_i1.Input input) {
    return ReceiveTeleportedAsset(
      value0: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() => {
        'ReceiveTeleportedAsset': value0.map((value) => value.toJson()).toList()
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class QueryResponse extends Instruction {
  const QueryResponse({
    required this.queryId,
    required this.response,
    required this.maxWeight,
    this.querier,
  });

  factory QueryResponse._decode(_i1.Input input) {
    return QueryResponse(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      response: _i4.Response.codec.decode(input),
      maxWeight: _i5.Weight.codec.decode(input),
      querier: const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec)
          .decode(input),
    );
  }

  final BigInt queryId;

  final _i4.Response response;

  final _i5.Weight maxWeight;

  final _i6.MultiLocation? querier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryResponse': {
          'queryId': queryId,
          'response': response.toJson(),
          'maxWeight': maxWeight.toJson(),
          'querier': querier?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i4.Response.codec.sizeHint(response);
    size = size + _i5.Weight.codec.sizeHint(maxWeight);
    size = size +
        const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec)
            .sizeHint(querier);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i4.Response.codec.encodeTo(
      response,
      output,
    );
    _i5.Weight.codec.encodeTo(
      maxWeight,
      output,
    );
    const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec).encodeTo(
      querier,
      output,
    );
  }
}

class TransferAsset extends Instruction {
  const TransferAsset({
    required this.assets,
    required this.beneficiary,
  });

  factory TransferAsset._decode(_i1.Input input) {
    return TransferAsset(
      assets: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
      beneficiary: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i3.MultiAssets assets;

  final _i6.MultiLocation beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TransferAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(assets);
    size = size + _i6.MultiLocation.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
  }
}

class TransferReserveAsset extends Instruction {
  const TransferReserveAsset({
    required this.assets,
    required this.dest,
    required this.xcm,
  });

  factory TransferReserveAsset._decode(_i1.Input input) {
    return TransferReserveAsset(
      assets: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
      dest: _i6.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets assets;

  final _i6.MultiLocation dest;

  final _i7.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TransferReserveAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(assets);
    size = size + _i6.MultiLocation.codec.sizeHint(dest);
    size = size +
        const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class Transact extends Instruction {
  const Transact({
    required this.originKind,
    required this.requireWeightAtMost,
    required this.call,
  });

  factory Transact._decode(_i1.Input input) {
    return Transact(
      originKind: _i8.OriginKind.codec.decode(input),
      requireWeightAtMost: _i5.Weight.codec.decode(input),
      call: _i9.DoubleEncoded.codec.decode(input),
    );
  }

  final _i8.OriginKind originKind;

  final _i5.Weight requireWeightAtMost;

  final _i9.DoubleEncoded call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Transact': {
          'originKind': originKind.toJson(),
          'requireWeightAtMost': requireWeightAtMost.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.OriginKind.codec.sizeHint(originKind);
    size = size + _i5.Weight.codec.sizeHint(requireWeightAtMost);
    size = size + _i9.DoubleEncoded.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i8.OriginKind.codec.encodeTo(
      originKind,
      output,
    );
    _i5.Weight.codec.encodeTo(
      requireWeightAtMost,
      output,
    );
    _i9.DoubleEncoded.codec.encodeTo(
      call,
      output,
    );
  }
}

class HrmpNewChannelOpenRequest extends Instruction {
  const HrmpNewChannelOpenRequest({
    required this.sender,
    required this.maxMessageSize,
    required this.maxCapacity,
  });

  factory HrmpNewChannelOpenRequest._decode(_i1.Input input) {
    return HrmpNewChannelOpenRequest(
      sender: _i1.CompactBigIntCodec.codec.decode(input),
      maxMessageSize: _i1.CompactBigIntCodec.codec.decode(input),
      maxCapacity: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt sender;

  final BigInt maxMessageSize;

  final BigInt maxCapacity;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'HrmpNewChannelOpenRequest': {
          'sender': sender,
          'maxMessageSize': maxMessageSize,
          'maxCapacity': maxCapacity,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(sender);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxMessageSize);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxCapacity);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      sender,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxMessageSize,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxCapacity,
      output,
    );
  }
}

class HrmpChannelAccepted extends Instruction {
  const HrmpChannelAccepted({required this.recipient});

  factory HrmpChannelAccepted._decode(_i1.Input input) {
    return HrmpChannelAccepted(
      recipient: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt recipient;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'HrmpChannelAccepted': {'recipient': recipient}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(recipient);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      recipient,
      output,
    );
  }
}

class HrmpChannelClosing extends Instruction {
  const HrmpChannelClosing({
    required this.initiator,
    required this.sender,
    required this.recipient,
  });

  factory HrmpChannelClosing._decode(_i1.Input input) {
    return HrmpChannelClosing(
      initiator: _i1.CompactBigIntCodec.codec.decode(input),
      sender: _i1.CompactBigIntCodec.codec.decode(input),
      recipient: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt initiator;

  final BigInt sender;

  final BigInt recipient;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'HrmpChannelClosing': {
          'initiator': initiator,
          'sender': sender,
          'recipient': recipient,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(initiator);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(sender);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(recipient);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      initiator,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      sender,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      recipient,
      output,
    );
  }
}

class ClearOrigin extends Instruction {
  const ClearOrigin();

  @override
  Map<String, dynamic> toJson() => {'ClearOrigin': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }
}

class DescendOrigin extends Instruction {
  const DescendOrigin({required this.value0});

  factory DescendOrigin._decode(_i1.Input input) {
    return DescendOrigin(
      value0: _i10.Junctions.codec.decode(input),
    );
  }

  final _i10.Junctions value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'DescendOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Junctions.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i10.Junctions.codec.encodeTo(
      value0,
      output,
    );
  }
}

class ReportError extends Instruction {
  const ReportError({required this.value0});

  factory ReportError._decode(_i1.Input input) {
    return ReportError(
      value0: _i11.QueryResponseInfo.codec.decode(input),
    );
  }

  final _i11.QueryResponseInfo value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ReportError': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.QueryResponseInfo.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
      value0,
      output,
    );
  }
}

class DepositAsset extends Instruction {
  const DepositAsset({
    required this.assets,
    required this.beneficiary,
  });

  factory DepositAsset._decode(_i1.Input input) {
    return DepositAsset(
      assets: _i12.MultiAssetFilter.codec.decode(input),
      beneficiary: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i12.MultiAssetFilter assets;

  final _i6.MultiLocation beneficiary;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'DepositAsset': {
          'assets': assets.toJson(),
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i6.MultiLocation.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i12.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
  }
}

class DepositReserveAsset extends Instruction {
  const DepositReserveAsset({
    required this.assets,
    required this.dest,
    required this.xcm,
  });

  factory DepositReserveAsset._decode(_i1.Input input) {
    return DepositReserveAsset(
      assets: _i12.MultiAssetFilter.codec.decode(input),
      dest: _i6.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
          .decode(input),
    );
  }

  final _i12.MultiAssetFilter assets;

  final _i6.MultiLocation dest;

  final _i7.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DepositReserveAsset': {
          'assets': assets.toJson(),
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i6.MultiLocation.codec.sizeHint(dest);
    size = size +
        const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i12.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class ExchangeAsset extends Instruction {
  const ExchangeAsset({
    required this.give,
    required this.want,
    required this.maximal,
  });

  factory ExchangeAsset._decode(_i1.Input input) {
    return ExchangeAsset(
      give: _i12.MultiAssetFilter.codec.decode(input),
      want: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
      maximal: _i1.BoolCodec.codec.decode(input),
    );
  }

  final _i12.MultiAssetFilter give;

  final _i3.MultiAssets want;

  final bool maximal;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExchangeAsset': {
          'give': give.toJson(),
          'want': want.map((value) => value.toJson()).toList(),
          'maximal': maximal,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.MultiAssetFilter.codec.sizeHint(give);
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(want);
    size = size + _i1.BoolCodec.codec.sizeHint(maximal);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i12.MultiAssetFilter.codec.encodeTo(
      give,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      want,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      maximal,
      output,
    );
  }
}

class InitiateReserveWithdraw extends Instruction {
  const InitiateReserveWithdraw({
    required this.assets,
    required this.reserve,
    required this.xcm,
  });

  factory InitiateReserveWithdraw._decode(_i1.Input input) {
    return InitiateReserveWithdraw(
      assets: _i12.MultiAssetFilter.codec.decode(input),
      reserve: _i6.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
          .decode(input),
    );
  }

  final _i12.MultiAssetFilter assets;

  final _i6.MultiLocation reserve;

  final _i7.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InitiateReserveWithdraw': {
          'assets': assets.toJson(),
          'reserve': reserve.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i6.MultiLocation.codec.sizeHint(reserve);
    size = size +
        const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i12.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      reserve,
      output,
    );
    const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class InitiateTeleport extends Instruction {
  const InitiateTeleport({
    required this.assets,
    required this.dest,
    required this.xcm,
  });

  factory InitiateTeleport._decode(_i1.Input input) {
    return InitiateTeleport(
      assets: _i12.MultiAssetFilter.codec.decode(input),
      dest: _i6.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
          .decode(input),
    );
  }

  final _i12.MultiAssetFilter assets;

  final _i6.MultiLocation dest;

  final _i7.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InitiateTeleport': {
          'assets': assets.toJson(),
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i6.MultiLocation.codec.sizeHint(dest);
    size = size +
        const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i12.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class ReportHolding extends Instruction {
  const ReportHolding({
    required this.responseInfo,
    required this.assets,
  });

  factory ReportHolding._decode(_i1.Input input) {
    return ReportHolding(
      responseInfo: _i11.QueryResponseInfo.codec.decode(input),
      assets: _i12.MultiAssetFilter.codec.decode(input),
    );
  }

  final _i11.QueryResponseInfo responseInfo;

  final _i12.MultiAssetFilter assets;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'ReportHolding': {
          'responseInfo': responseInfo.toJson(),
          'assets': assets.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i11.QueryResponseInfo.codec.sizeHint(responseInfo);
    size = size + _i12.MultiAssetFilter.codec.sizeHint(assets);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
      responseInfo,
      output,
    );
    _i12.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
  }
}

class BuyExecution extends Instruction {
  const BuyExecution({
    required this.fees,
    required this.weightLimit,
  });

  factory BuyExecution._decode(_i1.Input input) {
    return BuyExecution(
      fees: _i13.MultiAsset.codec.decode(input),
      weightLimit: _i14.WeightLimit.codec.decode(input),
    );
  }

  final _i13.MultiAsset fees;

  final _i14.WeightLimit weightLimit;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'BuyExecution': {
          'fees': fees.toJson(),
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.MultiAsset.codec.sizeHint(fees);
    size = size + _i14.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i13.MultiAsset.codec.encodeTo(
      fees,
      output,
    );
    _i14.WeightLimit.codec.encodeTo(
      weightLimit,
      output,
    );
  }
}

class RefundSurplus extends Instruction {
  const RefundSurplus();

  @override
  Map<String, dynamic> toJson() => {'RefundSurplus': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
  }
}

class SetErrorHandler extends Instruction {
  const SetErrorHandler({required this.value0});

  factory SetErrorHandler._decode(_i1.Input input) {
    return SetErrorHandler(
      value0: const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
          .decode(input),
    );
  }

  final _i7.Xcm value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() =>
      {'SetErrorHandler': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec).encodeTo(
      value0,
      output,
    );
  }
}

class SetAppendix extends Instruction {
  const SetAppendix({required this.value0});

  factory SetAppendix._decode(_i1.Input input) {
    return SetAppendix(
      value0: const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
          .decode(input),
    );
  }

  final _i7.Xcm value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() =>
      {'SetAppendix': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ClearError extends Instruction {
  const ClearError();

  @override
  Map<String, dynamic> toJson() => {'ClearError': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
  }
}

class ClaimAsset extends Instruction {
  const ClaimAsset({
    required this.assets,
    required this.ticket,
  });

  factory ClaimAsset._decode(_i1.Input input) {
    return ClaimAsset(
      assets: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
      ticket: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i3.MultiAssets assets;

  final _i6.MultiLocation ticket;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ClaimAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'ticket': ticket.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(assets);
    size = size + _i6.MultiLocation.codec.sizeHint(ticket);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      ticket,
      output,
    );
  }
}

class Trap extends Instruction {
  const Trap({required this.value0});

  factory Trap._decode(_i1.Input input) {
    return Trap(
      value0: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Trap': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value0,
      output,
    );
  }
}

class SubscribeVersion extends Instruction {
  const SubscribeVersion({
    required this.queryId,
    required this.maxResponseWeight,
  });

  factory SubscribeVersion._decode(_i1.Input input) {
    return SubscribeVersion(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      maxResponseWeight: _i5.Weight.codec.decode(input),
    );
  }

  final BigInt queryId;

  final _i5.Weight maxResponseWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SubscribeVersion': {
          'queryId': queryId,
          'maxResponseWeight': maxResponseWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i5.Weight.codec.sizeHint(maxResponseWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i5.Weight.codec.encodeTo(
      maxResponseWeight,
      output,
    );
  }
}

class UnsubscribeVersion extends Instruction {
  const UnsubscribeVersion();

  @override
  Map<String, dynamic> toJson() => {'UnsubscribeVersion': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
  }
}

class BurnAsset extends Instruction {
  const BurnAsset({required this.value0});

  factory BurnAsset._decode(_i1.Input input) {
    return BurnAsset(
      value0: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'BurnAsset': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ExpectAsset extends Instruction {
  const ExpectAsset({required this.value0});

  factory ExpectAsset._decode(_i1.Input input) {
    return ExpectAsset(
      value0: const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'ExpectAsset': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    const _i1.SequenceCodec<_i13.MultiAsset>(_i13.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ExpectOrigin extends Instruction {
  const ExpectOrigin({this.value0});

  factory ExpectOrigin._decode(_i1.Input input) {
    return ExpectOrigin(
      value0: const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec)
          .decode(input),
    );
  }

  final _i6.MultiLocation? value0;

  @override
  Map<String, Map<String, dynamic>?> toJson() =>
      {'ExpectOrigin': value0?.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ExpectError extends Instruction {
  const ExpectError({this.value0});

  factory ExpectError._decode(_i1.Input input) {
    return ExpectError(
      value0: const _i1.OptionCodec<_i15.Tuple2<int, _i16.Error>>(
          _i15.Tuple2Codec<int, _i16.Error>(
        _i1.U32Codec.codec,
        _i16.Error.codec,
      )).decode(input),
    );
  }

  final _i15.Tuple2<int, _i16.Error>? value0;

  @override
  Map<String, List<dynamic>?> toJson() => {
        'ExpectError': [
          value0?.value0,
          value0?.value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i15.Tuple2<int, _i16.Error>>(
            _i15.Tuple2Codec<int, _i16.Error>(
          _i1.U32Codec.codec,
          _i16.Error.codec,
        )).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    const _i1.OptionCodec<_i15.Tuple2<int, _i16.Error>>(
        _i15.Tuple2Codec<int, _i16.Error>(
      _i1.U32Codec.codec,
      _i16.Error.codec,
    )).encodeTo(
      value0,
      output,
    );
  }
}

class ExpectTransactStatus extends Instruction {
  const ExpectTransactStatus({required this.value0});

  factory ExpectTransactStatus._decode(_i1.Input input) {
    return ExpectTransactStatus(
      value0: _i17.MaybeErrorCode.codec.decode(input),
    );
  }

  final _i17.MaybeErrorCode value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ExpectTransactStatus': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.MaybeErrorCode.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i17.MaybeErrorCode.codec.encodeTo(
      value0,
      output,
    );
  }
}

class QueryPallet extends Instruction {
  const QueryPallet({
    required this.moduleName,
    required this.responseInfo,
  });

  factory QueryPallet._decode(_i1.Input input) {
    return QueryPallet(
      moduleName: _i1.U8SequenceCodec.codec.decode(input),
      responseInfo: _i11.QueryResponseInfo.codec.decode(input),
    );
  }

  final List<int> moduleName;

  final _i11.QueryResponseInfo responseInfo;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryPallet': {
          'moduleName': moduleName,
          'responseInfo': responseInfo.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(moduleName);
    size = size + _i11.QueryResponseInfo.codec.sizeHint(responseInfo);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      moduleName,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
      responseInfo,
      output,
    );
  }
}

class ExpectPallet extends Instruction {
  const ExpectPallet({
    required this.index,
    required this.name,
    required this.moduleName,
    required this.crateMajor,
    required this.minCrateMinor,
  });

  factory ExpectPallet._decode(_i1.Input input) {
    return ExpectPallet(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      name: _i1.U8SequenceCodec.codec.decode(input),
      moduleName: _i1.U8SequenceCodec.codec.decode(input),
      crateMajor: _i1.CompactBigIntCodec.codec.decode(input),
      minCrateMinor: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt index;

  final List<int> name;

  final List<int> moduleName;

  final BigInt crateMajor;

  final BigInt minCrateMinor;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExpectPallet': {
          'index': index,
          'name': name,
          'moduleName': moduleName,
          'crateMajor': crateMajor,
          'minCrateMinor': minCrateMinor,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(name);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(moduleName);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(crateMajor);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(minCrateMinor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      name,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      moduleName,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      crateMajor,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      minCrateMinor,
      output,
    );
  }
}

class ReportTransactStatus extends Instruction {
  const ReportTransactStatus({required this.value0});

  factory ReportTransactStatus._decode(_i1.Input input) {
    return ReportTransactStatus(
      value0: _i11.QueryResponseInfo.codec.decode(input),
    );
  }

  final _i11.QueryResponseInfo value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ReportTransactStatus': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.QueryResponseInfo.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
      value0,
      output,
    );
  }
}

class ClearTransactStatus extends Instruction {
  const ClearTransactStatus();

  @override
  Map<String, dynamic> toJson() => {'ClearTransactStatus': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
      output,
    );
  }
}

class UniversalOrigin extends Instruction {
  const UniversalOrigin({required this.value0});

  factory UniversalOrigin._decode(_i1.Input input) {
    return UniversalOrigin(
      value0: _i18.Junction.codec.decode(input),
    );
  }

  final _i18.Junction value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'UniversalOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Junction.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
      output,
    );
    _i18.Junction.codec.encodeTo(
      value0,
      output,
    );
  }
}

class ExportMessage extends Instruction {
  const ExportMessage({
    required this.network,
    required this.destination,
    required this.xcm,
  });

  factory ExportMessage._decode(_i1.Input input) {
    return ExportMessage(
      network: _i19.NetworkId.codec.decode(input),
      destination: _i10.Junctions.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
          .decode(input),
    );
  }

  final _i19.NetworkId network;

  final _i10.Junctions destination;

  final _i7.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExportMessage': {
          'network': network.toJson(),
          'destination': destination.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i19.NetworkId.codec.sizeHint(network);
    size = size + _i10.Junctions.codec.sizeHint(destination);
    size = size +
        const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      38,
      output,
    );
    _i19.NetworkId.codec.encodeTo(
      network,
      output,
    );
    _i10.Junctions.codec.encodeTo(
      destination,
      output,
    );
    const _i1.SequenceCodec<_i20.Instruction>(_i20.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class LockAsset extends Instruction {
  const LockAsset({
    required this.asset,
    required this.unlocker,
  });

  factory LockAsset._decode(_i1.Input input) {
    return LockAsset(
      asset: _i13.MultiAsset.codec.decode(input),
      unlocker: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i13.MultiAsset asset;

  final _i6.MultiLocation unlocker;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'LockAsset': {
          'asset': asset.toJson(),
          'unlocker': unlocker.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.MultiAsset.codec.sizeHint(asset);
    size = size + _i6.MultiLocation.codec.sizeHint(unlocker);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      39,
      output,
    );
    _i13.MultiAsset.codec.encodeTo(
      asset,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      unlocker,
      output,
    );
  }
}

class UnlockAsset extends Instruction {
  const UnlockAsset({
    required this.asset,
    required this.target,
  });

  factory UnlockAsset._decode(_i1.Input input) {
    return UnlockAsset(
      asset: _i13.MultiAsset.codec.decode(input),
      target: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i13.MultiAsset asset;

  final _i6.MultiLocation target;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'UnlockAsset': {
          'asset': asset.toJson(),
          'target': target.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.MultiAsset.codec.sizeHint(asset);
    size = size + _i6.MultiLocation.codec.sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i13.MultiAsset.codec.encodeTo(
      asset,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      target,
      output,
    );
  }
}

class NoteUnlockable extends Instruction {
  const NoteUnlockable({
    required this.asset,
    required this.owner,
  });

  factory NoteUnlockable._decode(_i1.Input input) {
    return NoteUnlockable(
      asset: _i13.MultiAsset.codec.decode(input),
      owner: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i13.MultiAsset asset;

  final _i6.MultiLocation owner;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'NoteUnlockable': {
          'asset': asset.toJson(),
          'owner': owner.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.MultiAsset.codec.sizeHint(asset);
    size = size + _i6.MultiLocation.codec.sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      41,
      output,
    );
    _i13.MultiAsset.codec.encodeTo(
      asset,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      owner,
      output,
    );
  }
}

class RequestUnlock extends Instruction {
  const RequestUnlock({
    required this.asset,
    required this.locker,
  });

  factory RequestUnlock._decode(_i1.Input input) {
    return RequestUnlock(
      asset: _i13.MultiAsset.codec.decode(input),
      locker: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i13.MultiAsset asset;

  final _i6.MultiLocation locker;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'RequestUnlock': {
          'asset': asset.toJson(),
          'locker': locker.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.MultiAsset.codec.sizeHint(asset);
    size = size + _i6.MultiLocation.codec.sizeHint(locker);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      42,
      output,
    );
    _i13.MultiAsset.codec.encodeTo(
      asset,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      locker,
      output,
    );
  }
}

class SetFeesMode extends Instruction {
  const SetFeesMode({required this.jitWithdraw});

  factory SetFeesMode._decode(_i1.Input input) {
    return SetFeesMode(
      jitWithdraw: _i1.BoolCodec.codec.decode(input),
    );
  }

  final bool jitWithdraw;

  @override
  Map<String, Map<String, bool>> toJson() => {
        'SetFeesMode': {'jitWithdraw': jitWithdraw}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(jitWithdraw);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      43,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      jitWithdraw,
      output,
    );
  }
}

class SetTopic extends Instruction {
  const SetTopic({required this.value0});

  factory SetTopic._decode(_i1.Input input) {
    return SetTopic(
      value0: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'SetTopic': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      44,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
  }
}

class ClearTopic extends Instruction {
  const ClearTopic();

  @override
  Map<String, dynamic> toJson() => {'ClearTopic': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      45,
      output,
    );
  }
}

class AliasOrigin extends Instruction {
  const AliasOrigin({required this.value0});

  factory AliasOrigin._decode(_i1.Input input) {
    return AliasOrigin(
      value0: _i6.MultiLocation.codec.decode(input),
    );
  }

  final _i6.MultiLocation value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'AliasOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.MultiLocation.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      46,
      output,
    );
    _i6.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
  }
}

class UnpaidExecution extends Instruction {
  const UnpaidExecution({
    required this.weightLimit,
    this.checkOrigin,
  });

  factory UnpaidExecution._decode(_i1.Input input) {
    return UnpaidExecution(
      weightLimit: _i14.WeightLimit.codec.decode(input),
      checkOrigin:
          const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec)
              .decode(input),
    );
  }

  final _i14.WeightLimit weightLimit;

  final _i6.MultiLocation? checkOrigin;

  @override
  Map<String, Map<String, Map<String, dynamic>?>> toJson() => {
        'UnpaidExecution': {
          'weightLimit': weightLimit.toJson(),
          'checkOrigin': checkOrigin?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i14.WeightLimit.codec.sizeHint(weightLimit);
    size = size +
        const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec)
            .sizeHint(checkOrigin);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      47,
      output,
    );
    _i14.WeightLimit.codec.encodeTo(
      weightLimit,
      output,
    );
    const _i1.OptionCodec<_i6.MultiLocation>(_i6.MultiLocation.codec).encodeTo(
      checkOrigin,
      output,
    );
  }
}
