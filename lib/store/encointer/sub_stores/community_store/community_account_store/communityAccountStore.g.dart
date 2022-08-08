// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communityAccountStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityAccountStore _$CommunityAccountStoreFromJson(
        Map<String, dynamic> json) =>
    CommunityAccountStore(
      json['network'] as String,
      CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
      json['address'] as String,
    )
      ..participantType =
          $enumDecodeNullable(_$ParticipantTypeEnumMap, json['participantType'])
      ..meetup = json['meetup'] == null
          ? null
          : Meetup.fromJson(json['meetup'] as Map<String, dynamic>)
      ..participantsClaims = json['participantsClaims'] != null
          ? ObservableMap<String, ClaimOfAttendance>.of(
              (json['participantsClaims'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  k, ClaimOfAttendance.fromJson(e as Map<String, dynamic>)),
            ))
          : null
      ..meetupCompleted = json['meetupCompleted'] as bool?;

Map<String, dynamic> _$CommunityAccountStoreToJson(
        CommunityAccountStore instance) =>
    <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid.toJson(),
      'address': instance.address,
      'participantType': _$ParticipantTypeEnumMap[instance.participantType],
      'meetup': instance.meetup?.toJson(),
      'participantsClaims':
          instance.participantsClaims?.map((k, e) => MapEntry(k, e.toJson())),
      'meetupCompleted': instance.meetupCompleted,
    };

const _$ParticipantTypeEnumMap = {
  ParticipantType.Bootstrapper: 'Bootstrapper',
  ParticipantType.Reputable: 'Reputable',
  ParticipantType.Endorsee: 'Endorsee',
  ParticipantType.Newbie: 'Newbie',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommunityAccountStore on _CommunityAccountStore, Store {
  Computed<dynamic>? _$scannedClaimsCountComputed;

  @override
  dynamic get scannedClaimsCount => (_$scannedClaimsCountComputed ??=
          Computed<dynamic>(() => super.scannedClaimsCount,
              name: '_CommunityAccountStore.scannedClaimsCount'))
      .value;
  Computed<bool>? _$isAssignedComputed;

  @override
  bool get isAssigned =>
      (_$isAssignedComputed ??= Computed<bool>(() => super.isAssigned,
              name: '_CommunityAccountStore.isAssigned'))
          .value;
  Computed<bool>? _$isRegisteredComputed;

  @override
  bool get isRegistered =>
      (_$isRegisteredComputed ??= Computed<bool>(() => super.isRegistered,
              name: '_CommunityAccountStore.isRegistered'))
          .value;

  late final _$participantTypeAtom =
      Atom(name: '_CommunityAccountStore.participantType', context: context);

  @override
  ParticipantType? get participantType {
    _$participantTypeAtom.reportRead();
    return super.participantType;
  }

  @override
  set participantType(ParticipantType? value) {
    _$participantTypeAtom.reportWrite(value, super.participantType, () {
      super.participantType = value;
    });
  }

  late final _$meetupAtom =
      Atom(name: '_CommunityAccountStore.meetup', context: context);

  @override
  Meetup? get meetup {
    _$meetupAtom.reportRead();
    return super.meetup;
  }

  @override
  set meetup(Meetup? value) {
    _$meetupAtom.reportWrite(value, super.meetup, () {
      super.meetup = value;
    });
  }

  late final _$participantsClaimsAtom =
      Atom(name: '_CommunityAccountStore.participantsClaims', context: context);

  @override
  ObservableMap<String, ClaimOfAttendance>? get participantsClaims {
    _$participantsClaimsAtom.reportRead();
    return super.participantsClaims;
  }

  @override
  set participantsClaims(ObservableMap<String, ClaimOfAttendance>? value) {
    _$participantsClaimsAtom.reportWrite(value, super.participantsClaims, () {
      super.participantsClaims = value;
    });
  }

  late final _$meetupCompletedAtom =
      Atom(name: '_CommunityAccountStore.meetupCompleted', context: context);

  @override
  bool? get meetupCompleted {
    _$meetupCompletedAtom.reportRead();
    return super.meetupCompleted;
  }

  @override
  set meetupCompleted(bool? value) {
    _$meetupCompletedAtom.reportWrite(value, super.meetupCompleted, () {
      super.meetupCompleted = value;
    });
  }

  late final _$_CommunityAccountStoreActionController =
      ActionController(name: '_CommunityAccountStore', context: context);

  @override
  void setParticipantType([ParticipantType? type]) {
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
  void setMeetupCompleted() {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.setMeetupCompleted');
    try {
      return super.setMeetupCompleted();
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMeetupCompleted() {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.clearMeetupCompleted');
    try {
      return super.clearMeetupCompleted();
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
participantType: ${participantType},
meetup: ${meetup},
participantsClaims: ${participantsClaims},
meetupCompleted: ${meetupCompleted},
scannedClaimsCount: ${scannedClaimsCount},
isAssigned: ${isAssigned},
isRegistered: ${isRegistered}
    ''';
  }
}
