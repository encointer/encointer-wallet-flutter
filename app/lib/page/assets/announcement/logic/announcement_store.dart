// ignore_for_file: library_private_types_in_public_api

import 'package:ew_http/ew_http.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'announcement_store.g.dart';

class AnnouncementStore = _AnnouncementStoreBase with _$AnnouncementStore;

abstract class _AnnouncementStoreBase with Store {
  _AnnouncementStoreBase(this.ewHttp);

  final EwHttp ewHttp;

  List<Announcement> announcementsGlobal = <Announcement>[];

  List<Announcement> announcementsCommunnity = <Announcement>[];

  @observable
  String? error;

  @observable
  FailureType? failureType;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @action
  Future<void> getCommunityAnnouncements(String? cid) async {
    if (fetchStatus != FetchStatus.loading) fetchStatus = FetchStatus.loading;
    final communityAnnouncementsResponse = await ewHttp.getTypeList<Announcement>(
      'https://eldar2021.github.io/encointer/announcements/leu/announcements.json',
      fromJson: Announcement.fromJson,
    );

    communityAnnouncementsResponse.fold((l) {
      error = l.error.toString();
      fetchStatus = FetchStatus.error;
    }, (r) {
      announcementsCommunnity = r;
      fetchStatus = FetchStatus.success;
    });
  }

  @action
  Future<void> getGlobalAnnouncements() async {
    if (fetchStatus != FetchStatus.loading) fetchStatus = FetchStatus.loading;
    final globalAnnouncementsResponse = await ewHttp.getTypeList<Announcement>(
      'https://eldar2021.github.io/encointer/announcements/global/announcements.json',
      fromJson: Announcement.fromJson,
    );

    globalAnnouncementsResponse.fold((l) {
      error = l.error.toString();
      fetchStatus = FetchStatus.error;
    }, (r) {
      announcementsGlobal = r;
      fetchStatus = FetchStatus.success;
    });
  }
}
