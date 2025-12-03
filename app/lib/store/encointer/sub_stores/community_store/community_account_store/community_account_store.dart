import 'dart:convert';
import 'dart:typed_data';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:ew_log/ew_log.dart';

part 'community_account_store.g.dart';

/// Stores data specific to an account **and** an encointer community.
///
///
@JsonSerializable(explicitToJson: true)
class CommunityAccountStore extends _CommunityAccountStore with _$CommunityAccountStore {
  CommunityAccountStore(super.network, super.cid, super.address);

  factory CommunityAccountStore.fromJson(Map<String, dynamic> json) => _$CommunityAccountStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityAccountStoreToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

abstract class _CommunityAccountStore with Store {
  _CommunityAccountStore(this.network, this.cid, this.address);

  /// Function that writes the store to local storage.
  @JsonKey(includeFromJson: false, includeToJson: false)
  Future<void> Function()? _cacheFn;

  /// The network this store belongs to.
  final String network;

  /// The community this store belongs to.
  final CommunityIdentifier cid;

  /// The account (SS58) this store belongs to.
  final String address;

  /// Participant type if the account has registered for the next meetup.
  @observable
  ParticipantType? participantType;

  /// Contains the meetup data if the account has been assigned to a meetup in this community.
  @observable
  Meetup? meetup;

  /// Meetup `attendees` scanned during a meetup.
  @observable
  ObservableSet<String>? attendees = ObservableSet();

  /// Our vote on the number of meetup attendees
  @observable
  int? participantCountVote;

  /// This should be set to true once the attestations have been sent to chain.
  @observable
  bool? meetupCompleted = false;

  @computed
  int get scannedAttendeesCount => attendees?.length ?? 0;

  @computed
  bool get isAssigned => meetup != null;

  @computed
  bool get isRegistered => participantType != null;

  @observable
  int numberOfNewbieTicketsForBootstrapper = 0;

  @action
  void setParticipantType([ParticipantType? type]) {
    Log.d('Set participant type: $type', 'CommunityAccountStore');
    participantType = type;
    writeToCache();
  }

  @action
  void setParticipantCountVote(int vote) {
    Log.d('Set participantCountVote: $vote', 'CommunityAccountStore');
    participantCountVote = vote;
    writeToCache();
  }

  @action
  void purgeParticipantType() {
    if (participantType != null) {
      Log.d('Purging participantType.', 'CommunityAccountStore');
      participantType = null;
      writeToCache();
    }
  }

  @action
  void setMeetup(Meetup meetup) {
    Log.d('Set meetup: ${meetup.toJson()}', 'CommunityAccountStore');
    this.meetup = meetup;
    writeToCache();
  }

  @action
  void setMeetupCompleted() {
    Log.d('settingMeetupCompleted', 'CommunityAccountStore');
    meetupCompleted = true;
    writeToCache();
  }

  @action
  void clearMeetupCompleted() {
    Log.d('clearing meetupCompleted', 'CommunityAccountStore');
    meetupCompleted = false;
    writeToCache();
  }

  @action
  void purgeParticipantCountVote() {
    if (participantCountVote != null) {
      Log.d('Purging participantCountVote.', 'CommunityAccountStore');
      participantCountVote = null;
      writeToCache();
    }
  }

  @action
  void purgeMeetup() {
    if (meetup != null) {
      Log.d('Purging meetup.', 'CommunityAccountStore');
      meetup = null;
      writeToCache();
    }
  }

  @action
  void purgeParticipantsClaims() {
    Log.d('Purging participantsClaims.', 'CommunityAccountStore');
    attendees = ObservableSet();
    writeToCache();
  }

  bool containsAttendee(String attendee) {
    return attendees?.contains(attendee) ?? false;
  }

  @action
  void addAttendee(String attendee) {
    Log.d('adding participantsClaims.', 'CommunityAccountStore');

    attendees ??= ObservableSet();

    // Is a noop if the attendee is already in the set.
    attendees!.add(attendee);

    writeToCache();
  }

  /// Purges state that is only relevant for one Ceremony.
  ///
  /// This should be called when a transition to the next ceremony happens.
  @action
  void purgeCeremonySpecificState() {
    purgeParticipantsClaims();
    purgeParticipantType();
    purgeMeetup();
    clearMeetupCompleted();
  }

  @action
  Future<void> getNumberOfNewbieTicketsForBootstrapper({Uint8List? at}) async {
    // Todo: #923 This returns 5 for non-bootstrappers as it naively calculates the amount of tickets based on
    // the amount of burned tickets. This is essentially wrong and leads to workarounds that we need to do on dart side.
    numberOfNewbieTicketsForBootstrapper = await webApi.encointer.getNumberOfNewbieTicketsForBootstrapper(at: at);
  }

  void initStore(Function? cacheFn) {
    _cacheFn = cacheFn as Future<void> Function()?;
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value();
    }
  }
}
