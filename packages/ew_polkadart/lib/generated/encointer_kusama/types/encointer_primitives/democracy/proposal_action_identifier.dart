// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../communities/community_identifier.dart' as _i3;

abstract class ProposalActionIdentifier {
  const ProposalActionIdentifier();

  factory ProposalActionIdentifier.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ProposalActionIdentifierCodec codec = $ProposalActionIdentifierCodec();

  static const $ProposalActionIdentifier values = $ProposalActionIdentifier();

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

class $ProposalActionIdentifier {
  const $ProposalActionIdentifier();

  AddLocation addLocation(_i3.CommunityIdentifier value0) {
    return AddLocation(value0);
  }

  RemoveLocation removeLocation(_i3.CommunityIdentifier value0) {
    return RemoveLocation(value0);
  }

  UpdateCommunityMetadata updateCommunityMetadata(_i3.CommunityIdentifier value0) {
    return UpdateCommunityMetadata(value0);
  }

  UpdateDemurrage updateDemurrage(_i3.CommunityIdentifier value0) {
    return UpdateDemurrage(value0);
  }

  UpdateNominalIncome updateNominalIncome(_i3.CommunityIdentifier value0) {
    return UpdateNominalIncome(value0);
  }

  SetInactivityTimeout setInactivityTimeout() {
    return SetInactivityTimeout();
  }

  Petition petition(_i3.CommunityIdentifier? value0) {
    return Petition(value0);
  }

  SpendNative spendNative(_i3.CommunityIdentifier? value0) {
    return SpendNative(value0);
  }

  IssueSwapNativeOption issueSwapNativeOption(_i3.CommunityIdentifier value0) {
    return IssueSwapNativeOption(value0);
  }

  SpendAsset spendAsset(_i3.CommunityIdentifier? value0) {
    return SpendAsset(value0);
  }

  IssueSwapAssetOption issueSwapAssetOption(_i3.CommunityIdentifier value0) {
    return IssueSwapAssetOption(value0);
  }
}

class $ProposalActionIdentifierCodec with _i1.Codec<ProposalActionIdentifier> {
  const $ProposalActionIdentifierCodec();

  @override
  ProposalActionIdentifier decode(_i1.Input input) {
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
        return const SetInactivityTimeout();
      case 6:
        return Petition._decode(input);
      case 7:
        return SpendNative._decode(input);
      case 8:
        return IssueSwapNativeOption._decode(input);
      case 9:
        return SpendAsset._decode(input);
      case 10:
        return IssueSwapAssetOption._decode(input);
      default:
        throw Exception('ProposalActionIdentifier: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ProposalActionIdentifier value,
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
      case IssueSwapNativeOption:
        (value as IssueSwapNativeOption).encodeTo(output);
        break;
      case SpendAsset:
        (value as SpendAsset).encodeTo(output);
        break;
      case IssueSwapAssetOption:
        (value as IssueSwapAssetOption).encodeTo(output);
        break;
      default:
        throw Exception('ProposalActionIdentifier: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ProposalActionIdentifier value) {
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
        return 1;
      case Petition:
        return (value as Petition)._sizeHint();
      case SpendNative:
        return (value as SpendNative)._sizeHint();
      case IssueSwapNativeOption:
        return (value as IssueSwapNativeOption)._sizeHint();
      case SpendAsset:
        return (value as SpendAsset)._sizeHint();
      case IssueSwapAssetOption:
        return (value as IssueSwapAssetOption)._sizeHint();
      default:
        throw Exception('ProposalActionIdentifier: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class AddLocation extends ProposalActionIdentifier {
  const AddLocation(this.value0);

  factory AddLocation._decode(_i1.Input input) {
    return AddLocation(_i3.CommunityIdentifier.codec.decode(input));
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() => {'AddLocation': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddLocation && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class RemoveLocation extends ProposalActionIdentifier {
  const RemoveLocation(this.value0);

  factory RemoveLocation._decode(_i1.Input input) {
    return RemoveLocation(_i3.CommunityIdentifier.codec.decode(input));
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() => {'RemoveLocation': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveLocation && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class UpdateCommunityMetadata extends ProposalActionIdentifier {
  const UpdateCommunityMetadata(this.value0);

  factory UpdateCommunityMetadata._decode(_i1.Input input) {
    return UpdateCommunityMetadata(_i3.CommunityIdentifier.codec.decode(input));
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() => {'UpdateCommunityMetadata': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateCommunityMetadata && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class UpdateDemurrage extends ProposalActionIdentifier {
  const UpdateDemurrage(this.value0);

  factory UpdateDemurrage._decode(_i1.Input input) {
    return UpdateDemurrage(_i3.CommunityIdentifier.codec.decode(input));
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() => {'UpdateDemurrage': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateDemurrage && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class UpdateNominalIncome extends ProposalActionIdentifier {
  const UpdateNominalIncome(this.value0);

  factory UpdateNominalIncome._decode(_i1.Input input) {
    return UpdateNominalIncome(_i3.CommunityIdentifier.codec.decode(input));
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() => {'UpdateNominalIncome': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateNominalIncome && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class SetInactivityTimeout extends ProposalActionIdentifier {
  const SetInactivityTimeout();

  @override
  Map<String, dynamic> toJson() => {'SetInactivityTimeout': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is SetInactivityTimeout;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Petition extends ProposalActionIdentifier {
  const Petition(this.value0);

  factory Petition._decode(_i1.Input input) {
    return Petition(const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).decode(input));
  }

  /// Option<CommunityIdentifier>
  final _i3.CommunityIdentifier? value0;

  @override
  Map<String, Map<String, List<int>>?> toJson() => {'Petition': value0?.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).encodeTo(
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
      other is Petition && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class SpendNative extends ProposalActionIdentifier {
  const SpendNative(this.value0);

  factory SpendNative._decode(_i1.Input input) {
    return SpendNative(const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).decode(input));
  }

  /// Option<CommunityIdentifier>
  final _i3.CommunityIdentifier? value0;

  @override
  Map<String, Map<String, List<int>>?> toJson() => {'SpendNative': value0?.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).encodeTo(
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
      other is SpendNative && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class IssueSwapNativeOption extends ProposalActionIdentifier {
  const IssueSwapNativeOption(this.value0);

  factory IssueSwapNativeOption._decode(_i1.Input input) {
    return IssueSwapNativeOption(_i3.CommunityIdentifier.codec.decode(input));
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() => {'IssueSwapNativeOption': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
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
      other is IssueSwapNativeOption && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class SpendAsset extends ProposalActionIdentifier {
  const SpendAsset(this.value0);

  factory SpendAsset._decode(_i1.Input input) {
    return SpendAsset(const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).decode(input));
  }

  /// Option<CommunityIdentifier>
  final _i3.CommunityIdentifier? value0;

  @override
  Map<String, Map<String, List<int>>?> toJson() => {'SpendAsset': value0?.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    const _i1.OptionCodec<_i3.CommunityIdentifier>(_i3.CommunityIdentifier.codec).encodeTo(
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
      other is SpendAsset && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class IssueSwapAssetOption extends ProposalActionIdentifier {
  const IssueSwapAssetOption(this.value0);

  factory IssueSwapAssetOption._decode(_i1.Input input) {
    return IssueSwapAssetOption(_i3.CommunityIdentifier.codec.decode(input));
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  @override
  Map<String, Map<String, List<int>>> toJson() => {'IssueSwapAssetOption': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
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
      other is IssueSwapAssetOption && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
