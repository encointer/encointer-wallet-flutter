// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_account_store.dart';

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
      ..attendees = json['attendees'] != null
          ? ObservableSet<String>.of(
              (json['attendees'] as List).map((e) => e as String))
          : null
      ..participantCountVote = json['participantCountVote'] as int?
      ..meetupCompleted = json['meetupCompleted'] as bool?
      ..numberOfNewbieTicketsForBootstrapper =
          json['numberOfNewbieTicketsForBootstrapper'] as int;

Map<String, dynamic> _$CommunityAccountStoreToJson(
        CommunityAccountStore instance) =>
    <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid.toJson(),
      'address': instance.address,
      'participantType': _$ParticipantTypeEnumMap[instance.participantType],
      'meetup': instance.meetup?.toJson(),
      'attendees': instance.attendees?.toList(),
      'participantCountVote': instance.participantCountVote,
      'meetupCompleted': instance.meetupCompleted,
      'numberOfNewbieTicketsForBootstrapper':
          instance.numberOfNewbieTicketsForBootstrapper,
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
  Computed<int>? _$scannedAttendeesCountComputed;

  @override
  int get scannedAttendeesCount => (_$scannedAttendeesCountComputed ??=
          Computed<int>(() => super.scannedAttendeesCount,
              name: '_CommunityAccountStore.scannedAttendeesCount'))
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

  late final _$attendeesAtom =
      Atom(name: '_CommunityAccountStore.attendees', context: context);

  @override
  ObservableSet<String>? get attendees {
    _$attendeesAtom.reportRead();
    return super.attendees;
  }

  @override
  set attendees(ObservableSet<String>? value) {
    _$attendeesAtom.reportWrite(value, super.attendees, () {
      super.attendees = value;
    });
  }

  late final _$participantCountVoteAtom = Atom(
      name: '_CommunityAccountStore.participantCountVote', context: context);

  @override
  int? get participantCountVote {
    _$participantCountVoteAtom.reportRead();
    return super.participantCountVote;
  }

  @override
  set participantCountVote(int? value) {
    _$participantCountVoteAtom.reportWrite(value, super.participantCountVote,
        () {
      super.participantCountVote = value;
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

  late final _$numberOfNewbieTicketsForBootstrapperAtom = Atom(
      name: '_CommunityAccountStore.numberOfNewbieTicketsForBootstrapper',
      context: context);

  @override
  int get numberOfNewbieTicketsForBootstrapper {
    _$numberOfNewbieTicketsForBootstrapperAtom.reportRead();
    return super.numberOfNewbieTicketsForBootstrapper;
  }

  @override
  set numberOfNewbieTicketsForBootstrapper(int value) {
    _$numberOfNewbieTicketsForBootstrapperAtom
        .reportWrite(value, super.numberOfNewbieTicketsForBootstrapper, () {
      super.numberOfNewbieTicketsForBootstrapper = value;
    });
  }

  late final _$getNumberOfNewbieTicketsForBootstrapperAsyncAction = AsyncAction(
      '_CommunityAccountStore.getNumberOfNewbieTicketsForBootstrapper',
      context: context);

  @override
  Future<void> getNumberOfNewbieTicketsForBootstrapper() {
    return _$getNumberOfNewbieTicketsForBootstrapperAsyncAction
        .run(() => super.getNumberOfNewbieTicketsForBootstrapper());
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
  void setParticipantCountVote(int vote) {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.setParticipantCountVote');
    try {
      return super.setParticipantCountVote(vote);
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
  void purgeParticipantCountVote() {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.purgeParticipantCountVote');
    try {
      return super.purgeParticipantCountVote();
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
  void addAttendee(String attendee) {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(
        name: '_CommunityAccountStore.addAttendee');
    try {
      return super.addAttendee(attendee);
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
attendees: ${attendees},
participantCountVote: ${participantCountVote},
meetupCompleted: ${meetupCompleted},
numberOfNewbieTicketsForBootstrapper: ${numberOfNewbieTicketsForBootstrapper},
scannedAttendeesCount: ${scannedAttendeesCount},
isAssigned: ${isAssigned},
isRegistered: ${isRegistered}
    ''';
  }
}
