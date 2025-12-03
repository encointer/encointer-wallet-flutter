// ignore_for_file: library_private_types_in_public_api

import 'package:ew_http/ew_http.dart';
import 'package:ew_log/ew_log.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/config/consts.dart';

part 'announcement_store.g.dart';

class AnnouncementStore = _AnnouncementStoreBase with _$AnnouncementStore;

abstract class _AnnouncementStoreBase with Store {
  _AnnouncementStoreBase(this.ewHttp);

  final EwHttp ewHttp;

  @observable
  List<Announcement> announcementsGlobal = <Announcement>[];
  @observable
  List<Announcement> announcementsCommunnity = <Announcement>[];

  @observable
  List<Announcement> announcements = <Announcement>[];

  void _update() {
    announcements = <Announcement>[];

    announcements
      ..addAll(announcementsGlobal)
      ..addAll(announcementsCommunnity)
      ..sort((a, b) => b.publishDate.compareTo(a.publishDate));
  }

  @observable
  String? error;

  @observable
  FailureType? failureType;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @action
  Future<void> getCommunityAnnouncements(
    String cid, {
    bool devMode = false,
    required String langCode,
  }) async {
    Log.d('Getting announcements for $cid', 'announcement_view');

    if (fetchStatus != FetchStatus.loading) fetchStatus = FetchStatus.loading;
    final communityAnnouncementsResponse = await ewHttp.getTypeList<Announcement>(
      '${getEncointerFeedLink(devMode: devMode)}/announcements/$cid/$langCode/announcements.json',
      fromJson: Announcement.fromJson,
    );

    await communityAnnouncementsResponse.fold((l) {
      error = l.error.toString();
      if (l.statusCode == 404) {
        Log.d('No community announcements found for cid: $cid, and langCode: $langCode', 'announcement_view');
        if (langCode != 'en') {
          // fallback to English if the app language's one is not available
          return getCommunityAnnouncements(cid, devMode: devMode, langCode: 'en');
        }

        Log.e('Error getting community announcements ${l.error}', 'announcement_view');
        fetchStatus = FetchStatus.error;
      }
    }, (r) {
      announcementsCommunnity = r;
      fetchStatus = FetchStatus.success;
    });

    _update();
  }

  @action
  Future<void> getGlobalAnnouncements({bool devMode = false, required String langCode}) async {
    if (fetchStatus != FetchStatus.loading) fetchStatus = FetchStatus.loading;
    final globalAnnouncementsResponse = await ewHttp.getTypeList<Announcement>(
      '${getEncointerFeedLink(devMode: devMode)}/announcements/global/$langCode/announcements.json',
      fromJson: Announcement.fromJson,
    );

    await globalAnnouncementsResponse.fold((l) {
      error = l.error.toString();
      if (l.statusCode == 404) {
        Log.d('No global announcements found for langCode: $langCode', 'announcement_view');
        if (langCode != 'en') {
          // fallback to English if the app language's one is not available
          return getGlobalAnnouncements(devMode: devMode, langCode: 'en');
        }

        Log.e('Error getting global announcements ${l.error}', 'announcement_view');
        fetchStatus = FetchStatus.error;
      }
    }, (r) {
      announcementsGlobal = r;
      fetchStatus = FetchStatus.success;
    });

    _update();
  }
}
