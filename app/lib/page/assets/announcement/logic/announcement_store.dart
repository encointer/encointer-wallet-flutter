import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';
import 'package:encointer_wallet/data/common_services/network/api_services.dart';
import 'package:encointer_wallet/data/remote/announcements/announcements_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import 'package:encointer_wallet/models/announcement/announcement.dart';

part 'announcement_store.g.dart';

const _logTarget = 'announcement_store';

class AnnouncementConsts {
  static const baseUrl = 'https://eldar2021.github.io/encointer/announcements/';
}

// ignore: library_private_types_in_public_api
class AnnouncementStore = _AnnouncementStoreBase with _$AnnouncementStore;

abstract class _AnnouncementStoreBase with Store {
  _AnnouncementStoreBase() {
    _init();
  }
  late AnnouncementsApi _announcementsApi;

  @observable
  List<Announcement> announcementsGlobal = <Announcement>[];

  @observable
  List<Announcement> announcementsCommunnity = <Announcement>[];

  @observable
  String? error;

  @observable
  FailureType? failureType;

  @observable
  bool loading = true;

  @action
  void _init() {
    Log.d('_init', _logTarget);

    _announcementsApi = AnnouncementsApi(
      apiServices: ApiServices(
        baseUrl: AnnouncementConsts.baseUrl,
        client: http.Client(),
      ),
    );
  }

  /// On UI, we check if announcements empty or not
  @action
  void setAnnouncementsEmpty() {
    Log.d('setAnnouncementsEmpty', _logTarget);
    announcementsCommunnity = <Announcement>[];
    announcementsGlobal = <Announcement>[];
  }

  @action
  void setLoading(bool val) {
    Log.d('setLoading: val = $val', _logTarget);
    loading = val;
  }

  @action
  Future<void> getCommunityAnnouncements(String? cid) async {
    Log.d('getCommunityAnnouncements: cid = $cid', _logTarget);

    final response = await _announcementsApi.getCommunityAnnouncements(cid: cid);

    if (response is Success) {
      final data = response.data as List;
      announcementsCommunnity = data.map((e) => Announcement.fromJson(e as Map<String, dynamic>)).toList();
    } else if (response is Failure) {
      error = response.error;
      failureType = response.failureType;
    } else {
      error = 'SomethingWentWrong';
    }

    setLoading(false);
  }

  @action
  Future<void> getGlobalAnnouncements() async {
    Log.d('getAnnouncementGlobal', _logTarget);

    final response = await _announcementsApi.getGlobalAnnouncements();

    if (response is Success) {
      final data = response.data as List;
      announcementsGlobal = data.map((e) => Announcement.fromJson(e as Map<String, dynamic>)).toList();
    } else if (response is Failure) {
      error = response.error;
      failureType = response.failureType;
    } else {
      error = 'SomethingWentWrong';
    }
    setLoading(false);
  }
}
