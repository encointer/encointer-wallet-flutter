// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communityAccountStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityAccountStore _$CommunityAccountStoreFromJson(
    Map<String, dynamic> json) {
  return CommunityAccountStore(
    json['network'] as String,
    json['cid'] == null
        ? null
        : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
    json['address'] as String,
  )
    ..participantType =
        _$enumDecodeNullable(_$ParticipantTypeEnumMap, json['participantType'])
    ..meetup = json['meetup'] == null
        ? null
        : Meetup.fromJson(json['meetup'] as Map<String, dynamic>)
    ..participantsClaims = json['participantsClaims'] != null
        ? ObservableMap<String, ClaimOfAttendance>.of(
            (json['participantsClaims'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(
                k,
                e == null
                    ? null
                    : ClaimOfAttendance.fromJson(e as Map<String, dynamic>)),
          ))
        : null;
}

Map<String, dynamic> _$CommunityAccountStoreToJson(
        CommunityAccountStore instance) =>
    <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid?.toJson(),
      'address': instance.address,
      'participantType': _$ParticipantTypeEnumMap[instance.participantType],
      'meetup': instance.meetup?.toJson(),
      'participantsClaims':
          instance.participantsClaims?.map((k, e) => MapEntry(k, e?.toJson())),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ParticipantTypeEnumMap = {
  ParticipantType.Bootstrapper: 'Bootstrapper',
  ParticipantType.Reputable: 'Reputable',
  ParticipantType.Endorsee: 'Endorsee',
  ParticipantType.Newbie: 'Newbie',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommunityAccountStore on _CommunityAccountStore, Store {
  Computed<dynamic> _$scannedClaimsCountComputed;

  @override
  dynamic get scannedClaimsCount => (_$scannedClaimsCountComputed ??=
          Computed<dynamic>(() => super.scannedClaimsCount,
              name: '_CommunityAccountStore.scannedClaimsCount'))
      .value;
  Computed<bool> _$isAssignedComputed;

  @override
  bool get isAssigned =>
      (_$isAssignedComputed ??= Computed<bool>(() => super.isAssigned,
              name: '_CommunityAccountStore.isAssigned'))
          .value;
  Computed<bool> _$isRegisteredComputed;

  @override
  bool get isRegistered =>
      (_$isRegisteredComputed ??= Computed<bool>(() => super.isRegistered,
              name: '_CommunityAccountStore.isRegistered'))
          .value;

  final _$meetupAtom = Atom(name: '_CommunityAccountStore.meetup');

  @override
  Meetup get meetup {
    _$meetupAtom.reportRead();
    return super.meetup;
  }

  @override
  set meetup(Meetup value) {
    _$meetupAtom.reportWrite(value, super.meetup, () {
      super.meetup = value;
    });
  }

  final _$participantsClaimsAtom =
      Atom(name: '_CommunityAccountStore.participantsClaims');

  @override
  ObservableMap<String, ClaimOfAttendance> get participantsClaims {
    _$participantsClaimsAtom.reportRead();
    return super.participantsClaims;
  }

  @override
  set participantsClaims(ObservableMap<String, ClaimOfAttendance> value) {
    _$participantsClaimsAtom.reportWrite(value, super.participantsClaims, () {
      super.participantsClaims = value;
    });
  }

  final _$_CommunityAccountStoreActionController =
      ActionController(name: '_CommunityAccountStore');

  @override
  void setParticipantType([ParticipantType type]) {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.setParticipantType');
    try {
      return super.setParticipantType(type);
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeParticipantType() {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.purgeParticipantType');
    try {
      return super.purgeParticipantType();
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetup(Meetup meetup) {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.setMeetup');
    try {
      return super.setMeetup(meetup);
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeMeetup() {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.purgeMeetup');
    try {
      return super.purgeMeetup();
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeParticipantsClaims() {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.purgeParticipantsClaims');
    try {
      return super.purgeParticipantsClaims();
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addParticipantClaim(ClaimOfAttendance claim) {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.addParticipantClaim');
    try {
      return super.addParticipantClaim(claim);
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeCeremonySpecificState() {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.purgeCeremonySpecificState');
    try {
      return super.purgeCeremonySpecificState();
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
meetup: ${meetup},
participantsClaims: ${participantsClaims},
scannedClaimsCount: ${scannedClaimsCount},
isAssigned: ${isAssigned},
isRegistered: ${isRegistered}
    ''';
  }
}
