// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i9;

import '../../sp_core/crypto/account_id32.dart' as _i8;
import '../../substrate_fixed/fixed_i128.dart' as _i6;
import '../../substrate_fixed/fixed_u128.dart' as _i7;
import '../communities/community_identifier.dart' as _i3;
import '../communities/community_metadata.dart' as _i5;
import '../communities/location.dart' as _i4;

abstract class ProposalAction {
  const ProposalAction();

  factory ProposalAction.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ProposalActionCodec codec = $ProposalActionCodec();

  static const $ProposalAction values = $ProposalAction();

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

class $ProposalAction {
  const $ProposalAction();

  AddLocation addLocation(
    _i3.CommunityIdentifier value0,
    _i4.Location value1,
  ) {
    return AddLocation(
      value0,
      value1,
    );
  }

  RemoveLocation removeLocation(
    _i3.CommunityIdentifier value0,
    _i4.Location value1,
  ) {
    return RemoveLocation(
      value0,
      value1,
    );
  }

  UpdateCommunityMetadata updateCommunityMetadata(
    _i3.CommunityIdentifier value0,
    _i5.CommunityMetadata value1,
  ) {
    return UpdateCommunityMetadata(
      value0,
      value1,
    );
  }

  UpdateDemurrage updateDemurrage(
    _i3.CommunityIdentifier value0,
    _i6.FixedI128 value1,
  ) {
    return UpdateDemurrage(
      value0,
      value1,
    );
  }

  UpdateNominalIncome updateNominalIncome(
    _i3.CommunityIdentifier value0,
    _i7.FixedU128 value1,
  ) {
    return UpdateNominalIncome(
      value0,
      value1,
    );
  }

  SetInactivityTimeout setInactivityTimeout(int value0) {
    return SetInactivityTimeout(value0);
  }

  Petition petition(
    _i3.CommunityIdentifier? value0,
    List<int> value1,
  ) {
    return Petition(
      value0,
      value1,
    );
  }

  SpendNative spendNative(
    _i3.CommunityIdentifier? value0,
    _i8.AccountId32 value1,
    BigInt value2,
  ) {
    return SpendNative(
      value0,
      value1,
      value2,
    );
  }
}

class $ProposalActionCodec with _i1.Codec<ProposalAction> {
  const $ProposalActionCodec();

