// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import 'multiasset/multi_assets.dart' as _i3;
import 'response.dart' as _i4;
import 'multilocation/multi_location.dart' as _i5;
import 'xcm_1.dart' as _i6;
import 'origin_kind.dart' as _i7;
import '../double_encoded/double_encoded_1.dart' as _i8;
import 'multilocation/junctions.dart' as _i9;
import 'multiasset/multi_asset_filter.dart' as _i10;
import 'multiasset/multi_asset.dart' as _i11;
import 'weight_limit.dart' as _i12;
import 'instruction_1.dart' as _i13;

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
    required BigInt maxWeight,
  }) {
    return QueryResponse(
      queryId: queryId,
      response: response,
      maxWeight: maxWeight,
    );
  }

  TransferAsset transferAsset({
    required _i3.MultiAssets assets,
    required _i5.MultiLocation beneficiary,
  }) {
    return TransferAsset(
      assets: assets,
      beneficiary: beneficiary,
    );
  }

  TransferReserveAsset transferReserveAsset({
    required _i3.MultiAssets assets,
    required _i5.MultiLocation dest,
    required _i6.Xcm xcm,
  }) {
    return TransferReserveAsset(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  Transact transact({
    required _i7.OriginKind originType,
    required BigInt requireWeightAtMost,
    required _i8.DoubleEncoded call,
  }) {
    return Transact(
      originType: originType,
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

  DescendOrigin descendOrigin({required _i9.Junctions value0}) {
    return DescendOrigin(
      value0: value0,
    );
  }

  ReportError reportError({
    required BigInt queryId,
    required _i5.MultiLocation dest,
    required BigInt maxResponseWeight,
  }) {
    return ReportError(
      queryId: queryId,
      dest: dest,
      maxResponseWeight: maxResponseWeight,
    );
  }

  DepositAsset depositAsset({
    required _i10.MultiAssetFilter assets,
    required BigInt maxAssets,
    required _i5.MultiLocation beneficiary,
  }) {
    return DepositAsset(
      assets: assets,
      maxAssets: maxAssets,
      beneficiary: beneficiary,
    );
  }

  DepositReserveAsset depositReserveAsset({
    required _i10.MultiAssetFilter assets,
    required BigInt maxAssets,
    required _i5.MultiLocation dest,
    required _i6.Xcm xcm,
  }) {
    return DepositReserveAsset(
      assets: assets,
      maxAssets: maxAssets,
      dest: dest,
      xcm: xcm,
    );
  }

  ExchangeAsset exchangeAsset({
    required _i10.MultiAssetFilter give,
    required _i3.MultiAssets receive,
  }) {
    return ExchangeAsset(
      give: give,
      receive: receive,
    );
  }

  InitiateReserveWithdraw initiateReserveWithdraw({
    required _i10.MultiAssetFilter assets,
    required _i5.MultiLocation reserve,
    required _i6.Xcm xcm,
  }) {
    return InitiateReserveWithdraw(
      assets: assets,
      reserve: reserve,
      xcm: xcm,
    );
  }

  InitiateTeleport initiateTeleport({
    required _i10.MultiAssetFilter assets,
    required _i5.MultiLocation dest,
    required _i6.Xcm xcm,
  }) {
    return InitiateTeleport(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  QueryHolding queryHolding({
    required BigInt queryId,
    required _i5.MultiLocation dest,
    required _i10.MultiAssetFilter assets,
    required BigInt maxResponseWeight,
  }) {
    return QueryHolding(
      queryId: queryId,
      dest: dest,
      assets: assets,
      maxResponseWeight: maxResponseWeight,
    );
  }

  BuyExecution buyExecution({
    required _i11.MultiAsset fees,
    required _i12.WeightLimit weightLimit,
  }) {
    return BuyExecution(
      fees: fees,
      weightLimit: weightLimit,
    );
  }

  RefundSurplus refundSurplus() {
    return const RefundSurplus();
  }

  SetErrorHandler setErrorHandler({required _i6.Xcm value0}) {
    return SetErrorHandler(
      value0: value0,
    );
  }

  SetAppendix setAppendix({required _i6.Xcm value0}) {
    return SetAppendix(
      value0: value0,
    );
  }

  ClearError clearError() {
    return const ClearError();
  }

  ClaimAsset claimAsset({
    required _i3.MultiAssets assets,
    required _i5.MultiLocation ticket,
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
    required BigInt maxResponseWeight,
  }) {
    return SubscribeVersion(
      queryId: queryId,
      maxResponseWeight: maxResponseWeight,
    );
  }

  UnsubscribeVersion unsubscribeVersion() {
    return const UnsubscribeVersion();
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
        return QueryHolding._decode(input);
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
      case QueryHolding:
        (value as QueryHolding).encodeTo(output);
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
      case QueryHolding:
        return (value as QueryHolding)._sizeHint();
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
      value0: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
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
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ReserveAssetDeposited extends Instruction {
  const ReserveAssetDeposited({required this.value0});

  factory ReserveAssetDeposited._decode(_i1.Input input) {
    return ReserveAssetDeposited(
      value0: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
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
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ReceiveTeleportedAsset extends Instruction {
  const ReceiveTeleportedAsset({required this.value0});

  factory ReceiveTeleportedAsset._decode(_i1.Input input) {
    return ReceiveTeleportedAsset(
      value0: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
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
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
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
  });

  factory QueryResponse._decode(_i1.Input input) {
    return QueryResponse(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      response: _i4.Response.codec.decode(input),
      maxWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt queryId;

  final _i4.Response response;

  final BigInt maxWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryResponse': {
          'queryId': queryId,
          'response': response.toJson(),
          'maxWeight': maxWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i4.Response.codec.sizeHint(response);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxWeight);
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
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxWeight,
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
      assets: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
      beneficiary: _i5.MultiLocation.codec.decode(input),
    );
  }

  final _i3.MultiAssets assets;

  final _i5.MultiLocation beneficiary;

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
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
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
      assets: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
          .decode(input),
    );
  }

  final _i3.MultiAssets assets;

  final _i5.MultiLocation dest;

  final _i6.Xcm xcm;

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
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size +
        const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class Transact extends Instruction {
  const Transact({
    required this.originType,
    required this.requireWeightAtMost,
    required this.call,
  });

  factory Transact._decode(_i1.Input input) {
    return Transact(
      originType: _i7.OriginKind.codec.decode(input),
      requireWeightAtMost: _i1.CompactBigIntCodec.codec.decode(input),
      call: _i8.DoubleEncoded.codec.decode(input),
    );
  }

  final _i7.OriginKind originType;

  final BigInt requireWeightAtMost;

  final _i8.DoubleEncoded call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Transact': {
          'originType': originType.toJson(),
          'requireWeightAtMost': requireWeightAtMost,
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.OriginKind.codec.sizeHint(originType);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(requireWeightAtMost);
    size = size + _i8.DoubleEncoded.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i7.OriginKind.codec.encodeTo(
      originType,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      requireWeightAtMost,
      output,
    );
    _i8.DoubleEncoded.codec.encodeTo(
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
      value0: _i9.Junctions.codec.decode(input),
    );
  }

  final _i9.Junctions value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'DescendOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Junctions.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i9.Junctions.codec.encodeTo(
      value0,
      output,
    );
  }
}

class ReportError extends Instruction {
  const ReportError({
    required this.queryId,
    required this.dest,
    required this.maxResponseWeight,
  });

  factory ReportError._decode(_i1.Input input) {
    return ReportError(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      maxResponseWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt queryId;

  final _i5.MultiLocation dest;

  final BigInt maxResponseWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ReportError': {
          'queryId': queryId,
          'dest': dest.toJson(),
          'maxResponseWeight': maxResponseWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxResponseWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxResponseWeight,
      output,
    );
  }
}

class DepositAsset extends Instruction {
  const DepositAsset({
    required this.assets,
    required this.maxAssets,
    required this.beneficiary,
  });

  factory DepositAsset._decode(_i1.Input input) {
    return DepositAsset(
      assets: _i10.MultiAssetFilter.codec.decode(input),
      maxAssets: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i5.MultiLocation.codec.decode(input),
    );
  }

  final _i10.MultiAssetFilter assets;

  final BigInt maxAssets;

  final _i5.MultiLocation beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DepositAsset': {
          'assets': assets.toJson(),
          'maxAssets': maxAssets,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxAssets);
    size = size + _i5.MultiLocation.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxAssets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
  }
}

class DepositReserveAsset extends Instruction {
  const DepositReserveAsset({
    required this.assets,
    required this.maxAssets,
    required this.dest,
    required this.xcm,
  });

  factory DepositReserveAsset._decode(_i1.Input input) {
    return DepositReserveAsset(
      assets: _i10.MultiAssetFilter.codec.decode(input),
      maxAssets: _i1.CompactBigIntCodec.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
          .decode(input),
    );
  }

  final _i10.MultiAssetFilter assets;

  final BigInt maxAssets;

  final _i5.MultiLocation dest;

  final _i6.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DepositReserveAsset': {
          'assets': assets.toJson(),
          'maxAssets': maxAssets,
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxAssets);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size +
        const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxAssets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class ExchangeAsset extends Instruction {
  const ExchangeAsset({
    required this.give,
    required this.receive,
  });

  factory ExchangeAsset._decode(_i1.Input input) {
    return ExchangeAsset(
      give: _i10.MultiAssetFilter.codec.decode(input),
      receive: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
    );
  }

  final _i10.MultiAssetFilter give;

  final _i3.MultiAssets receive;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExchangeAsset': {
          'give': give.toJson(),
          'receive': receive.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(give);
    size = size +
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .sizeHint(receive);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      give,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      receive,
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
      assets: _i10.MultiAssetFilter.codec.decode(input),
      reserve: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
          .decode(input),
    );
  }

  final _i10.MultiAssetFilter assets;

  final _i5.MultiLocation reserve;

  final _i6.Xcm xcm;

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
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(reserve);
    size = size +
        const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      reserve,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
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
      assets: _i10.MultiAssetFilter.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
          .decode(input),
    );
  }

  final _i10.MultiAssetFilter assets;

  final _i5.MultiLocation dest;

  final _i6.Xcm xcm;

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
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size +
        const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
            .sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }
}

