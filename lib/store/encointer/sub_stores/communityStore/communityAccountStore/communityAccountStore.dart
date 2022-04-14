import 'dart:convert';

import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../../../../models/index.dart';

part 'communityAccountStore.g.dart';

/// Stores data specific to an account **and** an encointer community.
///
///
@JsonSerializable(explicitToJson: true)
class CommunityAccountStore extends _CommunityAccountStore with _$CommunityAccountStore {
  CommunityAccountStore(String network, CommunityIdentifier cid, String account) : super(network, cid, account);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CommunityAccountStore.fromJson(Map<String, dynamic> json) => _$CommunityAccountStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityAccountStoreToJson(this);
}

abstract class _CommunityAccountStore with Store {
  _CommunityAccountStore(this.network, this.cid, this.account);

  /// Function that writes the store to local storage.
  @JsonKey(ignore: true)
  Future<void> Function() cacheFn;

  /// The network this store belongs to.
  final String network;

  /// The community this store belongs to.
  final CommunityIdentifier cid;

  /// The account (SS58) this store belongs to.
  final String account;

  /// Contains the meetup data if the account has been assigned to a meetup in this community.
  @observable
  Meetup meetup;

  @action
  void setMeetup(Meetup meetup, {shouldCache = true}) {
    this.meetup = meetup;

    if (cacheFn != null && shouldCache) {
      cacheFn();
    }
  }
}