  @override
  ProposalAction decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AddLocation._decode(input);
      case 1:
        return RemoveLocation._decode(input);
      case 2:
        return UpdateCommunityMetadata._decode(input);
      case 3:
        return UpdateDemurrage._decode(input);
      case 4:
        return UpdateNominalIncome._decode(input);
      case 5:
        return SetInactivityTimeout._decode(input);
      case 6:
        return Petition._decode(input);
      case 7:
        return SpendNative._decode(input);
      default:
        throw Exception('ProposalAction: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ProposalAction value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case AddLocation:
        (value as AddLocation).encodeTo(output);
        break;
      case RemoveLocation:
        (value as RemoveLocation).encodeTo(output);
        break;
      case UpdateCommunityMetadata:
        (value as UpdateCommunityMetadata).encodeTo(output);
        break;
      case UpdateDemurrage:
        (value as UpdateDemurrage).encodeTo(output);
        break;
      case UpdateNominalIncome:
        (value as UpdateNominalIncome).encodeTo(output);
        break;
      case SetInactivityTimeout:
        (value as SetInactivityTimeout).encodeTo(output);
        break;
      case Petition:
        (value as Petition).encodeTo(output);
        break;
      case SpendNative:
        (value as SpendNative).encodeTo(output);
        break;
      default:
        throw Exception(
            'ProposalAction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ProposalAction value) {
    switch (value.runtimeType) {
      case AddLocation:
        return (value as AddLocation)._sizeHint();
      case RemoveLocation:
        return (value as RemoveLocation)._sizeHint();
      case UpdateCommunityMetadata:
        return (value as UpdateCommunityMetadata)._sizeHint();
      case UpdateDemurrage:
        return (value as UpdateDemurrage)._sizeHint();
      case UpdateNominalIncome:
        return (value as UpdateNominalIncome)._sizeHint();
      case SetInactivityTimeout:
        return (value as SetInactivityTimeout)._sizeHint();
      case Petition:
        return (value as Petition)._sizeHint();
      case SpendNative:
        return (value as SpendNative)._sizeHint();
      default:
        throw Exception(
            'ProposalAction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class AddLocation extends ProposalAction {
  const AddLocation(
    this.value0,
    this.value1,
  );

  factory AddLocation._decode(_i1.Input input) {
    return AddLocation(
      _i3.CommunityIdentifier.codec.decode(input),
      _i4.Location.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// Location
  final _i4.Location value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'AddLocation': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i4.Location.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i4.Location.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddLocation && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class RemoveLocation extends ProposalAction {
  const RemoveLocation(
    this.value0,
    this.value1,
  );

  factory RemoveLocation._decode(_i1.Input input) {
    return RemoveLocation(
      _i3.CommunityIdentifier.codec.decode(input),
      _i4.Location.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// Location
  final _i4.Location value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'RemoveLocation': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i4.Location.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i4.Location.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveLocation &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class UpdateCommunityMetadata extends ProposalAction {
  const UpdateCommunityMetadata(
    this.value0,
    this.value1,
  );

  factory UpdateCommunityMetadata._decode(_i1.Input input) {
    return UpdateCommunityMetadata(
      _i3.CommunityIdentifier.codec.decode(input),
      _i5.CommunityMetadata.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// CommunityMetadataType
  final _i5.CommunityMetadata value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'UpdateCommunityMetadata': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i5.CommunityMetadata.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i5.CommunityMetadata.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateCommunityMetadata &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class UpdateDemurrage extends ProposalAction {
  const UpdateDemurrage(
    this.value0,
    this.value1,
  );

  factory UpdateDemurrage._decode(_i1.Input input) {
    return UpdateDemurrage(
      _i3.CommunityIdentifier.codec.decode(input),
      _i6.FixedI128.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// Demurrage
  final _i6.FixedI128 value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'UpdateDemurrage': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i6.FixedI128.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i6.FixedI128.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateDemurrage &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class UpdateNominalIncome extends ProposalAction {
  const UpdateNominalIncome(
    this.value0,
    this.value1,
  );

  factory UpdateNominalIncome._decode(_i1.Input input) {
    return UpdateNominalIncome(
      _i3.CommunityIdentifier.codec.decode(input),
      _i7.FixedU128.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// NominalIncomeType
  final _i7.FixedU128 value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'UpdateNominalIncome': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + _i7.FixedU128.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    _i7.FixedU128.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateNominalIncome &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class SetInactivityTimeout extends ProposalAction {
  const SetInactivityTimeout(this.value0);

  factory SetInactivityTimeout._decode(_i1.Input input) {
    return SetInactivityTimeout(_i1.U32Codec.codec.decode(input));
  }

  /// InactivityTimeoutType
  final int value0;

  @override
  Map<String, int> toJson() => {'SetInactivityTimeout': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetInactivityTimeout && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Petition extends ProposalAction {
  const Petition(
    this.value0,
    this.value1,
  );

  factory Petition._decode(_i1.Input input) {
    return Petition(
      const _i1.OptionCodec<_i3.CommunityIdentifier>(
              _i3.CommunityIdentifier.codec)
          .decode(input),
      _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// Option<CommunityIdentifier>
  final _i3.CommunityIdentifier? value0;

  /// PalletString
  final List<int> value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Petition': [
          value0?.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i3.CommunityIdentifier>(
                _i3.CommunityIdentifier.codec)
            .sizeHint(value0);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.OptionCodec<_i3.CommunityIdentifier>(
            _i3.CommunityIdentifier.codec)
        .encodeTo(
      value0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Petition &&
          other.value0 == value0 &&
          _i9.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class SpendNative extends ProposalAction {
  const SpendNative(
    this.value0,
    this.value1,
    this.value2,
  );

  factory SpendNative._decode(_i1.Input input) {
    return SpendNative(
      const _i1.OptionCodec<_i3.CommunityIdentifier>(
              _i3.CommunityIdentifier.codec)
          .decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U128Codec.codec.decode(input),
    );
  }

  /// Option<CommunityIdentifier>
  final _i3.CommunityIdentifier? value0;

  /// AccountId
  final _i8.AccountId32 value1;

  /// Balance
  final BigInt value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'SpendNative': [
          value0?.toJson(),
          value1.toList(),
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i3.CommunityIdentifier>(
                _i3.CommunityIdentifier.codec)
            .sizeHint(value0);
    size = size + const _i8.AccountId32Codec().sizeHint(value1);
    size = size + _i1.U128Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.OptionCodec<_i3.CommunityIdentifier>(
            _i3.CommunityIdentifier.codec)
        .encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpendNative &&
          other.value0 == value0 &&
          _i9.listsEqual(
            other.value1,
            value1,
          ) &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}