class QueryHolding extends Instruction {
  const QueryHolding({
    required this.queryId,
    required this.dest,
    required this.assets,
    required this.maxResponseWeight,
  });

  factory QueryHolding._decode(_i1.Input input) {
    return QueryHolding(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      assets: _i10.MultiAssetFilter.codec.decode(input),
      maxResponseWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt queryId;

  final _i5.MultiLocation dest;

  final _i10.MultiAssetFilter assets;

  final BigInt maxResponseWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryHolding': {
          'queryId': queryId,
          'dest': dest.toJson(),
          'assets': assets.toJson(),
          'maxResponseWeight': maxResponseWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxResponseWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxResponseWeight,
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
      fees: _i11.MultiAsset.codec.decode(input),
      weightLimit: _i12.WeightLimit.codec.decode(input),
    );
  }

  final _i11.MultiAsset fees;

  final _i12.WeightLimit weightLimit;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'BuyExecution': {
          'fees': fees.toJson(),
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i11.MultiAsset.codec.sizeHint(fees);
    size = size + _i12.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i11.MultiAsset.codec.encodeTo(
      fees,
      output,
    );
    _i12.WeightLimit.codec.encodeTo(
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
      value0: const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
          .decode(input),
    );
  }

  final _i6.Xcm value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() =>
      {'SetErrorHandler': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
      value0,
      output,
    );
  }
}

class SetAppendix extends Instruction {
  const SetAppendix({required this.value0});

  factory SetAppendix._decode(_i1.Input input) {
    return SetAppendix(
      value0: const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
          .decode(input),
    );
  }

  final _i6.Xcm value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() =>
      {'SetAppendix': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
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
      assets: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
      ticket: _i5.MultiLocation.codec.decode(input),
    );
  }

  final _i3.MultiAssets assets;

  final _i5.MultiLocation ticket;

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
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(ticket);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
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
      maxResponseWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  final BigInt queryId;

  final BigInt maxResponseWeight;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'SubscribeVersion': {
          'queryId': queryId,
          'maxResponseWeight': maxResponseWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxResponseWeight);
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
    _i1.CompactBigIntCodec.codec.encodeTo(
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
